//
//  UserSettings.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/28/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

#define SYS_SAVED_MESSAGES_COUNT @"sys_saved_msgs_count"
#define SYS_UNREAD_MSGS_COUNT @"sys_unread_msgs_cout"
#define SYS_LAST_INMSG_TIMESTAMP @"sys_last_inmsg_timestamp"
#define SYS_LAST_OUTMSG_TIMESTAMP @"sys_last_outmsg_timestamp"

#define DEF_DATEFORMAT @"YYYY.MM.dd"
#define DEF_TIMEFORMAT @"HH:mm"

#define SETTINGS_DATEFORMAT @"defs_dateFormat"
#define SETTINGS_TIMEFORMAT @"defs_timeFormat"
#define SETTINGS_TIMEZONE @"defs_timeZone"
#define SETTINGS_NICKNAME @"defs_nickname"
#define SETTINGS_SAVECREDENTIALS @"defs_saveCredentials"
#define SETTINGS_SAVED_CRED_EMAIL @"defs_savedEmail"
#define SETTINGS_SAVED_CRED_PASS @"defs_savedPass"
// prefix for saved msg languages (defs_msg_lang_1,2,3)
#define SETTINGS_MSG_LANGS_ @"defs_msg_lang_"
// prefix for saved app languages (defs_app_lang_1,2,3)
#define SETTINGS_APP_LANGS_ @"defs_app_lang_"
#define SETTINGS_SAVED_APP_LANG @"defs_savedAppLang"

@interface UserSettings : NSObject
+(NSString*) getDateFormat;
+(void) setDateFormat:(NSString*)format;

+(NSString*) getTimeFormat;
+(void) setTimeFormat:(NSString*)format;

+(NSString*) getTimeZone;
+(void) setTimeZone:(NSString*)timezone;

+(int) getLastInMsgTimestamp;
+(void) setLastInMsgTimestamp:(int)timestamp;
+(int) getLastOutMsgTimestamp;
+(void) setLastOutMsgTimestamp:(int)timestamp;

+(NSString*) getNickname;
+(void) setNickname:(NSString*)nick;

+(BOOL) getSaveCredentials;
+(void) setSaveCredentials:(BOOL)save;

+(NSString*) getEmail;
+(void) setEmail:(NSString*)email;

+(NSString*) getPassword;
+(void) setPassword:(NSString*)pasword;

+(int) getUnreadMessagesCount;
+(int) getUnreadMessagesCountForCollocutor:(NSString*)collocutor;
+(void) resetUnreadMessagesCountForCollocutor:(NSString*)collocutor;

+(BOOL) knowLanguage:(int) lang;
+(void) setKnowlege:(BOOL)know forLanguage:(int)lang;

+(int) getAppLanguage;
+(void) setAppLanguage:(int) language;

// data operations
+(NSArray*) getSavedMessages;
+(void) saveMessage:(Message*)message isNewIncome:(BOOL)yes;
+(void) deleteMessage:(Message*)message;
+(void) saveLanguages:(NSArray*) languages;
+(NSArray*) getLanguages;

@end
