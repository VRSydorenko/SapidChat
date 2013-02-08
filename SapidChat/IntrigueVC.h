//
//  IntrigueVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 10/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllLangsVC.h"

@interface IntrigueVC : UIViewController<OneLanguagePickerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelEnterEmail;
@property (strong, nonatomic) IBOutlet UILabel *labelConditions;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textMsg;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIButton *btnSendIcon;
@property (strong, nonatomic) IBOutlet UIButton *btnLanguage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorSend;
- (IBAction)sendPressed:(id)sender;
- (IBAction)languagePressed:(id)sender;
- (IBAction)didEndOnExit:(id)sender;
@end
