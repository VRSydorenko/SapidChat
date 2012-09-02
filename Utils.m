//
//  Utils.m
//  SChat
//
//  Created by Viktor Sydorenko on 6/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "Utils.h"
#import "DbModel.h"
#import "DataManager.h"
#import "Message.h"
#import "Dialog.h"
#import "UserSettings.h"

@implementation Utils

+(ErrorCodes) validateEmail:(NSString*)email{
    if (email.length == 0){
        return EMAIL_NOT_SPECIFIED;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email] ? OK : INVALID_EMAIL;
}

+(NSArray*) buildDialogsOfUser:(NSString*)user msgs:(NSArray*)messages{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    if (messages.count > 0){
        // collocutor - key
        // message - value
        NSMutableDictionary* collecutorDialogMapping = [[NSMutableDictionary alloc] init];
        
        for (Message* msg in messages) {
            NSString* collocutor = [user isEqualToString:msg.from] ? msg.to : msg.from;
            Dialog* dialog = [Utils getDialogOf:user withUser:collocutor fromMapping:collecutorDialogMapping];
            if (![result containsObject:dialog]){
                [result addObject:dialog];
            }
            [dialog addMessage:msg];
        }
    }
    return result;
}

+(Dialog*) getDialogOf:(NSString*)me withUser:(NSString*)collocutor fromMapping:(NSMutableDictionary*)collocutorDialogMapping{
    if (![collocutorDialogMapping objectForKey:collocutor]){
        Dialog* dialog = [[Dialog alloc] initWithMe:me collocutor:collocutor];
        [collocutorDialogMapping setObject:dialog forKey:collocutor];
    }
    return (Dialog*)[collocutorDialogMapping objectForKey:collocutor];
}
/*    
 OK              = 0,
 ERROR           = 1,
 INVALID_EMAIL   = 2,
 USER_EXISTS     = 3,
 NO_SUCH_USER    = 4,
 WRONG_PASSWORD  = 5,
 EMAIL_NOT_SPECIFIED = 6,
 AMAZON_SERVICE_ERROR = 7,
 PASSWORD_TOO_SHORT = 8,
 LOGIN_NOT_SPECIFIED = 9,
*/
+(NSString*) getErrorDescription:(ErrorCodes)error{
    switch (error) {
        case OK:            return @"Success";
        case ERROR:         return @"Error occured";
        case INVALID_EMAIL: return @"Invalid email addresse";
        case USER_EXISTS:   return @"User exists";
        case NO_SUCH_USER:  return @"No such user";
        case WRONG_PASSWORD:return @"Wrong password";
        case EMAIL_NOT_SPECIFIED:   return @"Email not specified";
        case AMAZON_SERVICE_ERROR:  return @"Database service error";
        case PASSWORD_TOO_SHORT:    return @"Password too short";
        case LOGIN_NOT_SPECIFIED:   return @"Login not specified";
        case TEXT_NOT_SPECIFIED:    return @"The text should not be empty";
        case NO_MESSAGES_TO_PICKUP: return @"There is no messages to pick up";
        default:
            return @"Unknown error!";
    }
}
+(NSString*) dateToString:(NSDate*)dateTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[UserSettings getDateFormat]];
    return [formatter stringFromDate:dateTime];
}
+(NSString*) timeToString:(NSDate*)dateTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[UserSettings getTimeFormat]];
    return [formatter stringFromDate:dateTime];
}

+(NSString*) getSettingsKeyWHEN:(int)slot{
    return [NSString stringWithFormat:@"%@_MSG_WHEN%d", [UserSettings getEmail], slot];
}
+(NSString*) getSettingsKeyFROM:(int)slot{
    return [NSString stringWithFormat:@"%@_MSG_FROM%d", [UserSettings getEmail], slot];
}
+(NSString*) getSettingsKeyTO:(int)slot{
    return [NSString stringWithFormat:@"%@_MSG_TO%d", [UserSettings getEmail], slot];
}
+(NSString*) getSettingsKeyTEXT:(int)slot{
    return [NSString stringWithFormat:@"%@_MSG_TEXT%d", [UserSettings getEmail], slot];
}

@end
