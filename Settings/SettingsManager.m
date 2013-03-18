//
//  SettingsManager.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SettingsManager.h"
#import "NewMsgLanguageVC.h"
#import "AllLangsVC.h"
#import "NewMsgLanguagesNavCon.h"

@implementation SettingsManager

+ (void) callNewMessagesLanguageScreenOverViewController:(UIViewController<NewMsgLanguagesSettingsDelegate>*)controller{
    NewMsgLanguagesNavCon *vc = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"ScreenNewMsgLanguagesNavigation"];
    vc.handler = controller;
    [controller presentViewController:vc animated:YES completion:nil];
}

+ (void) callOneLanguagePickerFrom:(BOOL)appLanguages overViewController:(UIViewController<OneLanguagePickerDelegate>*)controller{
    AllLangsVC *vc = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"ScreenLanguages"];
    vc.handler = controller;
    vc.onlyAppLanguages = appLanguages;
    [controller presentViewController:vc animated:YES completion:nil];
}

@end
