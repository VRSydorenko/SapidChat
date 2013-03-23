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
    SapidInfoBarManager* infoBarManager;
}

@end

@implementation RestorePassVC
@synthesize labelInstruction;
@synthesize btnGo;
@synthesize textEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fakeNavBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barGreenBackground.png"]];
    
    isSendingPass = NO;
    
    self.labelTitle.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.labelTitle.shadowOffset = CGSizeMake(0, -1.0);
    self.labelTitle.text = [Lang LOC_RESTORE_SCREEN_TITLE];
    
    self.labelInstruction.text = [Lang LOC_RESTORE_LABEL_INSTRUCTION];
	self.textEmail.placeholder = [Lang LOC_UNI_EMAIL];
    [LocalizationUtils setTitle:[Lang LOC_RESTORE_BTN_GO] forButton:self.btnGo];
    [Utils fitButtonInHorizontalCenter:self.btnGo];
    
    infoBarManager = [[SapidInfoBarManager alloc] init];
    [infoBarManager initInfoBarWithTopViewFrame:self.fakeNavBar.frame andHeight:40];
    [self.view insertSubview:infoBarManager.infoBar belowSubview:self.fakeNavBar];
}

- (void)dealloc
{
    [self setLabelInstruction:nil];
    [self setBtnGo:nil];
    [self setTextEmail:nil];
    [self setSpinner:nil];
    [self setFakeNavBar:nil];
    [self setLabelTitle:nil];
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
                    [infoBarManager showInfoBarWithMessage:[Utils getErrorDescription:sent] withMood:NEGATIVE];
                }
                [self.spinner stopAnimating];
                isSendingPass = NO;
            });
        });
    }
}

-(void) showResultAndDismiss{
    self.textEmail.text = @"";
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[Lang LOC_RESTORE_SCREEN_TITLE] message:[Lang LOC_RESTORE_ALERT_STATE] delegate:self cancelButtonTitle:[Lang LOC_RESTORE_ALERT_BTN_OK] otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self cancelPressed];
}

-(void) cancelPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self btnGoPressed:self.btnGo];
    return YES;
}

- (IBAction)didEndOnExit:(UITextField *)sender{
    [sender resignFirstResponder];
}

@end
