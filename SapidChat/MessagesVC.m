//
//  MessagesVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/11/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "MessagesVC.h"
#import "DataManager.h"
#import "MainNavController.h"
#import "Utils.h"
#import "UserSettings.h"
#import "ComposeVC.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "MessageBottomCell.h"
#import "MessageMiddleCell.h"
#import "MessageTopCell.h"
#import "MessageImageCell.h"

@interface MessagesVC (){
    bool dontDismiss;
    NSArray *messages;
    NSMutableDictionary *selectedCells;
    NSMutableArray *errorCells;
    
    // indexes of first and last messages within a day
    NSArray* firstMsgs;
    NSArray* lastMsgs;
    
    NSString* me;
    bool replyMode;
    UIActionSheet *replyModeActionSheet;
    //UIActionSheet *aloneModeActionSheet;
    
    // dimensions
    UIFont* messageFont;
    UIFont* timeAndDistanceFont;
    CGSize boundingSize;
}

@end

@implementation MessagesVC
@synthesize tabelMessages;
@synthesize buttonReply;
@synthesize dialog = _dialog;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
    selectedCells = [[NSMutableDictionary alloc] init];
    errorCells = [[NSMutableArray alloc] init];
    
    boundingSize = CGSizeMake(CELL_MSG_WIDTH, CGFLOAT_MAX); // 240 is the width of the message's UILabel
    messageFont = [UIFont fontWithName:@"Helvetica" size:FONT_MSG_SIZE];
    timeAndDistanceFont = [UIFont fontWithName:@"Helvetica" size:FONT_TIME_DISTANCE_SIZE];
    
    [self updateMessages];
    
    me = [UserSettings getEmail];
    self.tabelMessages.dataSource = self;
    self.tabelMessages.delegate = self;
    
    NSString* collocutor = [self getCollocutor];
    
    replyMode = ![collocutor isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR];
    if (!replyMode){
        // disable action sheet for 'awaiting reply' messages until it is possible to delete messages from the bank
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.title = [Utils getUserString:collocutor];
    
    [self setupActionSheets];
    
    [LocalizationUtils setTitle:replyMode ? [Lang LOC_MESSAGES_MESSAGES_BTN_REPLY] : [Lang LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE] forButton:self.buttonReply];
    [self.buttonReply sizeToFit];
    
    if ([collocutor isEqualToString:SYSTEM_USER]){
        self.buttonReply.enabled = NO;
    }
    
    dontDismiss = NO;
    
    [DataManager resetUnreadMessagesCountForCollocutor:self.dialog.collocutor];
}

- (void)dealloc
{
    [self setTabelMessages:nil];
    [self setButtonReply:nil];
    messages = nil;
    selectedCells = nil;
    errorCells = nil;
    firstMsgs = nil;
    lastMsgs = nil;
    me = nil;
    replyModeActionSheet = nil;
    messageFont = nil;
    timeAndDistanceFont = nil;
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated{
    [self.tabelMessages reloadData];
}

-(void) viewDidAppear:(BOOL)animated{
    CGPoint contentOffset = CGPointMake(0, [self.tabelMessages contentSize].height -  self.tabelMessages.bounds.size.height);
    [self.tabelMessages setContentOffset:contentOffset animated:YES];
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setupActionSheets{
    NSString* title = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE];
    NSString* cancel = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CANCEL];
    
    NSString* delete = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE];
    //NSString* claim = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM];
    replyModeActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:delete otherButtonTitles:/*claim,*/ nil];
    
    /*NSString* clear = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CLEAR];
    NSString* edit = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_EDIT];
    aloneModeActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:clear otherButtonTitles:edit, nil];*/
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet == replyModeActionSheet){
        [self processReplyModeActionSheet:buttonIndex];
    }/* else if (actionSheet == aloneModeActionSheet){
        [self processAloneModeActionSheet:buttonIndex];
    }*/
}

-(void) processReplyModeActionSheet:(int)buttonIndex{
    switch (buttonIndex) {
        case 0: // delete
        {
            [self askToConfirmDeletion];
            break;
        }
        case 1: // claim
        {
            break;
        }
    }
}

-(void) processAloneModeActionSheet:(int)buttonIndex{
    /*switch (buttonIndex) {
        case 0: // delete
        {
            break;
        }
        case 1: // edit
        {
            break;
        }
    }*/
}

-(void) updateMessages{
    messages = nil;
    messages = [[NSArray alloc] initWithArray: [self.dialog getSortedMessages] copyItems:YES];
    
    Message* msg;
    NSMutableArray* dateKeys = [[NSMutableArray alloc] init];
    NSDictionary* datesRowCount = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < messages.count; i++) {
        msg = (Message*)[messages objectAtIndex:i];
        
        NSDate* dateOnly = [Utils dateWithoutTime:[Utils toLocalDate:msg.when]];
        if (![dateKeys containsObject:dateOnly]){
            [dateKeys addObject:dateOnly];
        }
        
        NSString* date = [Utils dateToString:dateOnly];
        id objForKey = [datesRowCount objectForKey:date];
        if (!objForKey){
            [datesRowCount setValue:[NSNumber numberWithInt:1] forKey:date];
        } else {
            [datesRowCount setValue:[NSNumber numberWithInt:[objForKey intValue]+1] forKey:date];
        }
    }
    
    NSMutableArray* firsts = [[NSMutableArray alloc] init];
    [firsts addObject:[NSNumber numberWithInt:0]];
    int ndx = 0;
    
    [dateKeys sortUsingSelector:@selector(compare:)];
    for (NSDate* nextSortedDate in dateKeys){
        int val = [[datesRowCount objectForKey:[Utils dateToString:nextSortedDate]] intValue];
        ndx += val;
        [firsts addObject:[NSNumber numberWithInt:ndx]];
    }
    firstMsgs = nil;
    firstMsgs = [[NSArray alloc] initWithArray:firsts copyItems:YES];
    
    NSMutableArray* lasts = [[NSMutableArray alloc] init];
    ndx = 0;
    for (NSDate* nextSortedDate in dateKeys){
        if (ndx == 0){
            ndx = [[datesRowCount objectForKey:nextSortedDate] intValue] - 1;
        } else {
            ndx += [[datesRowCount objectForKey:nextSortedDate] intValue];
        }
        [lasts addObject:[NSNumber numberWithInt:ndx]];
    }
    lastMsgs = nil;
    lastMsgs = [[NSArray alloc] initWithArray:lasts copyItems:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return messages.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([firstMsgs containsObject:[NSNumber numberWithInt:section]]){
        CGRect headerRect = CGRectMake(0, 0, tableView.bounds.size.width, HEADER_HEIGHT);
        UILabel* labelHeader = [[UILabel alloc] initWithFrame:headerRect];
        [labelHeader setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FONT_SECTIONHEADER_SIZE]];
        labelHeader.textColor = [UIColor lightGrayColor];
        labelHeader.textAlignment = NSTextAlignmentCenter;
        labelHeader.backgroundColor = [UIColor clearColor];
        NSDate* localDate = [Utils toLocalDate:((Message*)[messages objectAtIndex:section]).when];// !!!
        labelHeader.text = [Utils dateToString:localDate];
        return labelHeader;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([firstMsgs containsObject:[NSNumber numberWithInt:section]]){
        return HEADER_HEIGHT;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([lastMsgs containsObject:[NSNumber numberWithInt:section]]){
            return DAY_LAST_FOOTER_HEIGHT;
        }
    return DEFAULT_FOOTER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([self getCellTypeByIndexPath:indexPath]) {
        case CELL_TOP:
            return CELL_MSG_TOP_HEIGHT;
        case CELL_TEXT:{
            Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
            return [msg.text sizeWithFont:messageFont constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping].height + CELL_MSG_TOPBOTTOM_PADDING;
        }
        case CELL_IMAGE:{
            Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
            if ([self cellIsSelected:indexPath] && msg.attachmentData.length > 0){
                UIImage *img = [UIImage imageWithData:msg.attachmentData];
                if (img.size.height >= img.size.width){
                    return CELL_MSG_IMG_PORTRAIT_HEIGHT;
                } else{
                    return CELL_MSG_IMG_LANDSCAPE_HEIGHT;
                }
            }
            return CELL_MSG_IMG_PLACEHOLDER_HEIGHT;
        }
        case CELL_BOTTOM:
            return CELL_MSG_BOTTOM_HEIGHT;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Message* msg = (Message*)[messages objectAtIndex:section];
    int num = 2; // at least top and bottom
    if (msg.text.length > 0){
        num++;
    }
    if (msg.attachmentName.length > 0){
        num++;
    }
    if (num == 2){
        NSLog(@"Error! MessagesVC:numberOfRowsInSection: only 2 (top and bottom)");
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
    bool incoming = [msg.to isEqualToString:me];
    switch ([self getCellTypeByIndexPath:indexPath]) {
        case CELL_TOP:{
            MessageTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTopCell"];
            if (cell){
                cell.labelTime.font = timeAndDistanceFont;
                NSDate* localTime = [Utils toLocalDate:msg.when];
                cell.labelTime.text = [Utils timeToString:localTime];
                
                NSString* distanceText = @"";
                if (incoming && [UserSettings premiumUnlocked]){
                    cell.labelDistance.font = timeAndDistanceFont;
                    distanceText = [self getDistanceStringForLatitude:msg.latitude andLongitude:msg.longitude];
                }
                cell.labelDistance.text = distanceText;
                
                UIImage* bgImg = [self getTopMessageCellImageBkg:msg.type incoming:incoming];
                cell.backgroundView = [[UIImageView alloc] initWithImage:bgImg];
            }
            return cell;
        }
        case CELL_TEXT:{
            MessageMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageMiddleCell"];
            if (cell){
                cell.labelMessage.font = messageFont;
                cell.labelMessage.text = msg.text;
                
                UIImage* bgImg = [self getMidMessageCellImageBkg:msg.type incoming:incoming];
                cell.backgroundView = [[UIImageView alloc] initWithImage:bgImg];
            }
            return cell;
        }
        case CELL_IMAGE:{
            MessageImageCell* imgCell = [tableView dequeueReusableCellWithIdentifier:@"MessageImageCell"];
            NSString* infoString = @"";
            if (imgCell){
                if ([UserSettings premiumUnlocked]){
                    if (msg.attachmentData.length){
                        imgCell.imgView.image = [[UIImage alloc] initWithData:msg.attachmentData];
                        infoString = @"";
                    } else {
                        imgCell.imgView.image = [UIImage imageNamed:@"image.png"];
                        if ([errorCells containsObject:indexPath]){
                            infoString = [Lang LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE];
                        } else {
                            infoString = [Lang LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE];
                        }
                    }
                } else {
                    imgCell.imgView.image = [UIImage imageNamed:@"lock.png"];
                    infoString = [Lang LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE];
                }
                UIImage* bgImg = [self getMidMessageCellImageBkg:msg.type incoming:incoming];
                imgCell.backgroundView = [[UIImageView alloc] initWithImage:bgImg];
                
                imgCell.labelInfoText.text = infoString;
            }
            return imgCell;
        }
        case CELL_BOTTOM:{
            MessageBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageBottomCell"];
            if (cell){
                UIImage* bgImg = [self getBottomMessageCellImageBkg:msg.type incoming:incoming];
                cell.backgroundView = [[UIImageView alloc] initWithImage:bgImg];
                return cell;
            }
        }
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self getCellTypeByIndexPath:indexPath] == CELL_IMAGE){
        Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
        if (msg.attachmentData.length > 0){
            [self handleCellExpandation:indexPath];
        } else if ([UserSettings premiumUnlocked]){
            MessageImageCell* cell = (MessageImageCell*)[tableView cellForRowAtIndexPath:indexPath];
            cell.imgView.image = nil;
            [cell.activityIndicator startAnimating];
            cell.labelInfoText.text = [Lang LOC_MESSAGES_CELL_LOADING];
            [DataManager requestAttachmentData:msg.attachmentName delegate:self];
        } else {
            // more about pro
        }
    }
}

- (BOOL) cellIsSelected:(NSIndexPath *)indexPath {
	NSNumber *selectedIndex = [selectedCells objectForKey:indexPath];
	return selectedIndex == nil ? NO : [selectedIndex boolValue];
}

-(void) handleCellExpandation:(NSIndexPath *)indexPath{
	[self.tabelMessages deselectRowAtIndexPath:indexPath animated:YES];
	
	BOOL isSelected = ![self cellIsSelected:indexPath];
	
	NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
	[selectedCells setObject:selectedIndex forKey:indexPath];
    
	[self.tabelMessages beginUpdates];
	[self.tabelMessages endUpdates];
}

-(void)attachmentDataUpdatedForName:(NSString*)attachmentName data:(NSData*)attachmentData{
    Message* msg;
    for (int i = 0; i<messages.count; i++) {
        msg = (Message*)[messages objectAtIndex:i];
        if ([msg.attachmentName isEqualToString:attachmentName]){
            // TODO: defining a row carefully
            int rowIndex = msg.text.length > 0 ? 2 : 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:i];
            MessageImageCell* cell = (MessageImageCell*)[self.tabelMessages cellForRowAtIndexPath:indexPath];
            if ([UIImage imageWithData:attachmentData]){
                msg.attachmentData = attachmentData;
            } else {
                // TODO: implement
                // error dowloading data
                [errorCells addObject:indexPath];
            }
            [cell.activityIndicator stopAnimating];
            [self.tabelMessages reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
    }
}

-(CellTypes) getCellTypeByIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.row == 0){ // top message cell
        return CELL_TOP;
    }
    
    Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
    if (indexPath.row == 1 && msg.text.length > 0){ // must be a text cell
        return CELL_TEXT;
    }
    if (indexPath.row == 1 && msg.attachmentName.length > 0){ // must be an image cell
        return CELL_IMAGE;
    }
    if (indexPath.row == 2 && msg.attachmentName.length > 0 && msg.text.length > 0){
        return CELL_IMAGE;
    }
    
    return CELL_BOTTOM;
}

- (UIImage*) getTopMessageCellImageBkg:(int)msgType incoming:(bool)incoming{
    NSString* fileName = [NSString stringWithFormat:@"%@_top.png", [self getMsgCellImageNameStart:msgType incoming:incoming]];
    return [UIImage imageNamed:fileName];
}

- (UIImage*) getMidMessageCellImageBkg:(int)msgType incoming:(bool)incoming{
    NSString* fileName = [NSString stringWithFormat:@"%@_mid.png", [self getMsgCellImageNameStart:msgType incoming:incoming]];
    return [UIImage imageNamed:fileName];
}

- (UIImage*) getBottomMessageCellImageBkg:(int)msgType incoming:(bool)incoming{
    NSString* fileName = [NSString stringWithFormat:@"%@_bottom.png", [self getMsgCellImageNameStart:msgType incoming:incoming]];
    return [UIImage imageNamed:fileName];
}

-(NSString*) getMsgCellImageNameStart:(int)type incoming:(bool)incoming{
    NSString* fileName = @"msg_%@_%@";
    NSString* inOutSpecifier = incoming || type == MSG_SYSTEM ? @"in" : @"out"; // system are always In
    NSString* typeSpecifier;
    switch (type) {
        case MSG_REGULAR:
            typeSpecifier = @"regular";
            break;
        case MSG_SYSTEM:
            typeSpecifier = @"system";
            break;
        case MSG_INTRIGUE:
            typeSpecifier = @"intrigue";
            break;
    }
    return [NSString stringWithFormat:fileName, inOutSpecifier, typeSpecifier];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueDialogToCompose"]){
        ComposeVC* compoceVC = (ComposeVC*)segue.destinationViewController;
        compoceVC.composeHandler = self;
        [compoceVC setNavigationController:(MainNavController*)self.navigationController];
        if (replyMode){
            compoceVC.collocutor = [self getCollocutor];
            compoceVC.initialMsgGlobalTimstamp = [self getInitialMessageGlobalTimestamp];
        }
    }
}

-(NSString*) getDistanceStringForLatitude:(double)latd andLongitude:(double)lond{
    NSString* formattedDistance = @"";
    double meters = [((MainNavController*)self.navigationController) calcDistanceTo:latd longitude:lond];
    if (meters != 0){
        if ([Utils getIfMetricMeasurementSystem]){
            int km = meters / 1000;
            if (km > 0){
                meters = (int)meters%1000;
            }
            NSString* text_m =  [Lang LOC_MESSAGES_CELL_DISTANCE_METERS];
            if (km > 0){
                NSString* text_km = [Lang LOC_MESSAGES_CELL_DISTANCE_KILOMETERS];
                return [NSString stringWithFormat:@"%d%@ %d%@", km, text_km, (int)meters, text_m];
            } else {
                return [NSString stringWithFormat:@"%d%@", (int)meters, text_m];
            }
        } else {
            double feets = meters * 3.2808399;
            int miles = feets / 5280;
            if (miles > 0){
                feets = (int)feets % 5280;
            }
            NSString* text_f =  [Lang LOC_MESSAGES_CELL_DISTANCE_FEETS];
            if (miles > 0){
                NSString* text_m = [Lang LOC_MESSAGES_CELL_DISTANCE_MILES];
                return [NSString stringWithFormat:@"%d%@ %d%@", miles, text_m, (int)feets, text_f];
            } else {
                return [NSString stringWithFormat:@"%d%@", (int)feets, text_f];
            }
        }
    }
    return formattedDistance;
}

-(void) composeCompleted:(Message*)composedMsg{
    [self.dialog addMessage:composedMsg];
    [self updateMessages];
    [self.tabelMessages reloadData];
}

-(NSString*) getCollocutor{
    Message* anyMsg = (Message*)[messages objectAtIndex:0];
    return [anyMsg.to isEqualToString:me] ? anyMsg.from : anyMsg.to;
}

-(int) getInitialMessageGlobalTimestamp{// dates
    for (Message* msg in messages) {
        if ([msg.from isEqualToString:me]){ // it's not the first respond, return 0
            return 0;
        } else {
            return msg.when;
        }
    }
    return 0;
}

- (IBAction)replyPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueDialogToCompose" sender:self];
}

- (IBAction)actionPressed:(id)sender {
    if (replyMode){
        [replyModeActionSheet showInView:self.view];
    } else {
        //[aloneModeActionSheet showInView:self.view];
    }
}

-(void) askToConfirmDeletion{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""/*[Lang LOC_MESSAGES_ALERT_DELETION_TITLE]*/ message:[Lang LOC_MESSAGES_ALERT_DELETION_QUESTION] delegate:self cancelButtonTitle:[Lang LOC_MESSAGES_ALERT_DELETION_CANCEL] otherButtonTitles:[Lang LOC_MESSAGES_ALERT_DELETION_OK], nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [self deleteDialog];
    }
}

-(void) deleteDialog{
    NSString* collocutor = [self getCollocutor];
    
    MainNavController* navCon = (MainNavController*)self.navigationController;
    if (![self.view.subviews containsObject:navCon.hud.view]){
        navCon.hud.delegate = self;
        [self.view addSubview:navCon.hud.view];
    }
    [navCon.hud setCaption:[Lang LOC_COMPOSE_DLG_DELETING]];
    [navCon.hud setProgress:1.0 / messages.count];
    [navCon.hud show];
           
    dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
    dispatch_async(refreshQueue, ^{
        BOOL ok = YES;
        
        float step = 1.0 / messages.count;
        float progress = step;
        
        for (Message* message in messages) {
            if ([DataManager deleteMessage:message] != OK){
                ok = NO;
                break;
            }
            progress += step;
            dispatch_async(dispatch_get_main_queue(), ^{
                [navCon.hud setProgress:progress];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ok && collocutor.length > 0){
                dontDismiss = NO;
                [DataManager deleteUser:collocutor];
                [self deletionCompletedOk:YES];
            } else {
                dontDismiss = YES;
                [self deletionCompletedOk:NO];
            }
        });
    });
    dispatch_release(refreshQueue);
}

-(void) deletionCompletedOk:(bool)ok{
    MainNavController* navCon = (MainNavController*)self.navigationController;
    [navCon.hud setProgress:0.0];
    [navCon.hud setActivity:NO];
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
        if (ok){
            [navCon.hud setCaption:[Lang LOC_COMPOSE_MSG_OPERATION_SUCCEEDED]];
            [navCon.hud setImage:[UIImage imageNamed:@"whiteCheckmark.png"]];
            [navCon.hud setHideSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
        } else {
            [navCon.hud setCaption:[Lang LOC_COMPOSE_MSG_OPERATION_FAILED]];
            [navCon.hud setImage:[UIImage imageNamed:@"whiteCross.png"]];
            //[navCon.hud setHideSound:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"wav"]];
        }
        [navCon.hud update];
        [navCon.hud hideAfter:0.4];
    } else {
        [self backPressed];
    }
}

- (void)hudDidDisappear:(ATMHud *)_hud{
    if (!dontDismiss){
        [self backPressed];
    }
}
@end
