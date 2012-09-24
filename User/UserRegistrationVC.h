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


- (IBAction)cancelPressed:(id)sender;
- (IBAction)nextPressed:(UIBarButtonItem *)sender;
- (IBAction)textDidEndOnExit:(id)sender;

@end
