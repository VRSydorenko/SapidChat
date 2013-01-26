//
//  DbItemHelper.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/22/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "AmazonClientManager.h"
#import "DbItemHelper.h"
#import "DbModel.h"
#import "Message.h"
#import "DataManager.h"
#import "User.h"
#import "Utils.h"
#import "AmazonKeyChainWrapper.h"
#import "UserSettings.h"

@implementation DbItemHelper


+ (User*) prepareUser:(NSDictionary*)item{
    if (!item){
        return nil;
    }
    
    DynamoDBAttributeValue *attrVal = (DynamoDBAttributeValue*)[item valueForKey:DBFIELD_USERS_EMAIL];
    User* result = [[User alloc] init];
    result.email = attrVal.s;
    
    for (NSString* key in item.allKeys) {
        attrVal = (DynamoDBAttributeValue*)[item valueForKey:key];
        
        if ([key isEqualToString: DBFIELD_USERS_PASSWORD]){
            [AmazonKeyChainWrapper storeValueInKeyChain:attrVal.s forKey:result.email];
        }
        if ([key isEqualToString: DBFIELD_USERS_NICKNAME]){
            result.nickname = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_USERS_LANGS]){
            NSMutableArray* langs = [[NSMutableArray alloc] init];
            for (NSString* lang in attrVal.nS) {
                [langs addObject:[NSNumber numberWithInt:lang.intValue]];
            }
            result.languages = [[NSArray alloc] initWithArray:langs copyItems:YES];
        }
        if ([key isEqualToString: DBFIELD_USERS_RP]){
            result.rp = attrVal.n.intValue;
        }
        // only system user has array of blocked for intrigue emails
        if ([key isEqualToString: DBFIELD_USERS_BLOCKED_INTRIGUE_EMAILS]){
            [UserSettings setBlockedForIntrigue:attrVal.sS];
        }

     /* if ([key isEqualToString: DBFIELD_USERS_BIRTHDAY]){
            result.birthday = [NSDate dateWithTimeIntervalSince   1970:[attrVal.n intValue]];
        }
        if ([key isEqualToString: DBFIELD_USERS_SEX]){
            result.sex = [attrVal.n intValue];
        }
        if ([key isEqualToString: DBFIELD_USERS_IMG]){
            result.img = attrVal.s;
        }
      */
    }
    return result;
}

+ (Message*) prepareMessage:(NSDictionary*)item{
    if (!item){
        return nil;
    }
    
    Message* result = [[Message alloc] init];
    
    DynamoDBAttributeValue *attrVal;
    for (NSString* key in item.allKeys) {
        attrVal = (DynamoDBAttributeValue*)[item valueForKey:key];
        
        if ([key isEqualToString: DBFIELD_MSGS_TO]){
            result.to = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_MSGS_WHEN]){
            result.when = [attrVal.n intValue];
        }
        if ([key isEqualToString: DBFIELD_MSGS_FROM]){
            result.from = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_MSGS_TEXT]){
            result.text = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_MSGS_TYPE]){
            result.type = [attrVal.n intValue];
        }
        if ([key isEqualToString: DBFIELD_MSGS_LATD]){
            result.latitude = [attrVal.s doubleValue];
        }
        if ([key isEqualToString: DBFIELD_MSGS_LOND]){
            result.longitude = [attrVal.s doubleValue];
        }
        if ([key isEqualToString: DBFIELD_MSGS_ATT]){
            result.attachmentName = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_MSGS_INITIAL_MSG]){
            result.initial_message_global_timestamp = [attrVal.n intValue];
        }
    }
    
    // if message has been waiting for reply so collocutor will be: "Waits for reply..."
    if (result.to.length == 0){
        result.to = SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR;
    }
    
    return result;
}

@end
