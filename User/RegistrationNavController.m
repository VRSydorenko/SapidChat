//
//  RegistratinoWizardPageVC.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/25/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "RegistrationNavController.h"
#import "User.h"
#import "Lang.h"
#import "SapidInfoBarManager.h"

@interface RegistrationNavController ()

@end
@implementation RegistrationNavController

@synthesize currentSegue;

@synthesize email = _email;
@synthesize password = _password;
@synthesize nickname = _nickname;
@synthesize selectedLanguages = _selectedLanguages;

@synthesize handler;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"barGreenBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[SapidInfoBarManager sharedManager] initInfoBarWithTopViewFrame:self.navigationBar.frame andHeight:40];
    [self.view insertSubview:[[SapidInfoBarManager sharedManager] infoBar] belowSubview:self.navigationBar];
    
    self.currentSegue = nil;
    self.selectedLanguages = [[NSMutableArray alloc] init];
}

-(void) cancel{
    [self.handler controllerToDismiss:self whichRegisteredTheUser:nil];
}

-(User*) composeUser{
    if (self.email.length > 0){
        User* result = [[User alloc] init];
        result.email = self.email;
        result.nickname = self.nickname;
        result.languages = [[NSArray alloc] initWithArray:self.selectedLanguages copyItems:YES];
        result.rp = 10;
        return result;
    }
    return nil;
}

@end
