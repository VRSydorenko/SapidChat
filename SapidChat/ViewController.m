//
//  ViewController.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 6/30/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "ViewController.h"
#import "DbModel.h"
#import "DataManager.h"
#import "Utils.h"
#import "MainNavController.h"
#import "UserSettings.h"

@interface ViewController (){
    bool isLoggingIn;
}

@end

@implementation ViewController
@synthesize activityIndicator;
@synthesize textEmail;
@synthesize textPassword;
@synthesize labelServiceMessage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isLoggingIn = NO;
	
    if ([UserSettings getSaveCredentials]){
        self.textEmail.text = [UserSettings getEmail];
        self.textPassword.text = [UserSettings getPassword];
    }
}

- (void)viewDidUnload
{
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setLabelServiceMessage:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)goPressed:(id)sender {
    if (!isLoggingIn){
        [self loginAsync];
    }
}

-(void) loginAsync{
    isLoggingIn = YES;
    self.labelServiceMessage.text = @"";
    [self.activityIndicator startAnimating];
    
    dispatch_queue_t logginQueue = dispatch_queue_create("loggin queue", NULL);
    dispatch_async(logginQueue, ^{
        ErrorCodes logginResult = [DataManager login:self.textEmail.text password:self.textPassword.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (logginResult == OK){
                self.labelServiceMessage.text = @"";
                [self performSegueWithIdentifier:@"SegueLoginToMain" sender:self];
            } else {
                self.labelServiceMessage.text = [Utils getErrorDescription:logginResult];
            }
            [self.activityIndicator stopAnimating];
            isLoggingIn = NO;
        });
    });
    dispatch_release(logginQueue);
}

- (void) registrationCompleted:(NSString *)email pass:(NSString *)password{
    self.textEmail.text = email;
    self.textPassword.text = password;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueLoginToRegister"]){
        RegistrationVC* regVC = (RegistrationVC*)segue.destinationViewController;
        regVC.registrationHandler = self;
    }
}
@end
