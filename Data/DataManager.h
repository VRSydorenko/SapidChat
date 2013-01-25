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
+(void) deleteUser:(NSString*)user;
+(User*) loadUser:(NSString*)email;
+(User*) getCurrentUser;
+(void) setMsgLanguagesForCurrentUser:(NSArray*)langs;
+(void) setNewMessageLanguageFromUserLanguages:(NSArray*)languages;

+(BOOL) existsUserWithEmail:(NSString*)email;
+(ErrorCodes) registerNewUser:(User*)user password:(NSString*)password;
+(ErrorCodes)login:(NSString*)email password:(NSString*)password;
+(ErrorCodes) sendIntrigueTo:(NSString*)email withOptionalText:(NSString*)text;
+(ErrorCodes) restorePassword:(NSString*)email;

+(NSArray*) getAllDialogs;
+(NSArray*) getSavedDialogs;
+(int) getUnreadMessagesCount;
+(int) getUnreadMessagesCountForCollocutor:(NSString*)user;
+(void) resetUnreadMessagesCountForCollocutor:(NSString*)email;

+(ErrorCodes)sendMessage:(Message*)message;
+(ErrorCodes) pickNewMessage;
+(ErrorCodes) deleteMessage:(Message*)msg;

+(ErrorCodes) updateOwnNick:(NSString*)nick; // in AWS
+(void) updateOwnNickInDb:(NSString*)nick; // local db
+(ErrorCodes) updateOwnPassword:(NSString*)pass; // in AWS

+(void) requestAttachmentData:(NSString*)attachmentName delegate:(id<AttachmentDataUpdateDelegate>)delegate;

+(int) getRegularPoststampsCount;
+(int) getRegularPoststampsFromLocalBuffer;
+(void) addRegularPoststampsToLocalBuffer:(int)count;
+(int) getTotalAvailablePoststamps;

+(ErrorCodes) spendRegularPoststamps:(int)count;
+(ErrorCodes) topUpUsersPoststamps:(int)count;

@end