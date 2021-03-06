//
//  MainNavController.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ATMHud.h"

@class MainNavController;

@interface MainNavController : UINavigationController <CLLocationManagerDelegate>

@property UIViewController* rootViewController;
@property ATMHud* hud;
@property NSArray* dialogs;
@property NSDate* lastUpdate;
@property double latitude;
@property double longitude;

-(void) startMonitoringLocation;
-(void) stopMonitoringLocation;
-(double)calcDistanceTo:(double)latd longitude:(double)lond;

- (void)showInfoBarWithNegativeMessage:(NSString*)text;
- (void)showInfoBarWithNeutralMessage:(NSString*)text;
- (void)showInfoBarWithPositiveMessage:(NSString*)text;

@end
