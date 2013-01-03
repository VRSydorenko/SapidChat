//
//  AppDelegate.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 6/30/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "AppDelegate.h"
#import "UserSettings.h"
#import "ViewController.h"
#import "FirstLaunchNavController.h"

@implementation AppDelegate

@synthesize dbManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.dbManager = [[DbManager alloc] init];
    
    ViewController* vc = (ViewController*)self.window.rootViewController;
    if (vc){
        vc.dismissOnLogin = NO;
    }
    
    // Override point for customization after application launch.
    if (![UserSettings hasLaunched]){
        FirstLaunchNavController* navcon = [[UIStoryboard storyboardWithName:@"FirstLaunch" bundle:nil] instantiateViewControllerWithIdentifier:@"SceneFirstLaunch"];
        navcon.rootViewController = self.window.rootViewController;
        self.window.rootViewController = navcon;
    } else if (![[UserSettings getEmail] isEqualToString:@""] &&
        ![[AmazonKeyChainWrapper getValueFromKeyChain:[UserSettings getEmail]] isEqualToString:@""]){
        MainNavController* navcon = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SceneMain"];
        navcon.rootViewController = self.window.rootViewController;
        self.window.rootViewController = navcon;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIApplication  *app = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier bgTask = 0;
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
    }];}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[self.dbManager open];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.dbManager close];
}

@end
