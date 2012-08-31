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
#import "Data/User.h"

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
            result.password = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_USERS_NICKNAME]){
            result.nickname = attrVal.s;
        }
     /* if ([key isEqualToString: DBFIELD_USERS_NAME]){
            result.name = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_USERS_SURNAME]){
            result.name = attrVal.s;
        }
       
        if ([key isEqualToString: DBFIELD_USERS_BIRTHDAY]){
            result.birthday = [NSDate dateWithTimeIntervalSince1970:[attrVal.n intValue]];
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
            result.when = [NSDate dateWithTimeIntervalSince1970:[attrVal.n intValue]];
        }
        if ([key isEqualToString: DBFIELD_MSGS_FROM]){
            result.from = attrVal.s;
        }
        if ([key isEqualToString: DBFIELD_MSGS_TEXT]){
            result.text = attrVal.s;
        }
    }
    
    // if message has been waiting for reply so collocutor will be: "Waits for reply..."
    if (result.to.length == 0){
        result.to = @"Waits for reply...";
    }
    
    return result;
}

@end
