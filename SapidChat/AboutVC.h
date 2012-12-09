//
//  AboutVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/9/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableAbout;
@end
