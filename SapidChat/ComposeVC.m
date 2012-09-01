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

@interface ComposeVC (){
    MainNavController* navController;
}

@end

@implementation ComposeVC
@synthesize textMessage;
@synthesize spinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    navController = (MainNavController*)self.navigationController;
}

- (void)viewDidUnload
{
    [self setTextMessage:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sendPressed:(id)sender {
    [self.spinner startAnimating];
    
    dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
    dispatch_async(refreshQueue, ^{
        ErrorCodes msgSent = [DataManager sendMessage:self.textMessage.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stopAnimating];
            if (msgSent == OK){
                [self.composeHandler composeCompleted];
                [self dismissModalViewControllerAnimated:YES];
            } else{
                
            }
        });
    });
    
    dispatch_release(refreshQueue);
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
