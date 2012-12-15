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

#define FONT_TIME_DISTANCE_SIZE 11.0f
#define CELL_MESSAGE_TOP_HEIGHT 20.0f
#define CELL_MESSAGE_BOTTOM_HEIGHT 10.0f

#define FONT_MSG_SIZE 14.0f
#define CELL_MESSAGE_WIDTH 240.0f
#define CELL_MESSAGE_TOPBOTTOM_PADDING 5.0f

#define FONT_SECTIONHEADER_SIZE 11.0f
#define HEADER_HEIGHT 17.0f
#define DAY_LAST_FOOTER_HEIGHT 7.0f;

@interface MessagesVC : UIViewController<UITableViewDataSource, UITableViewDelegate, ComposeNewMessageResponseDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property Dialog *dialog;
@property (strong, nonatomic) IBOutlet UITableView *tabelMessages;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonReply;
- (IBAction)replyPressed:(id)sender;
- (IBAction)actionPressed:(id)sender;

@end
