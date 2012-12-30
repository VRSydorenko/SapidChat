//
//  RestorePassVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "RestorePassVC.h"
#import "Lang.h"
#import "LocalizationUtils.h"
#import "DbModel.h"
#import "DataManager.h"
#import "Utils.h"
#import "SapidInfoBarManager.h"

@interface RestorePassVC (){
    bool isSendingPass;
}

@end

@implementation RestorePassVC
@synthesize labelInstruction;
@synthesize btnGo;
@synthesize textEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isSendingPass = NO;
    
    self.labelInstruction.text = [Lang LOC_RESTORE_LABEL_INSTRUCTION];
	self.textEmail.placeholder = [Lang LOC_LOGIN_TXT_LOGIN_PLACEHOLDER];
    self.labelTitle.text = [Lang LOC_RESTORE_SCREEN_TITLE];
    [LocalizationUtils setTitle:[Lang LOC_RESTORE_BTN_GO] forButton:self.btnGo];
    
    [[SapidInfoBarManager sharedManager] initInfoBarWithTopViewFrame:self.toolbarPlaceholder.frame andHeight:40];
    [self.view insertSubview:[[SapidInfoBarManager sharedManager] infoBar] belowSubview:self.toolbarPlaceholder];
}

- (void)viewDidUnload
{
    [self setLabelInstruction:nil];
    [self setBtnGo:nil];
    [self setTextEmail:nil];
    [self setLabelTitle:nil];
    [self setToolbarPlaceholder:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)btnGoPressed:(id)sender {
    if (!isSendingPass){
        isSendingPass = YES;
        [self.spinner startAnimating];
    
        dispatch_queue_t logginQueue = dispatch_queue_create("restore pass queue", NULL);
        dispatch_async(logginQueue, ^{
            ErrorCodes sent = [DataManager restorePassword:self.textEmail.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sent == OK){
                    [self showResultAndDismiss];
                } else {
                    [self showInfoBarWithError:[Utils getErrorDescription:sent]];
                }
                [self.spinner stopAnimating];
                isSendingPass = NO;
            });
        });
        dispatch_release(logginQueue);
    }
}

-(void) showResultAndDismiss{
    self.textEmail.text = @"";
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[Lang LOC_RESTORE_SCREEN_TITLE] message:[Lang LOC_RESTORE_ALERT_STATE] delegate:self cancelButtonTitle:[Lang LOC_RESTORE_ALERT_BTN_OK] otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self cancelPressed:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self btnGoPressed:self.btnGo];
    return YES;
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didEndOnExit:(UITextField *)sender{
    [sender resignFirstResponder];
}

-(void) showInfoBarWithError:(NSString*)errorText{
    [[SapidInfoBarManager sharedManager] showInfoBarWithMessage:errorText withMood:NEGATIVE];
}

@end
