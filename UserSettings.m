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

+(NSString*) getTimeZone{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:[self userSpecKey:SETTINGS_TIMEZONE]];
    if (!result){
        return [NSTimeZone defaultTimeZone].name;
    }
    return result;
}
+(void) setTimeZone:(NSString*)timezone{
    [[NSUserDefaults standardUserDefaults] setValue:timezone forKey:[self userSpecKey:SETTINGS_TIMEZONE]];
}

+(int) getLastInMsgTimestamp{
    NSString* stringTimestamp =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[self userSpecKey:SYS_LAST_INMSG_TIMESTAMP]];
    if (!stringTimestamp){
        return 0;
    }
    return [stringTimestamp intValue];
}
+(void) setLastInMsgTimestamp:(int)timestamp{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", timestamp] forKey:[self userSpecKey:SYS_LAST_INMSG_TIMESTAMP]];
}

+(int) getLastOutMsgTimestamp{
    NSString* stringTimestamp =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[self userSpecKey:SYS_LAST_OUTMSG_TIMESTAMP]];
    if (!stringTimestamp){
        return 0;
    }
    return [stringTimestamp intValue];
}
+(void) setLastOutMsgTimestamp:(int)timestamp{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", timestamp] forKey:[self userSpecKey:SYS_LAST_OUTMSG_TIMESTAMP]];
}

+(NSString*) getNickname{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:[self userSpecKey:SETTINGS_NICKNAME]];
    if (!result){
        return @"";
    }
    return result;
}
+(void) setNickname:(NSString *)nick{
    [[NSUserDefaults standardUserDefaults] setValue:nick forKey:[self userSpecKey:SETTINGS_NICKNAME]];
}

+ (BOOL) getSaveCredentials{
    return (BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:[self userSpecKey:SETTINGS_SAVECREDENTIALS]];
}
+ (void) setSaveCredentials:(BOOL)save{
    [[NSUserDefaults standardUserDefaults] setBool:save forKey:[self userSpecKey:SETTINGS_SAVECREDENTIALS]];
}

+(NSString*) getEmail{
    return (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_SAVED_CRED_EMAIL];
}
+(void) setEmail:(NSString*)email{
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:SETTINGS_SAVED_CRED_EMAIL];
}

+(NSString*) getPassword{
    return (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[self userSpecKey:SETTINGS_SAVED_CRED_PASS]];
}
+(void) setPassword:(NSString*)password{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:[self userSpecKey:SETTINGS_SAVED_CRED_PASS]];
}

+(int) getUnreadMessagesCount{
    NSString* stringCount =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[self userSpecKey:SYS_UNREAD_MSGS_COUNT]];
    if (!stringCount){
        return 0;
    }
    return [stringCount intValue];
}
+(void) setUnreadMessagesCount:(int)count{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", count] forKey:[self userSpecKey:SYS_UNREAD_MSGS_COUNT]];
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
+(void) resetUnreadMessagesCountForCollocutor:(NSString*)collocutor{
    int oldValue = [self getUnreadMessagesCountForCollocutor:collocutor];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self userSpecKey:collocutor]];
    if (oldValue > 0){
        [self setUnreadMessagesCount:[self getUnreadMessagesCount] - oldValue];// update general unread count
    }
}

+(BOOL) knowLanguage:(int) lang{
    NSString* key = [NSString stringWithFormat:@"%@%d", SETTINGS_MSG_LANGS_, lang];
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+(void) setKnowlege:(BOOL)know forLanguage:(int)lang{
    NSString* key = [NSString stringWithFormat:@"%@%d", SETTINGS_MSG_LANGS_, lang];
    [[NSUserDefaults standardUserDefaults] setBool:know forKey:key];
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
+(NSArray*)getAppLanguages{
    return [[NSMutableArray alloc] initWithObjects:@"2", @"10", nil]; // localization!!!
}

+(bool) hasLaunched{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SYS_HAS_LAUNCHED];
}

+(void) setHasLaunched:(bool)launched{
    [[NSUserDefaults standardUserDefaults] setBool:launched forKey:SYS_HAS_LAUNCHED];
}

// data operations

+(NSArray*) getSavedMessages{
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    for (int msgIndex = 1; YES; msgIndex++) { // starts from 1!
        Message* msg = [self getMessageFromSlot:msgIndex];
        if (!msg){
            break;
        }
        [messages addObject:msg];
    }
    return messages;
}

+(void) saveMessage:(Message*)message isNewIncome:(BOOL)yes{
    int newMessageNumber = [self getSavedMessagesCount] + 1;
    
    [self saveMessage:message inSlot:newMessageNumber];
    [self setSavedMessagesCount:newMessageNumber]; // update messages count
    
    if (yes){
        [self setLastInMsgTimestamp:message.when]; // save last IN mesage time
        [self setUnreadMessagesCount:[self getUnreadMessagesCount] + 1]; // update unread messages count
        [self incrementUnreadMessagesCountForCollocutor:message.from];
        if (message.initial_message_global_timestamp > 0){
            [self updateCollocutor:message.from ofExistingMessage:message.initial_message_global_timestamp];
        }
    } else {
        [self setLastOutMsgTimestamp:message.when]; // save last OUT mesage time
    }
}

+(void) deleteMessage:(Message*)message{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for (int msgIndex=1; msgIndex<=[self getSavedMessagesCount]; msgIndex++) {
        NSString* whenKey = [Utils getSettingsKeyWHEN:msgIndex];
        NSTimeInterval whenInterval = (NSTimeInterval)[defaults doubleForKey:whenKey];
        if (whenInterval == message.when){
            [self deleteMessageInSlot:msgIndex];
            [self setSavedMessagesCount:[self getSavedMessagesCount] - 1]; // update messages count
            [self moveLastMessageToSlot:msgIndex]; // fill the gap with the last message
            break;
        }
    }
}

+(void) saveLanguages:(NSArray*) languages{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i < LANG_COUNT; i++){
        NSString* key = [NSString stringWithFormat:@"%@%d", SETTINGS_MSG_LANGS_, i];
        [defaults setBool:[languages containsObject:[NSNumber numberWithInt:i]] forKey:key];
    }
}

+(NSArray*) getLanguages{
    NSMutableArray* langs = [[NSMutableArray alloc] init];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i < LANG_COUNT; i++){
        NSString* key = [NSString stringWithFormat:@"%@%d", SETTINGS_MSG_LANGS_, i];
        if ([defaults boolForKey:key]){
            [langs addObject:[NSNumber numberWithInt:i]];
        }
    }
    return langs;
}

// internal methods

+(void)updateCollocutor:(NSString*)collocutor ofExistingMessage:(int)globalInitialMessagesTimestamp{
    for (int ndx = 1; YES; ndx++) {
        Message* msg = [self getMessageFromSlot:ndx];
        if (!msg){
            break;
        }
        if (![msg.to isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR]){
            continue;
        }
        if (msg.when == globalInitialMessagesTimestamp){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:collocutor forKey:[Utils getSettingsKeyTO:ndx]];
            break;
        }
    }
}

+(void)saveMessage:(Message*)message inSlot:(int)slot{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:message.when forKey:[Utils getSettingsKeyWHEN:slot]];
    [defaults setValue:message.from forKey:[Utils getSettingsKeyFROM:slot]];
    [defaults setValue:message.to forKey:[Utils getSettingsKeyTO:slot]];
    [defaults setValue:message.text forKey:[Utils getSettingsKeyTEXT:slot]];
}
+(Message*)getMessageFromSlot:(int)slot{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Message *message = nil;
    NSString* whenKey = [Utils getSettingsKeyWHEN:slot];
    
    NSString* whenString = (NSString*)[defaults objectForKey:whenKey];
    if (whenString){
        message = [[Message alloc] init];
        message.when = [whenString intValue];
        message.from = [defaults objectForKey:[Utils getSettingsKeyFROM:slot]];
        message.to = [defaults objectForKey:[Utils getSettingsKeyTO:slot]];
        message.text = [defaults objectForKey:[Utils getSettingsKeyTEXT: slot]];
    }
    
    return message;
}

+(void) deleteMessageInSlot:(int)slot{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:[Utils getSettingsKeyWHEN:slot]];
    [defaults removeObjectForKey:[Utils getSettingsKeyFROM: slot]];
    [defaults removeObjectForKey:[Utils getSettingsKeyTO:slot]];
    [defaults removeObjectForKey:[Utils getSettingsKeyTEXT:slot]];
}

+(void) moveLastMessageToSlot:(int)slot{
    int lastSlot = [self getSavedMessagesCount];
    if (slot < 1 || slot >= lastSlot){
        return;
    }
    Message* last = [self getMessageFromSlot:lastSlot];
    [self deleteMessageInSlot:lastSlot];
    [self saveMessage:last inSlot:lastSlot];
}

// message count is stored in order to know which msg gap to fill when deleted AND when saving message
+(int) getSavedMessagesCount{
    NSString* stringCount =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[self userSpecKey:SYS_SAVED_MESSAGES_COUNT]];
    if (!stringCount){
        return 0;
    }
    return [stringCount intValue];
}
+(void) setSavedMessagesCount:(int)count{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", count] forKey:[self userSpecKey:SYS_SAVED_MESSAGES_COUNT]];
}

@end
