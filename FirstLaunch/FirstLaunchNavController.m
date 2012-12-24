//
//  FirstLaunchNavController.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "FirstLaunchNavController.h"

@interface FirstLaunchNavController ()

@end

@implementation FirstLaunchNavController

@synthesize rootViewController = _rootViewController;

- (void) introCloseButtonPressed{
    [self presentViewController:self.rootViewController animated:YES completion:nil];
}

@end
