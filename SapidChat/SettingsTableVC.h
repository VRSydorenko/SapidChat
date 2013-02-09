//
//  SettingsTableVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/13/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstLaunchNavController.h"

@interface SettingsTableVC : UITableViewController<UIAlertViewDelegate,
                                                   IntroScreenDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelTimeFormat;
@property (strong, nonatomic) IBOutlet UILabel *labelDateFormat;
@property (strong, nonatomic) IBOutlet UILabel *labelNickname;
@property (strong, nonatomic) IBOutlet UILabel *labelCnvLanguages;
@property (strong, nonatomic) IBOutlet UILabel *labelNewMsgLanguage;
@property (strong, nonatomic) IBOutlet UILabel *labelAppLanguage;

@property (strong, nonatomic) IBOutlet UILabel *loc_DateTime_TimeFormat;
@property (strong, nonatomic) IBOutlet UILabel *loc_DateTime_DateFormat;
@property (strong, nonatomic) IBOutlet UILabel *loc_Acc_Nickname;
@property (strong, nonatomic) IBOutlet UILabel *loc_Acc_Password;
@property (strong, nonatomic) IBOutlet UILabel *loc_Langs_Conversation;
@property (strong, nonatomic) IBOutlet UILabel *loc_Langs_NewMessages;
@property (strong, nonatomic) IBOutlet UILabel *loc_Langs_Application;
@property (strong, nonatomic) IBOutlet UILabel *labelMore_Tour;
@property (strong, nonatomic) IBOutlet UILabel *labelMore_About;
@property (strong, nonatomic) IBOutlet UILabel *labelMore_Rate;

@end
