//
//  DialogsVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeVC.h"


@interface DialogsVC : UIViewController<UITableViewDataSource, UITableViewDelegate, ComposeNewMessageResponseDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableDialogs;
- (IBAction)refreshPressed:(id)sender;

@end
