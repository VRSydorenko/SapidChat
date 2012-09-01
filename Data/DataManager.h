//
//  DbManager.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSiOSSDK/DynamoDB/AmazonDynamoDBClient.h>
#import "DbModel.h"
#import "Message.h"
#import "Dialog.h"

@interface DataManager : NSObject{
}

+(BOOL) existsUserWithEmail:(NSString*)email;
+(ErrorCodes) registerNewUser:(NSString*)user password:(NSString*)password;
+(ErrorCodes)login:(NSString*)email password:(NSString*)password;
+(NSArray*) getDialogs:(NSString*)user;
+(void) deleteDialog:(Dialog*)dialog;
+(ErrorCodes) sendMessage:(NSString*) message;
+(ErrorCodes) sendMessage:(NSString*) message to:(NSString*)collocutor;

@end
