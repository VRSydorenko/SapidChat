//
//  IntrigueSellVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 10/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "IntrigueSellVC.h"
#import "Lang.h"
#import "LocalizationUtils.h"
#import "UserSettings.h"

@interface IntrigueSellVC ()

@end

@implementation IntrigueSellVC
@synthesize textViewDescription;
@synthesize btnActivate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.textViewDescription.text = [Lang LOC_INTRIGUE_SELL_DESCRIPTION];
    [LocalizationUtils setTitle:[Lang LOC_INTRIGUE_SELL_BTN_ACTIVATE] forButton:self.btnActivate];
}

- (void)viewDidUnload
{
    [self setTextViewDescription:nil];
    [self setBtnActivate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)activatePressed:(id)sender {
    [UserSettings setIntrigueUnlocked];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
