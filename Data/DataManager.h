//
//  DbManager.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbModel.h"
#import "Message.h"
#import "User.h"
#import "AppDelegate.h"
#import "PurchaseManager.h"

@interface DataManager : NSObject{
}

+(void) saveUser:(User*)user;
+(User*) loadUser:(NSString*)email;
+(User*) getCurrentUser;
+(void) setMsgLanguagesForCurrentUser:(NSArray*)langs;
+(void) setNewMessageLanguageFromUserLanguages:(NSArray*)languages;

+(BOOL) existsUserWithEmail:(NSString*)email;
+(ErrorCodes) registerNewUser:(User*)user password:(NSString*)password;
+(ErrorCodes)login:(NSString*)email password:(NSString*)password;
+(ErrorCodes) sendIntrigueTo:(NSString*)email;

+(NSArray*) getDialogs;
+(int) getUnreadMessagesCount;
+(void) resetUnreadMessagesCountForCollocutor:(NSString*)email;

+(ErrorCodes)sendMessage:(Message*)message;
+(ErrorCodes) pickNewMessage;
+(ErrorCodes) deleteMessage:(Message*)msg;

+(int) getRegularPoststampsCount;
+(int) getRegularPoststampsFromLocalBuffer;
+(int) getBonusPoststampsCount;
+(int) getBonusPoststampsFromLocalBuffer;
+(void) addRegularPoststampsToLocalBuffer:(int)count;
+(void) addBonusPoststampsToLocalBuffer:(int)count;

+(ErrorCodes) spendRegularPoststamps:(int)count;
+(ErrorCodes) spendBonusPoststamps:(int)count;

@end