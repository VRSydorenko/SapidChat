//
//  SettingsManager.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SettingsManager.h"
#import "NewMsgLanguageVC.h"

@implementation SettingsManager

+ (void) callNewMessagesLanguageScreenOverViewController:(UIViewController<NewMsgLanguagesSettingsDelegate>*)controller{
    NewMsgLanguageVC *vc = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"ScreenNewMessageLanguages"];
    vc.handler = controller;
    [controller presentModalViewController:vc animated:YES];
}

@end
