//
//  RegistratinoWizardPageVC.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/25/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "RegistrationNavController.h"
#import "User.h"


@interface RegistrationNavController (){
    NSString* SEGUE_EMAIL_TO_NICK;
    NSString* SEGUE_NICK_TO_LANGS;
    NSString* SEGUE_LANGS_TO_FINISH;
}

@end
@implementation RegistrationNavController

@synthesize currentSegue;

@synthesize email = _email;
@synthesize password = _password;
@synthesize saveCreds;
@synthesize nickname = _nickname;
@synthesize selectedLanguages = _selectedLanguages;

@synthesize handler;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.currentSegue = nil;
    self.selectedLanguages = [[NSMutableArray alloc] init];
    SEGUE_EMAIL_TO_NICK = @"SegueEmailToNick";
    SEGUE_NICK_TO_LANGS = @"SegueNickToLangs";
    SEGUE_LANGS_TO_FINISH = @"SegueLangsToFinish";
}

-(void) cancel{
    [self.handler controllerToDismiss:self whichRegisteredTheUser:nil];
}

-(void) increaseCurrentSegue{
    self.currentSegue = [self getNextSegueId:self.currentSegue];
}

-(void) decreaseCurrentSegue{
    self.currentSegue = [self getPreviousSegueId:self.currentSegue];
}

-(NSString*) getNextSegueId{
    return [self getNextSegueId:self.currentSegue];
}

-(BOOL) nowIsInit{
    return self.currentSegue == nil;
}
-(BOOL) nowIsLanguages{
    return [self.currentSegue isEqualToString:SEGUE_NICK_TO_LANGS];
}
-(BOOL) nowIsFinish{
    return [self.currentSegue isEqualToString:SEGUE_LANGS_TO_FINISH];
}

-(User*) composeUser{
    if (self.email.length > 0){
        User* result = [[User alloc] init];
        result.email = self.email;
        result.password = self.password;
        result.nickname = self.nickname;
        result.languages = [[NSArray alloc] initWithArray:self.selectedLanguages copyItems:YES];
        return result;
    }
    return nil;
}

// private

-(NSString*) getPreviousSegueId:(NSString*) segue{
    if (segue == SEGUE_NICK_TO_LANGS){
        return SEGUE_EMAIL_TO_NICK;
    } else if (segue == SEGUE_LANGS_TO_FINISH){
        return SEGUE_NICK_TO_LANGS;
    }
    return nil;
}

-(NSString*) getNextSegueId:(NSString*) lastSegue{
    if (!lastSegue){
        return SEGUE_EMAIL_TO_NICK;
    } else if (lastSegue == SEGUE_EMAIL_TO_NICK){
        return SEGUE_NICK_TO_LANGS;
    } else if (lastSegue == SEGUE_NICK_TO_LANGS){
        return SEGUE_LANGS_TO_FINISH;
    }
    return nil;
}

@end
