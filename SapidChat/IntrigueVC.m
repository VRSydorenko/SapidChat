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
    if (!isSending){
        isSending = YES;
        
        [self.indicatorSend startAnimating];
        
        NSString* email = self.textEmail.text;
        
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            ErrorCodes msgSent = [DataManager sendIntrigueTo:email];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorSend stopAnimating];
                NSString* resultString = msgSent == OK ? [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_OK] : [Utils getErrorDescription:msgSent];
                [LocalizationUtils setText:resultString forLabel:self.labelServiceMessage];
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    }

}

- (IBAction)didEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

@end
