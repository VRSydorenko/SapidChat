//
//  RegistrationVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 6/30/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistrationResponseDelegate
@required
- (void) registrationCompleted:(NSString*)email pass:(NSString*)password;
@end

@interface RegistrationVC : UIViewController

@property (strong, nonatomic) id <RegistrationResponseDelegate> registrationHandler;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UILabel *labelServiceMessage;
- (IBAction)registerPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
