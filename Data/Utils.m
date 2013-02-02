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
#import "Lang.h"
#import "LangRussian.h"
#import "LangEnglish.h"


@implementation Utils

+(ErrorCodes) validateEmail:(NSString*)email{
    if (email.length == 0){
        return EMAIL_NOT_SPECIFIED;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email] ? OK : INVALID_EMAIL;
}

+(bool) isNicknameValid:(NSString*)nick{
    NSString* lowercaseNick = [nick lowercaseString];
    return !([lowercaseNick isEqualToString:@"sapid chat"]
             || [lowercaseNick isEqualToString:@"sapidchat"]);
}

+(NSArray*) buildDialogsOfMsgs:(NSArray*)messages{
    NSString* user = [UserSettings getEmail];
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

+(NSString*) getErrorDescription:(ErrorCodes)error{
    switch (error) {
        case OK:            return [Lang LOC_UNI_OK];
        case ERROR:         return [Lang LOC_ERRORCODE_ERROR];
        case INVALID_EMAIL: return [Lang LOC_ERRORCODE_INVALID_EMAIL];
        case USER_EXISTS:   return [Lang LOC_ERRORCODE_USER_EXISTS];
        case NO_SUCH_USER:  return [Lang LOC_ERRORCODE_NO_SUCH_USER];
        case WRONG_PASSWORD:return [Lang LOC_ERRORCODE_WRONG_PASSWORD];
        case EMAIL_NOT_SPECIFIED:   return [Lang LOC_ERRORCODE_EMAIL_NOT_SPECIFIED];
        case AMAZON_SERVICE_ERROR:  return [Lang LOC_ERRORCODE_AMAZON_SERVICE_ERROR];
        case PASSWORD_TOO_SHORT:    return [Lang LOC_ERRORCODE_PASSWORD_TOO_SHORT];
        case LOGIN_NOT_SPECIFIED:   return [Lang LOC_ERRORCODE_LOGIN_NOT_SPECIFIED];
        case TEXT_NOT_SPECIFIED:    return [Lang LOC_ERRORCODE_TEXT_NOT_SPECIFIED];
        case POSTSTAMPS_NOT_ENOUGH: return [Lang LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH];
        case PASSWORDS_NOT_MATCH:   return [Lang LOC_ERRORCODE_PASSWORDS_NOT_MATCH];
        case PASSWORD_NOT_SPECIFIED:   return [Lang LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED];
        case EMAIL_BLOCKED_FOR_INTRIGUE: return [Lang LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE];
        default:
            return @"Error...";
    }
}

+(NSString*) getLanguageName:(int)langCode needSelfName:(bool)selfName;{
    switch (langCode) {
        case ARABIC:    return selfName ? @"العربية" : [Lang LOC_SETTINGS_LANGUAGES_ARABIC];
        case CHINESE:   return selfName ? @"中文, 汉语" : [Lang LOC_SETTINGS_LANGUAGES_CHINESE];
        case DANISH:   return selfName ? @"Dansk" : [Lang LOC_SETTINGS_LANGUAGES_DANISH];
        case ENGLISH:   return selfName ? [LangEnglish LOC_SYS_LANGUAGE_SELFNAME] : [Lang LOC_SETTINGS_LANGUAGES_ENGLISH];
        case FRENCH:    return selfName ? @"Français" : [Lang LOC_SETTINGS_LANGUAGES_FRENCH];
        case GERMAN:    return selfName ? @"Deutsch" : [Lang LOC_SETTINGS_LANGUAGES_GERMAN];
        case HINDI:     return selfName ? @"हिन्दी" : [Lang LOC_SETTINGS_LANGUAGES_HINDI];
        case ITALIAN:   return selfName ? @"Italiano" : [Lang LOC_SETTINGS_LANGUAGES_ITALIAN];
        case JAPANESE:  return selfName ? @"日本語" : [Lang LOC_SETTINGS_LANGUAGES_JAPANESE];
        case KOREAN:    return selfName ? @"한국어" : [Lang LOC_SETTINGS_LANGUAGES_KOREAN];
        case PORTUGESE: return selfName ? @"Português" : [Lang LOC_SETTINGS_LANGUAGES_PORTUGESE];
        case RUSSIAN:   return selfName ? [LangRussian LOC_SYS_LANGUAGE_SELFNAME] : [Lang LOC_SETTINGS_LANGUAGES_RUSSIAN];
        case SPANISH:   return selfName ? @"Español" : [Lang LOC_SETTINGS_LANGUAGES_SPANISH];
        case HUNGARIAN:   return selfName ? @"Magyar" : [Lang LOC_SETTINGS_LANGUAGES_HUNGARIAN];
        case ROMANIAN:   return selfName ? @"Română" : [Lang LOC_SETTINGS_LANGUAGES_ROMANIAN];
        default:
            return @"Unknown language";
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

+(NSDate*)toLocalDate:(int)globalTimestamp{
    NSInteger seconds = 0;//[NSTimeZone systemTimeZone].secondsFromGMT;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:globalTimestamp + seconds];
}

+(int)toGlobalTimestamp:(int)localTimestamp
{
    return localTimestamp;// - [NSTimeZone systemTimeZone].secondsFromGMT;
}

+(bool) getIfMetricMeasurementSystem{
    return [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
}

+(void) setBackgroundFromPatternForView:(UIView*)view{
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"screenBackground.png"]];
}

+(NSData*) compressImage:(UIImage*)image{
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 100*1024;

    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while (compressedData.length > maxFileSize && compression >= maxCompression)
    {
        compression -= 0.1;
        compressedData = UIImageJPEGRepresentation(image, compression);
    }
    return compressedData;
}

+(UIImage*)image:(UIImage*)sourceImage byScalingProportionallyToSize:(CGSize)targetSize{
    CGFloat widthFactor = targetSize.width / sourceImage.size.width;
    CGFloat heightFactor = targetSize.height / sourceImage.size.height;
    CGFloat scaleFactor = (widthFactor < heightFactor) ? widthFactor : heightFactor;
        
    CGFloat scaledWidth  = sourceImage.size.width * scaleFactor;
    CGFloat scaledHeight = sourceImage.size.height * scaleFactor;
    
    CGRect rect = CGRectMake(0.0, 0.0, scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(rect.size);
    [sourceImage drawInRect:rect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+(NSString*) trimWhitespaces:(NSString*)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(UIBarButtonItem*) createBackButtonWithSelectorBackPressedOnTarget:(UIViewController*)viewController{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"backArrow.png"] ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:viewController action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 24, 24);
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

+(NSString*) getUserString:(NSString*)userEmail{
    NSString* result = @"";
    if ([userEmail isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR]){
        result =  [Lang LOC_MESSAGES_CELL_WAIT_FOR_REPLY];
    } else {
        User* collocutor = [DataManager loadUser:userEmail];
        return collocutor ? collocutor.nickname : userEmail;
    }
    return  result;
}

+(NSDate*) dateWithoutTime:(NSDate*)date{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:date];
    return [calendar dateFromComponents:components];
}

+(UILabel*)makeScreenTitleLabelforText:(NSString*)text{
    CGRect frame = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:APPLICATION_NAME_FONT size:20.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = text;
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    return label;
}

+(void) fitButtonInHorizontalCenter:(UIButton*)button{
    [button sizeToFit];
    CGRect frame = button.frame;
    frame.origin.x = 160 - button.bounds.size.width/2;
    button.frame = frame;
}

+(UIImage*)getFlagForLanguage:(int)lang{
    NSString* imageName = @"";
    switch (lang) {
        case ARABIC:
            imageName = @"arableague.png";
            break;
        case CHINESE:
            imageName = @"china.png";
            break;
        case DANISH:
            imageName = @"denmark.png";
            break;
        case ENGLISH:
            imageName = @"uk.png";
            break;
        case FRENCH:
            imageName = @"france.png";
            break;
        case GERMAN:
            imageName = @"germany.png";
            break;
        case HINDI:
            imageName = @"india.png";
            break;
        case ITALIAN:
            imageName = @"italy.png";
            break;
        case JAPANESE:
            imageName = @"japan.png";
            break;
        case KOREAN:
            imageName = @"korea.png";
            break;
        case PORTUGESE:
            imageName = @"portugal.png";
            break;
        case RUSSIAN:
            imageName = @"russia.png";
            break;
        case SPANISH:
            imageName = @"spain.png";
            break;
        case HUNGARIAN:
            imageName = @"hungary.png";
            break;
        case ROMANIAN:
            imageName = @"romania.png";
            break;
    }
    return [UIImage imageNamed:imageName];
}

@end
