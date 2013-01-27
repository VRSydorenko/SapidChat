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

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;
@property (strong, nonatomic) IBOutlet UIButton *btnPick;
@property (strong, nonatomic) IBOutlet UIButton *btnCompose;
@property (strong, nonatomic) IBOutlet UITableView *tableDialogs;
- (IBAction)refreshPressed:(id)sender;
- (IBAction)pickPressed:(id)sender;
- (IBAction)composePressed:(id)sender;

@end
