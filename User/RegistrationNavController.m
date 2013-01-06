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

@interface RegistrationNavController (){
    SapidInfoBarManager *infoManager;
}

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
    
    infoManager = [[SapidInfoBarManager alloc] init];
    if (infoManager){
        [infoManager initInfoBarWithTopViewFrame:self.navigationBar.frame andHeight:40];
        [self.view insertSubview:infoManager.infoBar belowSubview:self.navigationBar];
    }
    
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

- (void)showInfoBarWithNegativeMessage:(NSString*)text{
    [infoManager showInfoBarWithMessage:text withMood:NEGATIVE];
}
- (void)showInfoBarWithPositiveMessage:(NSString*)text{
        [infoManager showInfoBarWithMessage:text withMood:POSITIVE];
}

-(void) dealloc{
    self.email = nil;
    self.password = nil;
    self.nickname = nil;
    self.selectedLanguages = nil;
    infoManager = nil;
}

@end
