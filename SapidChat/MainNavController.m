//
//  MainNavController.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "MainNavController.h"
#import "DataManager.h"

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
    locationMgr = [[CLLocationManager alloc] init];
    locationMgr.delegate = self;
    [locationMgr setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationMgr startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.latitude = newLocation.coordinate.latitude;
    self.longitude = newLocation.coordinate.longitude;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}

-(void) viewDidUnload{
    [self setDialogs:nil];
    [self setLastUpdate:nil];
    [self setLogoutHandler:nil];
}

@end
