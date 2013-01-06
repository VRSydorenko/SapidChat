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
    bool isAfterRegistration;
}

@end

@implementation ViewController

@synthesize dismissOnLogin = _dismissOnLogin;
@synthesize activityIndicator;
@synthesize textEmail;
@synthesize textPassword;
@synthesize labelServiceMessage;
@synthesize btnGo;
@synthesize btnRegister;
@synthesize btnForgotPass;

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UserSettings setHasLaunched];
    
    isLoggingIn = NO;
    isAfterRegistration = NO;
    self.textPassword.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated{
    if (isAfterRegistration){
        isAfterRegistration = NO;
        return;
    }
    
    [self localize];
    
    [self.textEmail resignFirstResponder];
    [self.textPassword resignFirstResponder];
    
    self.textEmail.placeholder = [Lang LOC_LOGIN_TXT_LOGIN_PLACEHOLDER];
    self.textPassword.placeholder = [Lang LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER];
    
    self.textEmail.text = @"";
    self.textPassword.text = @"";
}

-(void)localize{
    [LocalizationUtils setTitle:[Lang LOC_LOGIN_BTN_LOGIN] forButton:self.btnGo];
    [LocalizationUtils setTitle:[Lang LOC_LOGIN_BTN_REGISTRATION] forButton:self.btnRegister];
    [LocalizationUtils setTitle:[Lang LOC_LOGIN_BTN_FORGOTPASSWORD] forButton:self.btnForgotPass];
}

- (void)viewDidUnload
{
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setLabelServiceMessage:nil];
    [self setActivityIndicator:nil];
    [self setBtnGo:nil];
    [self setBtnRegister:nil];
    [self setBtnForgotPass:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)goPressed:(id)sender {
    if (!isLoggingIn){
        self.textEmail.text = [Utils trimWhitespaces:self.textEmail.text];
        [self.textEmail resignFirstResponder];
        [self.textPassword resignFirstResponder];
        [self loginAsync];
    }
}

- (IBAction)registerPressed:(id)sender {
    self.labelServiceMessage.text = @"";
    [UserRegistrator registerUserOverCurrentViewController:self];
}

- (IBAction)didEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self goPressed:self.btnGo];
    return YES;
}

-(void) loginAsync{
    isLoggingIn = YES;
    self.labelServiceMessage.text = @"";
    [self.activityIndicator startAnimating];
    
    dispatch_queue_t logginQueue = dispatch_queue_create("login queue", NULL);
    dispatch_async(logginQueue, ^{
        ErrorCodes logginResult = [DataManager login:self.textEmail.text password:self.textPassword.text];
        if (logginResult == OK){
            [DataManager getAllDialogs];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (logginResult == OK){
                self.labelServiceMessage.text = @"";
                if (self.dismissOnLogin){
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self performSegueWithIdentifier:@"SegueLoginToMain" sender:self];
                }
            } else {
                self.labelServiceMessage.text = [Utils getErrorDescription:logginResult];
            }
            [self.activityIndicator stopAnimating];
            isLoggingIn = NO;
        });
    });
    dispatch_release(logginQueue);
}

-(void) controllerToDismiss:(RegistrationNavController *)regController whichRegisteredTheUser:(User *)user{
    if (user){
        self.textEmail.text = user.email;
        self.textPassword.text = [AmazonKeyChainWrapper getValueFromKeyChain:user.email];
        isAfterRegistration = YES; // to prevent resetting fields in ViewWillAppear
    }
    [regController dismissViewControllerAnimated:YES completion:nil];
}

@end
