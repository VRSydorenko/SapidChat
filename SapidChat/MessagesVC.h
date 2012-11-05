//
//  MessagesVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/11/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dialog.h"
#import "ComposeVC.h"

#define FONT_MSG_SIZE 14.0f
#define CELL_MESSAGE_WIDTH 263.0f
#define CELL_MESSAGE_TOPBOTTOM_PADDING 5.0f

@interface MessagesVC : UIViewController<UITableViewDataSource, UITableViewDelegate, ComposeNewMessageResponseDelegate>

@property Dialog *dialog;
@property (strong, nonatomic) IBOutlet UITableView *tabelMessages;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonReply;
- (IBAction)replyPressed:(id)sender;

@end
