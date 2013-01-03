//
//  AppDelegate.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 6/30/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmazonKeyChainWrapper.h"
#import "DbManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DbManager *dbManager;

@end
