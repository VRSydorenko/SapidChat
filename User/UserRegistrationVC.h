//
//  UserRegistrationVC.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegistrationVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Initial
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UISwitch *switchSaveCreds;
@property (weak, nonatomic) IBOutlet UITextField *textNick;
@property (strong, nonatomic) IBOutlet UILabel *labelServiseMessage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UITableView *tableLanguages;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnRegister;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnClose;
@property (strong, nonatomic) IBOutlet UILabel *labelEmail;
@property (strong, nonatomic) IBOutlet UILabel *labelPassword;
@property (strong, nonatomic) IBOutlet UILabel *labelSaveCreds;
@property (strong, nonatomic) IBOutlet UILabel *labelNickname;
@property (strong, nonatomic) IBOutlet UILabel *labelSelectLangs;


- (IBAction)cancelPressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)textDidEndOnExit:(id)sender;

@end
