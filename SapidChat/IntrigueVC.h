//
//  IntrigueVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 10/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntrigueVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelEnterEmail;
@property (strong, nonatomic) IBOutlet UILabel *labelServiceMessage;
@property (strong, nonatomic) IBOutlet UILabel *labelConditions;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorSend;
- (IBAction)sendPressed:(id)sender;
- (IBAction)didEndOnExit:(id)sender;
@end
