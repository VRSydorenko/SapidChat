//
//  RegistrationVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 6/30/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "RegistrationVC.h"
#import "Utils.h"
#import "DataManager.h"
#import "UserSettings.h"

@interface RegistrationVC (){
    bool isResistering;
}
@end

@implementation RegistrationVC
@synthesize registrationHandler;
@synthesize activityIndicator;
@synthesize textEmail;
@synthesize textPassword;
@synthesize labelServiceMessage;
@synthesize switchSave;

-(void) viewDidLoad{
    [super viewDidLoad];
    isResistering = NO;
}

- (void)viewDidUnload
{
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setSwitchSave:nil];
    [self setLabelServiceMessage:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)registerPressed:(id)sender {
    if (!isResistering){
        [self registerAsync];
    }
}

-(void) registerAsync{
    isResistering = YES;
    self.labelServiceMessage.text = @"";
    [self.activityIndicator startAnimating];
    
    dispatch_queue_t regQueue = dispatch_queue_create("registration queue", NULL);
    dispatch_async(regQueue, ^{
        ErrorCodes registered = [self registerUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (registered == OK){
                [UserSettings setEmail:self.textEmail.text];
                [UserSettings setPassword:self.textPassword.text];
                [UserSettings setSaveCredentials:self.switchSave.on];
                [registrationHandler registrationCompleted:self.textEmail.text pass:self.textPassword.text];
                [self dismissModalViewControllerAnimated:YES];
            } else {
                self.labelServiceMessage.text = [Utils getErrorDescription:registered];
            }
            [self.activityIndicator stopAnimating];
            isResistering = NO;
        });
    });
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (ErrorCodes) registerUser{
    ErrorCodes result = [Utils validateEmail:self.textEmail.text];
    if (result == OK){
        if (self.textPassword.text.length < 5){
            return PASSWORD_TOO_SHORT;
        }
        result = [DataManager registerNewUser:self.textEmail.text password:self.textPassword.text];
    }
    return result;
}
@end
