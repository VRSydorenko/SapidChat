//
//  MainNavController.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainNavController : UINavigationController

@property NSString* me;
@property NSArray* dialogs;
@property NSDate* lastUpdate;

@end
