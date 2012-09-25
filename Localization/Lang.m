//
//  Lang.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "Lang.h"
#import "UserSettings.h"
#import "LangEnglish.h"
#import "LangRussian.h"

@implementation Lang

+(Class) AppLanguage{
    switch ([UserSettings getAppLanguage]) {
        case 2: return [LangEnglish class];
        case 10: return [LangRussian class];
    }
    return nil;
}

+(NSString*)getAppLanguageStringForFirstLaunch:(int)lang{
    switch (lang) {
        case 2: return [LangEnglish LOC_FIRSTLAUNCH_APPLANGUAGE];
        case 10: return [LangRussian LOC_FIRSTLAUNCH_APPLANGUAGE];
    }
    return nil;
}

// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return [[self AppLanguage] LOC_FIRSTLAUNCH_APPLANGUAGE];}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return [[self AppLanguage] LOC_FIRSTLAUNCH_BTN_NEXT];}
+(NSString*) LOC_FIRSTLAUNCH_BTN_GO{ return [[self AppLanguage] LOC_FIRSTLAUNCH_BTN_GO];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_WELCOME];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_COMPOSE];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_PICKITUP];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_COMMUNICATE];}
// languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME {return [[self AppLanguage] LOC_SYS_LANGUAGE_SELFNAME];}

// login window
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return [[self AppLanguage] LOC_LOGIN_BTN_LOGIN];}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return [[self AppLanguage] LOC_LOGIN_BTN_REGISTRATION];}

@end
