//
//  Utils.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbModel.h"
#import "User.h"

@interface Utils : NSObject

+(ErrorCodes) validateEmail:(NSString*)email;
+(bool) isNicknameValid:(NSString*)nick;
+(NSArray*) buildDialogsOfMsgs:(NSArray*)messages;
+(NSString*) getErrorDescription:(ErrorCodes)error;
+(NSString*) getLanguageName:(int)langCode needSelfName:(bool)selfName;
+(NSString*) dateToString:(NSDate*)dateTime;
+(NSString*) timeToString:(NSDate*)dateTime;
+(NSDate*)toLocalDate:(int)globalTimestamp;
+(int)toGlobalTimestamp:(int)localTimestamp;

+(bool) getIfMetricMeasurementSystem;
+(void) setBackgroundFromPatternForView:(UIView*)view;

+(NSData*) compressImage:(UIImage*)image;
+(UIImage*)scale:(UIImage*)image proportionalToSize:(CGSize)size;

+(UIBarButtonItem*) createBackButtonWithSelectorBackPressedOnTarget:(UIViewController*)viewController;
+(NSString*) trimWhitespaces:(NSString*)string;

+(NSString*) getUserString:(NSString*)userEmail;
+(NSDate*) dateWithoutTime:(NSDate*)date;

@end
