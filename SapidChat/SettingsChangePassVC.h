//
//  SettingsChangePassVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/2/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsChangePassVC : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelServiceMsg;
@property (strong, nonatomic) IBOutlet UITextField *editCurrentPass;
@property (strong, nonatomic) IBOutlet UITextField *editNewPass;
@property (strong, nonatomic) IBOutlet UITextField *editNewPassConfirm;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *btnChangePass;
- (IBAction)btnChangePassPressed:(id)sender;

@end
