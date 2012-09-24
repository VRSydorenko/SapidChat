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

+(ErrorCodes) registerNewUser:(User*)user{
    if ([DataManager existsUserWithEmail:user.email]){
        return USER_EXISTS;
    }
    @try
    {
        NSMutableDictionary* userDic = [[NSMutableDictionary alloc] init];
        
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:user.email] forKey:DBFIELD_USERS_EMAIL];
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:user.password] forKey:DBFIELD_USERS_PASSWORD];// TODO: crypt pass
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:user.nickname] forKey:DBFIELD_USERS_NICKNAME];
        NSMutableArray* langs = [[NSMutableArray alloc] init];
        for (NSNumber* lang in user.languages) {
            [langs addObject:lang.stringValue];
        }
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithNS:langs] forKey:DBFIELD_USERS_LANGS];

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

+(NSArray*) getDialogs{
    return [Utils buildDialogsOfMsgs:[self loadAllMessages]];
}

+(void) deleteDialog:(Dialog*)dialog{
    for (Message* msg in [dialog getSortedMessages]) {
        [UserSettings deleteMessage:msg];
    }
}

+(ErrorCodes)sendMessage:(Message*)message{
    if (message.text.length == 0){
        return TEXT_NOT_SPECIFIED;
    }
    if (!message.to){
        return [self sendMessageToBank:message];
    } else {
        return [self sendMessageToCollocutor:message];
    }
}

+(ErrorCodes) pickNewMessage:(NSString*) me{
    ErrorCodes result = OK;
    Message* msg = nil;
    
    do {
        // load new message from bank
        result = [self getOneMessageFromBank:me message:&msg];
        if (result != OK){
            return result;
        }
        
        // delete it from the bank
        result = [self deleteOneMessageFromBank:me rangeKey:msg.when/*carefully*/ deletedMessage:&msg];
        if (result != OK){
            if (result == SYSTEM_NO_SUCH_MESSAGE){
                msg = nil; // continue
            } else {
                return result;
            }
        } else { // deleted OK
            result = [self updateNewMessageInSenderTable:msg];
            if (result != OK){
                return result;
            }
            result = [self placeNewMessageToReceived:msg];
        }
    } while (!msg);
    
    
    return result;
}

// internal methods

+(NSArray*)loadAllMessages{
    // load and save new messages
    NSMutableArray* messages = [[NSMutableArray alloc] initWithArray:[self loadNewMessages]];
    for (Message* newMsg in messages) {
        BOOL isNewIncome = [[UserSettings getEmail] isEqualToString:newMsg.to];
        [UserSettings saveMessage:newMsg isNewIncome:isNewIncome];
    }
    
    // return messages from the local store
    return [UserSettings getSavedMessages];
}

+(NSArray*) loadNewMessages{
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    
    DynamoDBAttributeValue* hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[UserSettings getEmail]];
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
        //int consumedUnits = response.consumedCapacityUnits.intValue;
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

+(ErrorCodes) sendMessageToBank:(Message*) msg{
    if (![msg.from isEqualToString:[UserSettings getEmail]]){
        return ERROR;
    }
    
    int timestamp =  [Utils toGlobalTimestamp:msg.when];
    msg.when = timestamp;
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.text] forKey:DBFIELD_MSGS_TEXT];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.from] forKey:DBFIELD_MSGS_FROM];
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

    msg.to = SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR;
    [UserSettings saveMessage:msg isNewIncome:NO];
    
    return OK;
}

+(ErrorCodes) sendMessageToCollocutor:(Message*)message{
    if (![message.from isEqualToString:[UserSettings getEmail]]){
        return ERROR;
    }
    
    int timestamp =  [Utils toGlobalTimestamp:message.when];
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.text] forKey:DBFIELD_MSGS_TEXT];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.from] forKey:DBFIELD_MSGS_FROM];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.to] forKey:DBFIELD_MSGS_TO];
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
        
        // add to the collocutor's received table
        if (message.initial_message_global_timestamp > 0){
            DynamoDBAttributeValue *n = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", message.initial_message_global_timestamp]];
            [msgDic setObject:n forKey:DBFIELD_MSGS_INITIAL_MSG];
        }
        
        request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_RECEIVED andItem:msgDic];
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    
    [UserSettings saveMessage:message isNewIncome:NO];
    
    return OK;
}

+(ErrorCodes) getOneMessageFromBank:(NSString*)me message:(Message**)pickedUpMsg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", ENGLISH]];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:@"0"];
    
    DynamoDBQueryRequest* queryRequest = nil;
    DynamoDBQueryResponse* queryResponse = nil;
    
    DynamoDBCondition* condition = nil;
    
    // query one entry from the bank table
    queryRequest = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andHashKeyValue:hashKeyAttr];
    queryRequest.limit = [NSNumber numberWithInt:1];
    
    do {
        condition = [[DynamoDBCondition alloc] init];
        condition.comparisonOperator = @"GT";
        [condition addAttributeValueList:rangeKeyAttr];
        queryRequest.rangeKeyCondition = condition;
        
        @try {
            queryResponse = [[AmazonClientManager ddb] query:queryRequest];
        }
        @catch (NSException *exception) {
            return AMAZON_SERVICE_ERROR;
        }
        
        if (!queryResponse){
            return ERROR;
        }
        if (queryResponse.items.count == 0){
            return NO_MESSAGES_TO_PICKUP;
        }
        
        *pickedUpMsg = [DbItemHelper prepareMessage:[queryResponse.items objectAtIndex:0]];
        if (![(*pickedUpMsg).from isEqualToString:me]){ // not interested in own messages
            return OK;
        } else { // if own message loaded then re-run query with new start point and condition
            rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", (*pickedUpMsg).when]];
            condition = nil;
        }
    } while (!condition); // can be just while(YES)
}

+(ErrorCodes) deleteOneMessageFromBank:(NSString*)me rangeKey:(int)when deletedMessage:(Message**)deletedMsg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", ENGLISH]];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", when]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr andRangeKeyElement:rangeKeyAttr];
    
    DynamoDBDeleteItemResponse *response = nil;
    
    DynamoDBDeleteItemRequest *delRequest = [[DynamoDBDeleteItemRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andKey:key];
    [delRequest setReturnValues:@"ALL_OLD"];
    @try{
        response = [[AmazonClientManager ddb] deleteItem:delRequest];
    }
    @catch(NSException *exception){
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    if (response.attributes.count == 0){
        return SYSTEM_NO_SUCH_MESSAGE;
    }
    *deletedMsg = [DbItemHelper prepareMessage:response.attributes];
    // results customizations:
    (*deletedMsg).to = me;
    
    return OK;
}

// me = msg.to
+(ErrorCodes) placeNewMessageToReceived:(Message*)msg{
    int timestamp = msg.when;
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.text] forKey:DBFIELD_MSGS_TEXT];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.from] forKey:DBFIELD_MSGS_FROM];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.to] forKey:DBFIELD_MSGS_TO];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", timestamp]] forKey:DBFIELD_MSGS_WHEN];
    
    @try {
        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_RECEIVED andItem:msgDic];
        DynamoDBPutItemResponse *response = [[AmazonClientManager ddb] putItem:request];;
        if (!response){
            return ERROR;
        }
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    
    return OK;
}

// sender = msg.from
+(ErrorCodes) updateNewMessageInSenderTable:(Message*)msg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:msg.from];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", msg.when]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr andRangeKeyElement:rangeKeyAttr];
    
    DynamoDBAttributeValue *attrValue = [[DynamoDBAttributeValue alloc] initWithS:msg.to];
    DynamoDBAttributeValueUpdate *attrUpdate = [[DynamoDBAttributeValueUpdate alloc] initWithValue:attrValue andAction:@"PUT"];
    
    NSMutableDictionary* updatesDict = [NSMutableDictionary dictionaryWithObject:attrUpdate forKey:DBFIELD_MSGS_TO];
    
    DynamoDBUpdateItemRequest *updateRequest = [[DynamoDBUpdateItemRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andKey:key andAttributeUpdates:updatesDict];
    [updateRequest setReturnValues:@"UPDATED_NEW"];
    
    DynamoDBUpdateItemResponse *response = nil;
    @try {
        response = [[AmazonClientManager ddb] updateItem:updateRequest];
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    if (response.attributes.count == 0){
        return SYSTEM_NO_SUCH_MESSAGE;
    }
    /*if ([response attributesValueForKey:DBFIELD_MSGS_TO].s != msg.to){
        return ERROR;
    }*/    
    return OK;
}

/*+(int)getGlobalTimestamp{
    return (int)[[Utils toGlobalTime:[NSDate date]] timeIntervalSinceReferenceDate];
}*/

@end
