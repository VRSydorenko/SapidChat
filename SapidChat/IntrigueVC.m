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

@interface IntrigueVC (){
    bool isSending;
    int intriguePrice;
}

@end

@implementation IntrigueVC
@synthesize labelEnterEmail;
@synthesize labelServiceMessage;
@synthesize textEmail;
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
}

- (void)viewDidUnload
{
    [self setLabelEnterEmail:nil];
    [self setTextEmail:nil];
    [self setBtnSend:nil];
    [self setIndicatorSend:nil];
    [self setLabelServiceMessage:nil];
    [super viewDidUnload];
}

- (IBAction)sendPressed:(id)sender {
    NSString* email = self.textEmail.text;
    ErrorCodes emailValidationError = [Utils validateEmail:email];
    if (emailValidationError != OK){
        [LocalizationUtils setText:[Utils getErrorDescription:emailValidationError] forLabel:self.labelServiceMessage];
    } else if (!isSending){
        isSending = YES;
        [self.textEmail resignFirstResponder];
        [self.indicatorSend startAnimating];
        
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            ErrorCodes errorCode = [PurchaseManager beginRegularPoststampsSpending:intriguePrice];
            if (errorCode == OK){
                errorCode = [DataManager sendIntrigueTo:email];
            }
            if (errorCode == OK){
                [PurchaseManager finishRegularPoststampsSpending:intriguePrice];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorSend stopAnimating];
                NSString* resultString = errorCode == OK ? [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_OK] : [Utils getErrorDescription:errorCode];
                [LocalizationUtils setText:resultString forLabel:self.labelServiceMessage];
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    } else {
        [LocalizationUtils setText:[Lang LOC_INTRIGUE_SERVICEMSG_SENDING_INPROGRESS] forLabel:self.labelServiceMessage];
    }
}

- (IBAction)didEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

@end
