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

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnPick;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCompose;
@property (strong, nonatomic) IBOutlet UITableView *tableDialogs;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinnerPick;
- (IBAction)refreshPressed:(id)sender;
- (IBAction)pickPressed:(id)sender;
- (IBAction)composePressed:(id)sender;

@end
