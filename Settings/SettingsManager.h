//
//  SettingsManager.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewMsgLanguagesNavCon.h"
#import "AllLangsVC.h"

@interface SettingsManager : NSObject

+ (void) callNewMessagesLanguageScreenOverViewController:(UIViewController<NewMsgLanguagesSettingsDelegate>*)controller;

+ (void) callOneLanguagePickerFrom:(BOOL)appLanguages overViewController:(UIViewController<OneLanguagePickerDelegate>*)controller;

@end
