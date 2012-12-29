//
//  MainNavController.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "MainNavController.h"
#import "DataManager.h"
#import "SapidInfoBarManager.h"

@interface MainNavController ()

@end

@implementation MainNavController{
    CLLocationManager *locationMgr;
}

@synthesize dialogs = _dialogs;
@synthesize lastUpdate = _lastUpdate;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

@synthesize logoutHandler = _logoutHandler;

-(void) initLocationManager{
    self.latitude = 0;
    self.longitude = 0;
    locationMgr = [[CLLocationManager alloc] init];
    locationMgr.delegate = self;
    [locationMgr setDesiredAccuracy:kCLLocationAccuracyBest];
}

- (BOOL)shouldAutorotate {
    return NO;
}

-(void) startMonitoringLocation{
    if (!locationMgr){
        [self initLocationManager];
    }
    [locationMgr startUpdatingLocation];
}

-(void) stopMonitoringLocation{
    [locationMgr stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.latitude = newLocation.coordinate.latitude;
    self.longitude = newLocation.coordinate.longitude;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}

-(double)calcDistanceTo:(double)latd longitude:(double)lond{
    if (latd == 0 && lond == 0){
        return 0;
    }
    if (self.latitude == 0 && self.longitude == 0){
        return 0;
    }
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    CLLocation *givenLocation = [[CLLocation alloc] initWithLatitude:latd longitude:lond];
    
    return [myLocation distanceFromLocation:givenLocation];
}

-(void) viewDidLoad{
    // Add the infoBar
    [[SapidInfoBarManager sharedManager] initInfoBarWithTopViewFrame:self.navigationBar.frame andHeight:40];
    [self.view insertSubview:[[SapidInfoBarManager sharedManager] infoBar] belowSubview:self.navigationBar];
}

-(void) viewDidUnload{
    [self setDialogs:nil];
    [self setLastUpdate:nil];
    [self setLogoutHandler:nil];
}

@end
