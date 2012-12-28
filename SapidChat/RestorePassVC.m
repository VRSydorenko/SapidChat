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

@interface RestorePassVC ()

@end

@implementation RestorePassVC
@synthesize labelInstruction;
@synthesize labelServiceMsg;
@synthesize btnGo;
@synthesize textEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelInstruction.text = [Lang LOC_RESTORE_LABEL_INSTRUCTION];
	self.textEmail.placeholder = [Lang LOC_LOGIN_TXT_LOGIN_PLACEHOLDER];
    [LocalizationUtils setTitle:[Lang LOC_RESTORE_BTN_GO] forButton:self.btnGo];
}

- (void)viewDidUnload
{
    [self setLabelInstruction:nil];
    [self setLabelServiceMsg:nil];
    [self setBtnGo:nil];
    [self setTextEmail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)btnGoPressed:(id)sender {
    ErrorCodes sent = [DataManager restorePassword:self.textEmail.text];
    if (sent == OK){
        [self showResultAndDismiss];
    } else {
        self.labelServiceMsg.text = [Utils getErrorDescription:sent];
    }
}

-(void) showResultAndDismiss{
    self.textEmail.text = @"";
    self.labelServiceMsg.text = @"";
    
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

@end
