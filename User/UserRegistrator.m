//
//  UserRegistrator.m
//  SChat
//
//  Created by Viktor Sydorenko on 6/5/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "UserRegistrator.h"
#import "RegistrationNavController.h"

@implementation UserRegistrator

+ (void) registerUserOverCurrentViewController:(UIViewController <UserRegistrationDelegate>*)currentViewController{
    RegistrationNavController *navcon = [[UIStoryboard storyboardWithName:@"UserRegistration" bundle:nil] instantiateViewControllerWithIdentifier:@"SceneRegistration"];
    navcon.handler = currentViewController;
    [currentViewController presentModalViewController:navcon animated:YES];
}

@end
