//
//  SettingsValuesListTableVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/13/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VALUES_TIME_ZONE 0 // hardcoded!!!
#define VALUES_TIME_FORMAT 1
#define VALUES_DATE_FORMAT 2

@interface SettingsValuesListTableVC : UITableViewController

@property int valuesMode;

@end
