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
#import "SapidInfoBarManager.h"
#import "MainNavController.h"

@interface SettingsChangePassVC (){
    bool isChangingPass;
}

@end

@implementation SettingsChangePassVC
@synthesize btnChangePass;
@synthesize editCurrentPass;
@synthesize editNewPass;
@synthesize editNewPassConfirm;
@synthesize spinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isChangingPass = NO;
    self.title = [Lang LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE];
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
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
    [self setSpinner:nil];
    [super viewDidUnload];
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnChangePassPressed:(id)sender {
    ErrorCodes passValidated = [self validate];
    if (passValidated != OK){
        [(MainNavController*)self.navigationController showInfoBarWithNegativeMessage:[Utils getErrorDescription:passValidated]];
    } else {
        [self changePasAsync];
    }
}

-(void) changePasAsync{
    isChangingPass = YES;
    self.navigationItem.hidesBackButton = YES;
    [self.spinner startAnimating];
    
    dispatch_queue_t changePassQueue = dispatch_queue_create("changePass queue", NULL);
    dispatch_async(changePassQueue, ^{
        ErrorCodes result = [DataManager updateOwnPassword:self.editNewPass.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result == OK){
                [AmazonKeyChainWrapper storeValueInKeyChain:self.editNewPass.text forKey:[UserSettings getEmail]];
                [self ShowResultAndDismiss];
            } else {
                [(MainNavController*)self.navigationController showInfoBarWithNegativeMessage:[Utils getErrorDescription:result]];
            }
            [self.spinner stopAnimating];
            self.navigationItem.hidesBackButton = NO;
            isChangingPass = NO;
        });
    });
    dispatch_release(changePassQueue);
}

-(ErrorCodes) validate{
    if (self.editCurrentPass.text.length == 0){
        return PASSWORD_NOT_SPECIFIED;
    }
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