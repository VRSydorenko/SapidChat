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

@interface IntrigueVC (){
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

    intriguePrice = 1;
    
    isSending = NO;
    self.title = [Lang LOC_INTRIGUE_SCREEN_TITLE];
    [LocalizationUtils setText:[Lang LOC_INTRIGUE_LABEL_ENTERMAIL] forLabel:self.labelEnterEmail];
    [LocalizationUtils setTitle:[Lang LOC_INTRIGUE_BTN_SEND] forButton:self.btnSend];
    self.textEmail.placeholder = [Lang LOC_INTRIGUE_EDIT_PLACEHOLDER_EMAIL];
    self.textMsg.placeholder = [Lang LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG];
    [self updateConoditionsLabel];
}

- (void)viewDidUnload
{
    [self setLabelEnterEmail:nil];
    [self setTextEmail:nil];
    [self setBtnSend:nil];
    [self setIndicatorSend:nil];
    [self setLabelConditions:nil];
    [self setTextMsg:nil];
    [super viewDidUnload];
}

- (IBAction)sendPressed:(id)sender {
    NSString* email = [self.textEmail.text lowercaseString];
    ErrorCodes emailValidationError = [Utils validateEmail:email];
    if (emailValidationError != OK){
        [self showInfoBarWithError:[Utils getErrorDescription:emailValidationError]];
    } else if (!isSending){
        isSending = YES;
        [self.textEmail resignFirstResponder];
        [self.textMsg resignFirstResponder];
        [self.indicatorSend startAnimating];
        
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            ErrorCodes errorCode = [PurchaseManager beginRegularPoststampsSpending:intriguePrice];
            if (errorCode == OK){
                errorCode = [DataManager sendIntrigueTo:email withOptionalText:self.textMsg.text];
            }
            if (errorCode == OK){
                [PurchaseManager finishRegularPoststampsSpending:intriguePrice];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorSend stopAnimating];
                if (errorCode == OK){
                    [self showInfoBarWithSuccess:[email isEqualToString:[UserSettings getEmail]] ? [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK] : [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_OK]];
                } else {
                    [self showInfoBarWithError:[Utils getErrorDescription:errorCode]];
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
    if ([segue.identifier isEqualToString:@"SegueIntrigueToInfo"]){
        InfoVC* infoVC = (InfoVC*)[segue destinationViewController];
        infoVC.title = [Lang LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE];
        infoVC.infoString = [Lang LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE];
    }
}

-(void) showInfoBarWithError:(NSString*)errorText{
    [[SapidInfoBarManager sharedManager] showInfoBarWithMessage:errorText withMood:NEGATIVE];
}

-(void) showInfoBarWithSuccess:(NSString*)successText{
    [[SapidInfoBarManager sharedManager] showInfoBarWithMessage:successText withMood:POSITIVE];
}

@end
