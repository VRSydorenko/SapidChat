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
#import "Lang.h"
#import "LocalizationUtils.h"
#import "AmazonKeyChainWrapper.h"

@interface ViewController (){
    bool isLoggingIn;
}

@end

@implementation ViewController
@synthesize activityIndicator;
@synthesize textEmail;
@synthesize textPassword;
@synthesize labelServiceMessage;
@synthesize btnGo;
@synthesize btnRegister;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UserSettings setHasLaunched];
    
    [self localize];
    
    isLoggingIn = NO;
}

-(void) viewWillAppear:(BOOL)animated{
    if ([UserSettings getSaveCredentials]){
        self.textEmail.text = [UserSettings getEmail];
        self.textPassword.text = [AmazonKeyChainWrapper getValueFromKeyChain:[UserSettings getEmail]];
    } else {
        self.textEmail.text = @"";
        self.textPassword.text = @"";
    }
}

-(void)localize{
    [LocalizationUtils setTitle:[Lang LOC_LOGIN_BTN_LOGIN] forButton:self.btnGo];
    [LocalizationUtils setTitle:[Lang LOC_LOGIN_BTN_REGISTRATION] forButton:self.btnRegister];
}

- (void)viewDidUnload
{
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setLabelServiceMessage:nil];
    [self setActivityIndicator:nil];
    [self setBtnGo:nil];
    [self setBtnRegister:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)goPressed:(id)sender {
    if (!isLoggingIn){
        [self loginAsync];
    }
}

- (IBAction)registerPressed:(id)sender {
    [UserRegistrator registerUserOverCurrentViewController:self andHandler:self];
}

- (IBAction)didEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

-(void) loginAsync{
    isLoggingIn = YES;
    self.labelServiceMessage.text = @"";
    [self.activityIndicator startAnimating];
    
    dispatch_queue_t logginQueue = dispatch_queue_create("login queue", NULL);
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueLoginToMain"]){
        MainNavController* navCon = (MainNavController*)segue.destinationViewController;
        navCon.logoutHandler = self;
    }
}

-(void) controllerToDismiss:(RegistrationNavController *)regController whichRegisteredTheUser:(User *)user{
    if (user){
        self.textEmail.text = user.email;
        self.textPassword.text = [AmazonKeyChainWrapper getValueFromKeyChain:user.email];
    }
    [regController dismissViewControllerAnimated:YES completion:nil];
}

-(void) controllerToLogout:(UINavigationController *)navController{
    [navController dismissModalViewControllerAnimated:YES];
}

@end
