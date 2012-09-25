//
//  FirstScreensVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/25/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "FirstScreensVC.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "FirstLaunchNavController.h"

@interface FirstScreensVC ()

@end

@implementation FirstScreensVC
@synthesize labelWelcome;
@synthesize labelCompose;
@synthesize labelPickUp;
@synthesize labelCommunicate;
@synthesize btnNext;
@synthesize btnGo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.btnNext){
        [LocalizationUtils setTitle:[Lang LOC_FIRSTLAUNCH_BTN_NEXT] forButton:self.btnNext];
    }
    if (self.btnGo){
        [LocalizationUtils setTitle:[Lang LOC_FIRSTLAUNCH_BTN_GO] forButton:self.btnGo];
    }
    if (self.labelWelcome){
        self.labelWelcome.text = [Lang LOC_FIRSTLAUNCH_LABEL_WELCOME];
        [self.labelWelcome sizeToFit];
    }
    if (self.labelCompose){
        self.labelCompose.text = [Lang LOC_FIRSTLAUNCH_LABEL_COMPOSE];
        [self.labelCompose sizeToFit];
    }
    if (self.labelPickUp){
        self.labelPickUp.text = [Lang LOC_FIRSTLAUNCH_LABEL_PICKITUP];
        [self.labelPickUp sizeToFit];
    }
    if (self.labelCommunicate){
        self.labelCommunicate.text = [Lang LOC_FIRSTLAUNCH_LABEL_COMMUNICATE];
        [self.labelCommunicate sizeToFit];
    }
}

- (void)viewDidUnload
{
    [self setBtnNext:nil];
    [self setBtnGo:nil];
    [self setLabelWelcome:nil];
    [self setLabelCompose:nil];
    [self setLabelPickUp:nil];
    [self setLabelCommunicate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goPressed:(id)sender {
    FirstLaunchNavController* navcon = (FirstLaunchNavController*)self.navigationController;
    [navcon exit];
}
@end
