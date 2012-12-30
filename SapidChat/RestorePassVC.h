//
//  RestorePassVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestorePassVC : UIViewController<UIAlertViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *toolbarPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *labelInstruction;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnGo;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
- (IBAction)btnGoPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)didEndOnExit:(UITextField *)sender;

@end
