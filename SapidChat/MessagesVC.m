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

@interface MessagesVC (){
    NSArray *messages;
    
    // indexes of first and last messages within a day
    NSArray* firstMsgs;
    NSArray* lastMsgs;
    
    NSString* me;
    bool replyMode;
    UIActionSheet *replyModeActionSheet;
    UIActionSheet *aloneModeActionSheet;
    
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
    
    boundingSize = CGSizeMake(CELL_MESSAGE_WIDTH, CGFLOAT_MAX); // 240 is the width of the message's UILabel
    messageFont = [UIFont fontWithName:@"Helvetica" size:FONT_MSG_SIZE];
    timeAndDistanceFont = [UIFont fontWithName:@"Helvetica" size:FONT_TIME_DISTANCE_SIZE];
    
    [self updateMessages];
    
    me = [UserSettings getEmail];
    self.tabelMessages.dataSource = self;
    self.tabelMessages.delegate = self;
    self.title = [self getCollocutor];
    replyMode = ![[self getCollocutor] isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR];
    if (!replyMode){
        // disable action sheet for 'awaiting reply' messages until it is possible to delete messages from the bank
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self setupActionSheets];
    
    self.buttonReply.title = replyMode ? [Lang LOC_MESSAGES_MESSAGES_BTN_REPLY] : [Lang LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE];;
    
    [DataManager resetUnreadMessagesCountForCollocutor:self.dialog.collocutor];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTabelMessages:nil];
    [self setButtonReply:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) setupActionSheets{
    NSString* title = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE];
    NSString* cancel = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CANCEL];
    
    NSString* delete = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE];
    NSString* claim = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM];
    replyModeActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:delete otherButtonTitles:claim, nil];
    
    NSString* clear = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CLEAR];
    NSString* edit = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_EDIT];
    aloneModeActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:clear otherButtonTitles:edit, nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet == replyModeActionSheet){
        [self processReplyModeActionSheet:buttonIndex];
    } else if (actionSheet == aloneModeActionSheet){
        [self processAloneModeActionSheet:buttonIndex];
    }
}

-(void) processReplyModeActionSheet:(int)buttonIndex{
    switch (buttonIndex) {
        case 0: // delete
        {
            bool ok = YES;
            for (Message* message in messages) {
                if ([DataManager deleteMessage:message] != OK){
                    ok = NO;
                    break;
                }
            }
            if (ok){
                //[self.tabelMessages reloadData];
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        }
        case 1: // claim
        {
            break;
        }
    }
}

-(void) processAloneModeActionSheet:(int)buttonIndex{
    switch (buttonIndex) {
        case 0: // delete
        {
            /*bool ok = YES;
            for (Message* message in messages) {
                if ([DataManager deleteMessage:message] != OK){
                    ok = NO;
                    break;
                }
            }
            if (ok){
                //[self.tabelMessages reloadData];
                [self.navigationController popViewControllerAnimated:YES];
            }*/
            break;
        }
        case 1: // edit
        {
            break;
        }
    }
}

-(void) updateMessages{
    messages = [self.dialog getSortedMessages];
    
    NSDictionary* datesRowCount = [[NSMutableDictionary alloc] init];
    for (int i = 0; i<messages.count; i++) {
        Message* msg = (Message*)[messages objectAtIndex:i];
        NSDate* localDate = [Utils toLocalDate:msg.when];
        NSString* date = [Utils dateToString:localDate];
        id objForKey = [datesRowCount objectForKey:date];
        if (!objForKey){
            [datesRowCount setValue:[NSNumber numberWithInt:1] forKey:date];
        } else {
            [datesRowCount setValue:[NSNumber numberWithInt:[objForKey intValue]+ 1] forKey:date];
        }
    }
    
    NSMutableArray* firsts = [[NSMutableArray alloc] init];
    [firsts addObject:[NSNumber numberWithInt:0]];
    int ndx = 0;
    for (int i = 0; i < [datesRowCount allValues].count - 1; i++) {
        ndx += [[[datesRowCount allValues] objectAtIndex:i] intValue];
        [firsts addObject:[NSNumber numberWithInt:ndx]];
    }
    firstMsgs = [[NSArray alloc] initWithArray:firsts copyItems:YES];
    
    NSMutableArray* lasts = [[NSMutableArray alloc] init];
    ndx = 0;
    for (int i = 0; i < [datesRowCount allValues].count; i++) {
        if (ndx == 0){
            ndx = [[[datesRowCount allValues] objectAtIndex:0] intValue] - 1;
        } else {
            ndx += [[[datesRowCount allValues] objectAtIndex:i] intValue];
        }
        [lasts addObject:[NSNumber numberWithInt:ndx]];
    }
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
        labelHeader.textAlignment = UITextAlignmentCenter;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3; // top, middle, bottom
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{ // top
            Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
            MessageTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTopCell"];
            if (cell){
                cell.labelTime.font = timeAndDistanceFont;
                NSDate* localTime = [Utils toLocalDate:msg.when];// !!!
                cell.labelTime.text = [Utils timeToString:localTime];
                
                NSString* distanceText = @"";
                if ([msg.to isEqualToString:me]){
                    cell.labelDistance.font = timeAndDistanceFont;
                    distanceText = [self getDistanceStringForLatitude:msg.latitude andLongitude:msg.longitude];
                }
                cell.labelDistance.text = distanceText;
            }
            return cell;
        }
        case 1:{ // middle
            Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
            MessageMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageMiddleCell"];
            if (cell){
                cell.labelMessage.font = messageFont;
                cell.labelMessage.text = msg.text;
                
            }
            return cell;
        }
        case 2:{ // bottom
            return [tableView dequeueReusableCellWithIdentifier:@"MessageBottomCell"];
        }
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 5;
    if (indexPath.row == 0){ // top message cell
        height = CELL_MESSAGE_TOP_HEIGHT;
    }
    if (indexPath.row == 1){ // middle message cell
        Message* msg = (Message*)[messages objectAtIndex:indexPath.section];
        height = [msg.text sizeWithFont:messageFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap].height + CELL_MESSAGE_TOPBOTTOM_PADDING;
    }
    if (indexPath.row == 2){ // bottom meccage cell
        height = CELL_MESSAGE_BOTTOM_HEIGHT;
    }
    return height;
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
            NSString* text_f =  [Lang LOC_MESSAGES_CELL_DISTANCE_FOOTS];
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
        [aloneModeActionSheet showInView:self.view];
    }
}
@end
