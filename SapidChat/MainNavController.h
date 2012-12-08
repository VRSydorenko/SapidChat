//
//  MainNavController.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class MainNavController;

@protocol LogoutDelegate
@required
- (void) controllerToLogout:(UINavigationController*)navController;
@end

@interface MainNavController : UINavigationController <CLLocationManagerDelegate>

@property NSArray* dialogs;
@property NSDate* lastUpdate;
@property double latitude;
@property double longitude;

@property (assign) id<LogoutDelegate> logoutHandler;

- (void) initLocationManager;

@end
