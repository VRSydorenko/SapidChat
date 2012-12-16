//
//  FirstLaunchNavController.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroVC.h"

@interface FirstLaunchNavController : UINavigationController<IntroScreenDelegate>

@property UIViewController* rootViewController;


@end
