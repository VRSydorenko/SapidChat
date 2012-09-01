//
//  UserSettings.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/28/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

+ (NSString*) getDateFormat{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:SETTINGS_DATEFORMAT];
    if (!result){
        return DEF_DATEFORMAT;
    }
    return result;
}
+(void) setDateFormat:(NSString*)format{
    [[NSUserDefaults standardUserDefaults] setValue:format forKey:SETTINGS_DATEFORMAT];
}

+(NSString*) getTimeFormat{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:SETTINGS_TIMEFORMAT];
    if (!result){
        return DEF_TIMEFORMAT;
    }
    return result;
}
+(void) setTimeFormat:(NSString*)format{
    [[NSUserDefaults standardUserDefaults] setValue:format forKey:SETTINGS_TIMEFORMAT];
}

+(NSString*) getTimeZone{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:SETTINGS_TIMEZONE];
    if (!result){
        return DEF_TIMEZONE;
    }
    return result;
}
+(void) setTimeZone:(NSString*)timezone{
    [[NSUserDefaults standardUserDefaults] setValue:timezone forKey:SETTINGS_TIMEZONE];
}

+(int) getLastInMsgTimestamp{
    NSString* stringTimestamp =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SYS_LAST_INMSG_TIMESTAMP];
    if (!stringTimestamp){
        return 0;
    }
    return [stringTimestamp intValue];
}
+(void) setLastInMsgTimestamp:(int)timestamp{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", timestamp] forKey:SYS_LAST_INMSG_TIMESTAMP];
}

+(int) getLastOutMsgTimestamp{
    NSString* stringTimestamp =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SYS_LAST_OUTMSG_TIMESTAMP];
    if (!stringTimestamp){
        return 0;
    }
    return [stringTimestamp intValue];
}
+(void) setLastOutMsgTimestamp:(int)timestamp{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", timestamp] forKey:SYS_LAST_OUTMSG_TIMESTAMP];
}

+(NSString*) getNickname{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:SETTINGS_NICKNAME];
    if (!result){
        return @"";
    }
    return result;
}
+(void) setNickname:(NSString *)nick{
    [[NSUserDefaults standardUserDefaults] setValue:nick forKey:SETTINGS_NICKNAME];
}

+ (BOOL) getSaveCredentials{
    return (BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:SETTINGS_SAVECREDENTIALS];
}
+ (void) setSaveCredentials:(BOOL)save{
    [[NSUserDefaults standardUserDefaults] setBool:save forKey:SETTINGS_SAVECREDENTIALS];
}

+(NSString*) getEmail{
    return (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_SAVED_CRED_EMAIL];
}
+(void) setEmail:(NSString*)email{
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:SETTINGS_SAVED_CRED_EMAIL];
}

+(NSString*) getPassword{
    return (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_SAVED_CRED_PASS];
}
+(void) setPassword:(NSString*)password{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:SETTINGS_SAVED_CRED_PASS];
}

+(int) getUnreadMessagesCount{
    NSString* stringCount =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SYS_UNREAD_MSGS_COUNT];
    if (!stringCount){
        return 0;
    }
    return [stringCount intValue];
}
+(void) setUnreadMessagesCount:(int)count{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", count] forKey:SYS_UNREAD_MSGS_COUNT];
}

+(int) getUnreadMessagesCountForCollocutor:(NSString*)collocutor{
    NSString* stringCount =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:collocutor];
    if (!stringCount){
        return 0;
    }
    return [stringCount intValue];
}
+(void) incrementUnreadMessagesCountForCollocutor:(NSString*)collocutor{
    int currentCount = [self getUnreadMessagesCountForCollocutor:collocutor];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", currentCount + 1] forKey:collocutor];
}
+(void) resetUnreadMessagesCountForCollocutor:(NSString*)collocutor{
    int oldValue = [self getUnreadMessagesCountForCollocutor:collocutor];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:collocutor];
    if (oldValue > 0){
        [self setUnreadMessagesCount:[self getUnreadMessagesCount] - oldValue];// update general unread count
    }
}

// data operations

+(NSArray*) getMessages{
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    for (int msgIndex = 1; YES; msgIndex++) { // starts from 1!
        Message* msg = [self getMessageFromSlot:msgIndex];
        if (!msg){
            break;
        }
        [messages addObject:msg];
    }
    return messages;//[self getFakeMessages];//messages;
}

+(void) saveMessage:(Message*)message isNewIncome:(BOOL)yes{
    int newMessageNumber = [self getSavedMessagesCount] + 1;
    
    [self saveMessage:message inSlot:newMessageNumber];
    [self setSavedMessagesCount:newMessageNumber]; // update messages count
    
    if (yes){
        [self setLastInMsgTimestamp:[message.when timeIntervalSinceReferenceDate]]; // save last IN mesage time
        [self setUnreadMessagesCount:[self getUnreadMessagesCount] + 1]; // update unread messages count
        [self incrementUnreadMessagesCountForCollocutor:message.from];
    } else {
        [self setLastOutMsgTimestamp:[message.when timeIntervalSinceReferenceDate]]; // save last OUT mesage time
    }
}

+(void)saveMessage:(Message*)message inSlot:(int)slot{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:[message.when timeIntervalSinceReferenceDate] forKey:[NSString stringWithFormat:@"MSG_WHEN%d", slot]];
    [defaults setValue:message.from forKey:[NSString stringWithFormat:@"MSG_FROM%d", slot]];
    [defaults setValue:message.to forKey:[NSString stringWithFormat:@"MSG_TO%d", slot]];
    [defaults setValue:message.text forKey:[NSString stringWithFormat:@"MSG_TEXT%d", slot]];
}
+(Message*)getMessageFromSlot:(int)slot{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Message *message = nil;
    NSString* whenKey = [NSString stringWithFormat:@"MSG_WHEN%d", slot];
    
    NSString* whenString = (NSString*)[defaults objectForKey:whenKey];
    if (whenString){
        message = [[Message alloc] init];
        message.when = [NSDate dateWithTimeIntervalSinceReferenceDate:[whenString intValue]];
        NSString* fromKey = (NSString*)[NSString stringWithFormat:@"MSG_FROM%d", slot];
        message.from = [defaults objectForKey:fromKey];
        NSString* toKey = (NSString*)[NSString stringWithFormat:@"MSG_TO%d", slot];
        message.to = [defaults objectForKey:toKey];
        NSString* textKey = (NSString*)[NSString stringWithFormat:@"MSG_TEXT%d", slot];
        message.text = [defaults objectForKey:textKey];
    }
    
    return message;
}

+(void) deleteMessage:(Message*)message{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for (int msgIndex=1; msgIndex<=[self getSavedMessagesCount]; msgIndex++) {
        NSString* whenKey = [NSString stringWithFormat:@"MSG_WHEN%d", msgIndex];
        NSTimeInterval whenInterval = (NSTimeInterval)[defaults doubleForKey:whenKey];
        if (whenInterval == [message.when timeIntervalSinceReferenceDate]){
            [self deleteMessageInSlot:msgIndex];
            [self setSavedMessagesCount:[self getSavedMessagesCount] - 1]; // update messages count
            [self moveLastMessageToSlot:msgIndex]; // fill the gap with the last message
            break;
        }
    }
}
+(void) deleteMessageInSlot:(int)slot{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:[NSString stringWithFormat:@"MSG_WHEN%d", slot]];
    [defaults removeObjectForKey:[NSString stringWithFormat:@"MSG_FROM%d", slot]];
    [defaults removeObjectForKey:[NSString stringWithFormat:@"MSG_TO%d", slot]];
    [defaults removeObjectForKey:[NSString stringWithFormat:@"MSG_TEXT%d", slot]];
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
    NSString* stringCount =  (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:SYS_SAVED_MESSAGES_COUNT];
    if (!stringCount){
        return 0;
    }
    return [stringCount intValue];
}
+(void) setSavedMessagesCount:(int)count{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", count] forKey:SYS_SAVED_MESSAGES_COUNT];
}

@end
