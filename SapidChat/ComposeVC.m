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

@interface ComposeVC (){
    MainNavController* navController;
    bool isSending;
}

@end

@implementation ComposeVC
@synthesize textMessage;
@synthesize spinner;
@synthesize textTitle;

@synthesize initialMsgGlobalTimstamp;
@synthesize collocutor;

- (void)viewDidLoad
{
    [super viewDidLoad];
	isSending = NO;
    navController = (MainNavController*)self.navigationController;
    if (collocutor.length > 0){
        self.textTitle.title = [@"Reply to " stringByAppendingString:collocutor];
    } else {
        self.textTitle.title = @"New message";
    }
}

- (void)viewDidUnload
{
    [self setTextMessage:nil];
    [self setSpinner:nil];
    [self setTextTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

-(Message*) prepareMessage{
    Message* msg = [[Message alloc] init];
    msg.from = [UserSettings getEmail];
    msg.to = collocutor;
    msg.text = self.textMessage.text;
    msg.when = [[NSDate date] timeIntervalSinceReferenceDate];
    msg.initial_message_global_timestamp = initialMsgGlobalTimstamp;
    return msg;
}
@end
