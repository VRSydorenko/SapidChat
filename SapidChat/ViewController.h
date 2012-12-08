//
//  ViewController.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 6/30/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRegistrator.h"
#import "MainNavController.h"

@interface ViewController : UIViewController <UserRegistrationDelegate, LogoutDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UILabel *labelServiceMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnGo;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIButton *btnForgotPass;
- (IBAction)goPressed:(id)sender;
- (IBAction)registerPressed:(id)sender;
- (IBAction)didEndOnExit:(UITextField *)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
