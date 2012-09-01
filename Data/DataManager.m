//
//  DbManager.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "DataManager.h"
#import "AmazonClientManager.h"
#import "DbItemHelper.h"
#import "DbModel.h"
#import "Utils.h"
#import "UserSettings.h"
#import "Message.h"
#import "Dialog.h"

@interface DataManager()

@end

@implementation DataManager

+(BOOL) existsUserWithEmail:(NSString*)email{
    DynamoDBGetItemRequest *getItemRequest = [[DynamoDBGetItemRequest alloc] init];
    getItemRequest.tableName = DBTABLE_USERS;
    DynamoDBAttributeValue* keyAttr = [[DynamoDBAttributeValue alloc] initWithS:email];
    DynamoDBKey *key = [[DynamoDBKey alloc] initWithHashKeyElement: keyAttr];
    getItemRequest.key = key;
    DynamoDBGetItemResponse *response = [[AmazonClientManager ddb] getItem:getItemRequest];
    return response.item.count != 0;
}

+(ErrorCodes) registerNewUser:(NSString*)user password:(NSString*)password{
    if ([DataManager existsUserWithEmail:user]){
        return USER_EXISTS;
    }
    @try
    {
        NSMutableDictionary* userDic = [[NSMutableDictionary alloc] init];
        
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:user] forKey:DBFIELD_USERS_EMAIL];
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:password] forKey:DBFIELD_USERS_PASSWORD];// TODO: crypt pass
                    
        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_USERS andItem:userDic];
        DynamoDBPutItemResponse *response = nil;
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
    } @catch (NSException *exception) {
        NSLog(@"SapidChat :: Exception registering user: %@", exception);
        return ERROR;
    }
    return OK;
}

+(ErrorCodes)login:(NSString*)email password:(NSString*)password{
    ErrorCodes emailvalidation = [Utils validateEmail:email];
    if (emailvalidation == OK){
        if ([email isEqualToString:[UserSettings getEmail]]){//login with saved data
            if ([password isEqualToString:[UserSettings getPassword]]){
                return OK;
            }
        }
        DynamoDBGetItemResponse *response = nil;
        @try {
            // login
            DynamoDBGetItemRequest *getItemRequest = [[DynamoDBGetItemRequest alloc] init];
            getItemRequest.tableName = DBTABLE_USERS;
            DynamoDBAttributeValue* keyAttr = [[DynamoDBAttributeValue alloc] initWithS:email];
            DynamoDBKey *key = [[DynamoDBKey alloc] initWithHashKeyElement: keyAttr];
            getItemRequest.key = key;
            response = [[AmazonClientManager ddb] getItem:getItemRequest];
        }
        @catch (AmazonServiceException *exception) {
            return AMAZON_SERVICE_ERROR;
        }
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
        if (response.item.count == 0){
            return NO_SUCH_USER;
        }
        User* user = [DbItemHelper prepareUser:response.item];
        if (![user.password isEqualToString:password]){
            return WRONG_PASSWORD;
        }
    } else {
        return emailvalidation;
    }
    [UserSettings setEmail:email];
    [UserSettings setPassword:password];
    return OK;
}

+(NSArray*) getDialogs:(NSString*)user{
    return [Utils buildDialogsOfUser:user msgs:[self loadAllMessages:user]];
}

+(void) deleteDialog:(Dialog*)dialog{
    for (Message* msg in [dialog getSortedMessages]) {
        [UserSettings deleteMessage:msg];
    }
}

// internal methods

+(NSArray*)loadAllMessages:(NSString*)user{
    // load and save new messages
    NSMutableArray* messages = [[NSMutableArray alloc] initWithArray:[self loadNewMessages:user]];
    for (Message* newMsg in messages) {
        [UserSettings saveMessage:newMsg isNewIncome:[user isEqualToString:newMsg.to]];
    }
    
    // return messages from the local store
    return [self loadSavedMessages];
}

+(NSArray*) loadNewMessages:(NSString*)user{
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    
    DynamoDBAttributeValue* hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:user];
    DynamoDBAttributeValue* rangeKeyAttrIncome = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", [UserSettings getLastInMsgTimestamp]]];
    DynamoDBAttributeValue* rangeKeyAttrOutgoing = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", [UserSettings getLastOutMsgTimestamp]]];
    
    DynamoDBQueryRequest* request;
    DynamoDBQueryResponse* response = nil;
        
    DynamoDBCondition* conditionIn = [[DynamoDBCondition alloc] init];
    conditionIn.comparisonOperator = @"GT";
    [conditionIn addAttributeValueList:rangeKeyAttrIncome];
    
    DynamoDBCondition* conditionOut = [[DynamoDBCondition alloc] init];
    conditionOut.comparisonOperator = @"GT";
    [conditionOut addAttributeValueList:rangeKeyAttrOutgoing];
    
    @try {
        // sent messages
        request  = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andHashKeyValue:hashKeyAttr];
        request.rangeKeyCondition = conditionOut;
        response = [[AmazonClientManager ddb] query:request];
        if (response){
            for (NSDictionary* item in response.items) {
                [messages addObject:[DbItemHelper prepareMessage:item]];
            }
            response = nil;
        }
     
        // received messages
        request  = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_RECEIVED andHashKeyValue:hashKeyAttr];
        request.rangeKeyCondition = conditionIn;
        response = [[AmazonClientManager ddb] query:request];
        if (response){
            for (NSDictionary* item in response.items) {
                [messages addObject:[DbItemHelper prepareMessage:item]];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"SapidChat :: Exception getting dialogs: %@", exception);
    }
    return messages;
}

+(NSArray*)loadSavedMessages{
    return [UserSettings getMessages];
}

+(ErrorCodes) sendMessage:(NSString*) msgText{
    if (msgText.length == 0){
        return TEXT_NOT_SPECIFIED;
    }
    
    int timestamp = (int)[NSDate timeIntervalSinceReferenceDate];
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msgText] forKey:DBFIELD_MSGS_TEXT];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[UserSettings getEmail]] forKey:DBFIELD_MSGS_FROM];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", timestamp]] forKey:DBFIELD_MSGS_WHEN];
    
    // TODO: do it in a batch!
    @try {
        // add to sent messages table
        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andItem:msgDic];
        DynamoDBPutItemResponse *response = nil;
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
        response = nil;
        
        // add to the bank table
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", ENGLISH]] forKey:DBFIELD_MSGS_BANK_LANG];
        
        request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andItem:msgDic];
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }

    
    return OK;
}
+(ErrorCodes) sendMessage:(NSString*) message to:(NSString*)collocutor{
    ErrorCodes result = OK;
    
    return result;
}

@end
