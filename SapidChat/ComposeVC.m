//
//  ComposeVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/1/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "ComposeVC.h"
#import "DataManager.h"
#import "MainNavController.h"
#import "UserSettings.h"
#import "Utils.h"
#import "LocalizationUtils.h"
#import "SettingsManager.h"

@interface ComposeVC (){
    bool isSending;
    //NSString* currentMessageText;
}

@end

@implementation ComposeVC
@synthesize textMessage;
@synthesize spinner;
@synthesize buttonLanguage;
@synthesize labelTitle;

@synthesize initialMsgGlobalTimstamp;
@synthesize collocutor;

- (void)viewDidLoad
{
    [super viewDidLoad];
	isSending = NO;
    if (self.collocutor.length > 0){
        self.labelTitle.title = self.collocutor;
        self.buttonLanguage.hidden = YES;
    } else {
        self.labelTitle.title = @"New message";
        [self updateLanguageText];
    }
}

- (void)viewDidUnload
{
    [self setTextMessage:nil];
    [self setSpinner:nil];
    [self setButtonLanguage:nil];
    [self setLabelTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) updateLanguageText{
    [LocalizationUtils setTitle:[Utils getLanguageName:[UserSettings getNewMessagesLanguage] needSelfName:NO] forButton:self.buttonLanguage];
    [self.buttonLanguage sizeToFit];
}

- (IBAction)sendPressed:(id)sender {
    if (!isSending){
        isSending = YES;
        
        [self.spinner startAnimating];
    
        Message* msg = [self prepareMessage];
    
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            ErrorCodes msgSent = [DataManager sendMessage:msg];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.spinner stopAnimating];
                    if (msgSent == OK){
                        [self.composeHandler composeCompleted:msg];
                        [self dismissModalViewControllerAnimated:YES];
                    } else{
                        
                    }
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    }
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)languagePressed:(id)sender {
    [SettingsManager callNewMessagesLanguageScreenOverViewController:self];
}

- (void)msgLangControllerToDismiss:(NewMsgLanguageVC *)msgLangController{
    [self updateLanguageText];
    [msgLangController dismissModalViewControllerAnimated:YES];
}

-(Message*) prepareMessage{
    Message* msg = [[Message alloc] init];
    msg.from = [UserSettings getEmail];
    msg.to = self.collocutor;
    msg.text = self.textMessage.text;
    msg.when = [[NSDate date] timeIntervalSinceReferenceDate];
    msg.initial_message_global_timestamp = initialMsgGlobalTimstamp;
    return msg;
}
@end
