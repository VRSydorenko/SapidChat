//
//  Lang.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Language
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE;
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT;
+(NSString*) LOC_FIRSTLAUNCH_BTN_GO;
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME;
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE;
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP;
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE;
//languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME;
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN;
+(NSString*) LOC_LOGIN_BTN_REGISTRATION;

@end

@interface Lang <Language>

+(NSString*)getAppLanguageStringForFirstLaunch:(int)lang;

@end
