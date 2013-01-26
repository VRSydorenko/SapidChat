//
//  UserSettings.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/28/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "UserSettings.h"
#import "Utils.h"

@implementation UserSettings

+(NSString*) userSpecKey:(NSString*)origKey{ // private
    return [NSString stringWithFormat:@"%@_%@", [UserSettings getEmail], origKey];
}

+ (NSString*) getDateFormat{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:[self userSpecKey:SETTINGS_DATEFORMAT]];
    if (!result){
        return DEF_DATEFORMAT;
    }
    return result;
}
+(void) setDateFormat:(NSString*)format{
    [[NSUserDefaults standardUserDefaults] setValue:format forKey:[self userSpecKey:SETTINGS_DATEFORMAT]];
}

+(NSString*) getTimeFormat{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:[self userSpecKey:SETTINGS_TIMEFORMAT]];
    if (!result){
        return DEF_TIMEFORMAT;
    }
    return result;
}
+(void) setTimeFormat:(NSString*)format{
    [[NSUserDefaults standardUserDefaults] setValue:format forKey:[self userSpecKey:SETTINGS_TIMEFORMAT]];
}

+(NSString*) getEmail{
    return [(NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:CURRENTLY_LOGGED_EMAIL] lowercaseString];
}
+(void) setEmail:(NSString*)email{
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:CURRENTLY_LOGGED_EMAIL];
}

+(NSArray*) getBlockedForIntrigue{
    NSArray* a = (NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:BLOCKED_FOR_INTRIGUE];
    return  a;
}
+(void) setBlockedForIntrigue:(NSArray*)emails{
    [[NSUserDefaults standardUserDefaults] setValue:emails forKey:BLOCKED_FOR_INTRIGUE];
}

+(int) getUnreadMessagesCountForCollocutor:(NSString*)collocutor{
    NSString* stringCount =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[self userSpecKey:collocutor]];
    if (!stringCount){
        return 0;
    }
    return [stringCount intValue];
}
+(void) incrementUnreadMessagesCountForCollocutor:(NSString*)collocutor{
    int currentCount = [self getUnreadMessagesCountForCollocutor:collocutor];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", currentCount + 1] forKey:[self userSpecKey:collocutor]];
}

+(int) getAppLanguage{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    int result = (int)[defaults integerForKey:SETTINGS_SAVED_APP_LANG];
    if (!result){
        return 2; // actually it is the first launch
    }
    return result;
}

+(void) setAppLanguage:(int) language{
    [[NSUserDefaults standardUserDefaults] setInteger:language forKey:SETTINGS_SAVED_APP_LANG];
}

// languages which can be chosen as application language
+(NSArray*)getAppSupportedLanguages{
    return [[NSMutableArray alloc] initWithObjects:@"2", @"10", nil]; // localization!!!
}

+(int) getNewMessagesLanguage{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:SETTINGS_SAVED_NEWMSG_LANG];
}

+(void) setNewMessagesLanguage:(int) language{
    [[NSUserDefaults standardUserDefaults] setInteger:language forKey:SETTINGS_SAVED_NEWMSG_LANG];
}

+(int) getLastReadSystemMessageTimestamp{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%@%@", LAST_READ_SYS_MSG_TIME, [UserSettings getEmail]]];
}
+(void) setLastReadSystemMessageTimestamp:(int)timestamp{
    [[NSUserDefaults standardUserDefaults] setInteger:timestamp forKey:[NSString stringWithFormat:@"%@%@", LAST_READ_SYS_MSG_TIME, [UserSettings getEmail]]];
}

+(bool) hasLaunched{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SYS_HAS_LAUNCHED];
}

+(void) setHasLaunched{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SYS_HAS_LAUNCHED];
}

+(bool) premiumUnlocked{
    return [[NSUserDefaults standardUserDefaults] boolForKey:PURCHASE_PREMIUM_UNLOCKED];
}
+(void) setPremiumUnlocked{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PURCHASE_PREMIUM_UNLOCKED];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
