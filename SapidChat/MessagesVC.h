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
#import "DbManager.h"

#define FONT_TIME_DISTANCE_SIZE 13.0f
#define CELL_MSG_TOP_HEIGHT 25.0f
#define CELL_MSG_IMG_PLACEHOLDER_HEIGHT 69.0f;
#define CELL_MSG_BOTTOM_HEIGHT 10.0f

#define FONT_MSG_SIZE 14.0f
#define CELL_MSG_WIDTH 240.0f
#define CELL_MSG_TOPBOTTOM_PADDING 5.0f

#define FONT_SECTIONHEADER_SIZE 11.0f
#define HEADER_HEIGHT 17.0f
#define DAY_LAST_FOOTER_HEIGHT 10.0f;
#define DEFAULT_FOOTER_HEIGHT 4.0f;

typedef enum CellTypes{
    CELL_TOP,
    CELL_TEXT,
    CELL_IMAGE,
    CELL_BOTTOM
} CellTypes;

@interface MessagesVC : UIViewController<UITableViewDataSource,
                                         UITableViewDelegate,
                                         ComposeNewMessageResponseDelegate,
                                         UIActionSheetDelegate,
                                         UIAlertViewDelegate,
                                         AttachmentDataUpdateDelegate,
                                         ATMHudDelegate>

@property Dialog *dialog;
@property (strong, nonatomic) IBOutlet UITableView *tabelMessages;
@property (strong, nonatomic) IBOutlet UIButton *buttonReply;
- (IBAction)replyPressed:(id)sender;
- (IBAction)actionPressed:(id)sender;

@end
