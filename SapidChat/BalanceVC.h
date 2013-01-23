//
//  BalanceVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseManager.h"

@interface BalanceVC : UIViewController<UITableViewDataSource,
                                        UITableViewDelegate,
                                        CommercialNotificationDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableContent;
- (IBAction)segmentPicked:(id)sender;

@end
