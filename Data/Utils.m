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
    return [emailTest evaluateWithObject:email] && ![email isEqualToString:SYSTEM_USER] ? OK : INVALID_EMAIL;
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
        case OK:            return [Lang LOC_ERRORCODE_OK];
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
        default:
            return @"Error...";
    }
}

+(NSString*) getLanguageName:(int)langCode needSelfName:(bool)selfName;{
    switch (langCode) {
        case ARABIC:    return selfName ? @"العربية" : [Lang LOC_SETTINGS_LANGUAGES_ARABIC];
        case CHINESE:   return selfName ? @"中文, 汉语" : [Lang LOC_SETTINGS_LANGUAGES_CHINESE];
        case ENGLISH:   return selfName ? [LangEnglish LOC_SYS_LANGUAGE_SELFNAME] : [Lang LOC_SETTINGS_LANGUAGES_ENGLISH];
        case FRENCH:    return selfName ? @"Français" : [Lang LOC_SETTINGS_LANGUAGES_FRENCH];
        case GERMAN:    return selfName ? @"Deutsch" : [Lang LOC_SETTINGS_LANGUAGES_GERMAN];
        case HINDI:     return selfName ? @"हिन्दी" : [Lang LOC_SETTINGS_LANGUAGES_HINDI];
        case ITALIAN:   return selfName ? @"Italiano" : [Lang LOC_SETTINGS_LANGUAGES_ITALIAN];
        case JAPANESE:  return selfName ? @"日本語" : [Lang LOC_SETTINGS_LANGUAGES_JAPANESE];
        case KOREAN:    return selfName ? @"한국어, 조선말" : [Lang LOC_SETTINGS_LANGUAGES_KOREAN];
        case PORTUGESE: return selfName ? @"Português" : [Lang LOC_SETTINGS_LANGUAGES_PORTUGESE];
        case RUSSIAN:   return selfName ? [LangRussian LOC_SYS_LANGUAGE_SELFNAME] : [Lang LOC_SETTINGS_LANGUAGES_RUSSIAN];
        case SPANISH:   return selfName ? @"Español" : [Lang LOC_SETTINGS_LANGUAGES_SPANISH];
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


+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }
    
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, M_PI_2); // + 90 degrees
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, -M_PI_2); // - 90 degrees
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, -M_PI); // - 180 degrees
    }
    
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

@end
