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
@property (strong, nonatomic) IBOutlet UILabel *labelMsgLanguages;
@property (strong, nonatomic) IBOutlet UILabel *labelAppLanguage;
@end
