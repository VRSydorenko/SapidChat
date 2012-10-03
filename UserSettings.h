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

#define PURCHASE_INTRIGUE_UNLOCKED @"purchase_intrigue_unlocked"

#define DEF_DATEFORMAT @"YYYY.MM.dd"
#define DEF_TIMEFORMAT @"HH:mm"

#define SETTINGS_DATEFORMAT @"defs_dateFormat"
#define SETTINGS_TIMEFORMAT @"defs_timeFormat"
#define SETTINGS_TIMEZONE @"defs_timeZone"
#define SETTINGS_SAVECREDENTIALS @"defs_saveCredentials"
#define CURRENTLY_LOGGED_EMAIL @"defs_savedEmail"

#define SETTINGS_SAVED_CRED_PASS @"defs_savedPass"
#define SETTINGS_SAVED_APP_LANG @"defs_savedAppLang"

@interface UserSettings : NSObject
+(NSString*) getDateFormat;
+(void) setDateFormat:(NSString*)format;

+(NSString*) getTimeFormat;
+(void) setTimeFormat:(NSString*)format;

+(NSString*) getTimeZone;
+(void) setTimeZone:(NSString*)timezone;

+(BOOL) getSaveCredentials;
+(void) setSaveCredentials:(BOOL)save;

+(NSString*) getEmail;
+(void) setEmail:(NSString*)email;

+(NSArray*)getAppSupportedLanguages;
+(int) getAppLanguage;
+(void) setAppLanguage:(int) language;

+(bool) hasLaunched;
+(void) setHasLaunched;

+(bool) intrigueUnlocked;
+(void) setIntrigueUnlocked;

@end
