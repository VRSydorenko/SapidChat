//
//  SettingsTableVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/13/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableVC : UITableViewController


- (IBAction)switchSaveCreds:(UISwitch *)sender;
@property (strong, nonatomic) IBOutlet UISwitch *switchSaveCreds;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeZone;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeFormat;
@property (strong, nonatomic) IBOutlet UILabel *labelDateFormat;
@property (strong, nonatomic) IBOutlet UILabel *labelNickname;
@property (strong, nonatomic) IBOutlet UILabel *labelCnvLanguages;
@property (strong, nonatomic) IBOutlet UILabel *labelNewMsgLanguage;
@property (strong, nonatomic) IBOutlet UILabel *labelAppLanguage;

@property (strong, nonatomic) IBOutlet UILabel *loc_DateTime_Timezone;
@property (strong, nonatomic) IBOutlet UILabel *loc_DateTime_TimeFormat;
@property (strong, nonatomic) IBOutlet UILabel *loc_DateTime_DateFormat;
@property (strong, nonatomic) IBOutlet UILabel *loc_Acc_Nickname;
@property (strong, nonatomic) IBOutlet UILabel *loc_Acc_Password;
@property (strong, nonatomic) IBOutlet UILabel *loc_Acc_SaveCreds;
@property (strong, nonatomic) IBOutlet UILabel *loc_Langs_Conversation;
@property (strong, nonatomic) IBOutlet UILabel *loc_Langs_NewMessages;
@property (strong, nonatomic) IBOutlet UILabel *loc_Langs_Application;

@end
