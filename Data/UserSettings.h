//
//  UserSettings.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/28/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

#define SYS_HAS_LAUNCHED @"sys_has_launched"

#define PURCHASE_PREMIUM_UNLOCKED @"purchase_premium_unlocked"

#define DEF_DATEFORMAT @"YYYY.MM.dd"
#define DEF_TIMEFORMAT @"HH:mm"

#define SETTINGS_DATEFORMAT @"defs_dateFormat"
#define SETTINGS_TIMEFORMAT @"defs_timeFormat"
#define SETTINGS_MEASURE_SYS @"defs_measure_sys"
#define CURRENTLY_LOGGED_EMAIL @"defs_savedEmail"
#define LAST_READ_SYS_MSG_TIME @"defs_savedLastReadSysTime_" // prefix

#define SETTINGS_SAVED_NEWMSG_LANG @"defs_savedNewMsgLang"
#define SETTINGS_SAVED_APP_LANG @"defs_savedAppLang"

@interface UserSettings : NSObject
+(NSString*) getDateFormat;
+(void) setDateFormat:(NSString*)format;

+(NSString*) getTimeFormat;
+(void) setTimeFormat:(NSString*)format;

+(NSString*) getEmail;
+(void) setEmail:(NSString*)email;

+(NSArray*)getAppSupportedLanguages;
+(int) getAppLanguage;
+(void) setAppLanguage:(int) language;

+(int) getNewMessagesLanguage;
+(void) setNewMessagesLanguage:(int) language;

+(int) getLastReadSystemMessageTimestamp;
+(void) setLastReadSystemMessageTimestamp:(int)timestamp;

+(bool) hasLaunched;
+(void) setHasLaunched;

+(bool) premiumUnlocked;
+(void) setPremiumUnlocked;

@end
