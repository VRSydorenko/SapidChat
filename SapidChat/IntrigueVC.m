//
//  IntrigueVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 10/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "IntrigueVC.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "DbModel.h"
#import "DataManager.h"
#import "Utils.h"
#import "InfoVC.h"
#import "UserSettings.h"
#import "SapidInfoBarManager.h"
#import "MainNavController.h"
#import "User.h"

@interface IntrigueVC (){
    MainNavController* navController;
    bool isSending;
    int intriguePrice;
}

@end

@implementation IntrigueVC
@synthesize labelEnterEmail;
@synthesize labelConditions;
@synthesize textEmail;
@synthesize textMsg;
@synthesize btnSend;
@synthesize indicatorSend;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navController = (MainNavController*)self.navigationController;
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];

    intriguePrice = 1;
    
    isSending = NO;
    self.title = [Lang LOC_INTRIGUE_SCREEN_TITLE];
    [LocalizationUtils setText:[Lang LOC_INTRIGUE_LABEL_ENTERMAIL] forLabel:self.labelEnterEmail];
    [LocalizationUtils setTitle:[Lang LOC_INTRIGUE_BTN_SEND] forButton:self.btnSend];
    self.textEmail.placeholder = [Lang LOC_UNI_EMAIL];
    self.textMsg.placeholder = [Lang LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG];
    [self updateConoditionsLabel];
}

- (void)dealloc
{
    [self setLabelEnterEmail:nil];
    [self setTextEmail:nil];
    [self setBtnSend:nil];
    [self setIndicatorSend:nil];
    [self setLabelConditions:nil];
    [self setTextMsg:nil];
    [super viewDidUnload];
}

-(void) backPressed{
    [navController popViewControllerAnimated:YES];
}

- (IBAction)sendPressed:(id)sender {
    self.textEmail.text = [Utils trimWhitespaces:self.textEmail.text];
    self.textMsg.text = [Utils trimWhitespaces:self.textMsg.text];
    NSString* email = [self.textEmail.text lowercaseString];
    ErrorCodes emailValidationError = [Utils validateEmail:email];
    if (emailValidationError != OK){
        [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:emailValidationError]];
    } else if (!isSending){
        isSending = YES;
        [self.textEmail resignFirstResponder];
        [self.textMsg resignFirstResponder];
        [self.indicatorSend startAnimating];
        
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            User* fakeUser;
            ErrorCodes errorCode = [DataManager retrieveUser:&fakeUser withEmail:SYSTEM_USER];
            if (errorCode == OK){
                if ([[UserSettings getBlockedForIntrigue] containsObject:self.textEmail.text]){
                    errorCode = EMAIL_BLOCKED_FOR_INTRIGUE;
                } else {
                    errorCode = [PurchaseManager beginRegularPoststampsSpending:intriguePrice];
                    if (errorCode == OK){
                        errorCode = [DataManager sendIntrigueTo:email withOptionalText:self.textMsg.text];
                    }
                    if (errorCode == OK){
                        [PurchaseManager finishRegularPoststampsSpending:intriguePrice];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorSend stopAnimating];
                if (errorCode == OK){
                    [navController showInfoBarWithPositiveMessage:[email isEqualToString:[UserSettings getEmail]] ? [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK] : [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_OK]];
                } else {
                    [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:errorCode]];
                }
                [self updateConoditionsLabel];
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    }
}

-(void) updateConoditionsLabel{
    self.labelConditions.text = [NSString stringWithFormat:[Lang LOC_INTRIGUE_LABEL_CONDITIONS], 1, [Lang LOC_BALANCE_POSTSTAMPS_1], [DataManager getTotalAvailablePoststamps]];
}

- (IBAction)didEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    InfoVC* infoVC = (InfoVC*)[segue destinationViewController];
    if (infoVC){
        infoVC.title = [Lang LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE];
        if ([segue.identifier isEqualToString:@"SegueIntrigueToInfo"]){
            infoVC.infoString = [Lang LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE];
        }
        if ([segue.identifier isEqualToString:@"SegueIntrigueConitionsToInfo"]){
            infoVC.infoString = [Lang LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS];
        }
    }
}

@end
