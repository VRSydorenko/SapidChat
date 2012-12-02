//
//  SettingsChangePassVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/2/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SettingsChangePassVC.h"
#import "Lang.h"
#import "LocalizationUtils.h"
#import "DbModel.h"
#import "AmazonKeyChainWrapper.h"
#import "UserSettings.h"
#import "Utils.h"
#import "DataManager.h"

@interface SettingsChangePassVC (){
    bool isChangingPass;
}

@end

@implementation SettingsChangePassVC
@synthesize btnChangePass;
@synthesize labelServiceMsg;
@synthesize editCurrentPass;
@synthesize editNewPass;
@synthesize editNewPassConfirm;
@synthesize spinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isChangingPass = NO;
    self.title = [Lang LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE];
    self.editCurrentPass.placeholder = [Lang LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT];
    self.editNewPass.placeholder = [Lang LOC_SETTINGS_CHANGEPASS_PLACEHLDR_NEW];
    self.editNewPassConfirm.placeholder = [Lang LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM];
    [LocalizationUtils setTitle:[Lang LOC_SETTINGS_CHANGEPASS_BTN_OK] forButton:self.btnChangePass];
}

- (void)viewDidUnload
{
    [self setEditCurrentPass:nil];
    [self setEditNewPass:nil];
    [self setEditNewPassConfirm:nil];
    [self setBtnChangePass:nil];
    [self setLabelServiceMsg:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
}

- (IBAction)btnChangePassPressed:(id)sender {
    ErrorCodes passValidated = [self validate];
    if (passValidated != OK){
        self.labelServiceMsg.text = [Utils getErrorDescription:passValidated];
    } else {
        [self changePasAsync];
    }
}

-(void) changePasAsync{
    isChangingPass = YES;
    self.labelServiceMsg.text = @"";
    self.navigationItem.hidesBackButton = YES;
    [self.spinner startAnimating];
    
    dispatch_queue_t changePassQueue = dispatch_queue_create("changePass queue", NULL);
    dispatch_async(changePassQueue, ^{
        ErrorCodes result = [DataManager updateOwnPassword:self.editNewPass.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result == OK){
                self.labelServiceMsg.text = @"";
                [AmazonKeyChainWrapper storeValueInKeyChain:self.editNewPass.text forKey:[UserSettings getEmail]];
                [self ShowResultAndDismiss];
            } else {
                self.labelServiceMsg.text = [Utils getErrorDescription:result];
            }
            [self.spinner stopAnimating];
            self.navigationItem.hidesBackButton = NO;
            isChangingPass = NO;
        });
    });
    dispatch_release(changePassQueue);
}

-(ErrorCodes) validate{
    if (![self.editCurrentPass.text isEqualToString:[AmazonKeyChainWrapper getValueFromKeyChain:[UserSettings getEmail]]]){
        return WRONG_PASSWORD;
    }
    if (self.editNewPass.text.length < MINIMUM_PASSWORD_LENGTH){
        return PASSWORD_TOO_SHORT;
    }
    if (![self.editNewPass.text isEqualToString:self.editNewPassConfirm.text]){
        return PASSWORDS_NOT_MATCH;
    }
    return OK;
}

-(void) ShowResultAndDismiss{
    self.editCurrentPass.text = @"";
    self.editNewPass.text = @"";
    self.editNewPassConfirm.text = @"";
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[Lang LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE] message:[Lang LOC_SETTINGS_CHANGEPASS_RESULT_MSG] delegate:self cancelButtonTitle:[Lang LOC_SETTINGS_CHANGEPASS_RESULT_BTN_OK] otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end