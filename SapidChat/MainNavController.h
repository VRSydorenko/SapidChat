//
//  MainNavController.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainNavController;

@protocol LogoutDelegate
@required
- (void) controllerToLogout:(UINavigationController*)navController;
@end

@interface MainNavController : UINavigationController

@property NSArray* dialogs;
@property NSDate* lastUpdate;

@property (assign) id<LogoutDelegate> logoutHandler;

@end
