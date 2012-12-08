//
//  MessagesVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/11/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "MessagesVC.h"
#import "DataManager.h"
#import "MessageCell.h"
#import "MainNavController.h"
#import "Utils.h"
#import "UserSettings.h"
#import "ComposeVC.h"
#import "LocalizationUtils.h"
#import "Lang.h"

@interface MessagesVC (){
    NSArray *messages;
    NSDictionary* datesRowCount;
    NSString* me;
    bool replyMode;
    UIActionSheet *actionSheet;
    
    // dimensions
    UIFont* messageFont;
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
    
    [self updateMessages];
    
    me = [UserSettings getEmail];
    self.tabelMessages.dataSource = self;
    self.tabelMessages.delegate = self;
    self.title = [self getCollocutor];
    replyMode = ![[self getCollocutor] isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR];
    
    [self setupActionSheet];
    [self setLocalizableValues];
    
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

-(void) setupActionSheet{
    NSString* title = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE];
    NSString* cancel = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CANCEL];
    NSString* delete = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE];
    NSString* claim = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM];
    actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:delete otherButtonTitles:claim, nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
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

-(void) setLocalizableValues{
    NSString* replyButtonText = replyMode ? [Lang LOC_MESSAGES_MESSAGES_BTN_REPLY] : [Lang LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE];
    forButton:self.buttonReply.title = replyButtonText;
}

-(void) updateMessages{
    messages = [self.dialog getSortedMessages];
    
    datesRowCount = [[NSMutableDictionary alloc] init];
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [datesRowCount allKeys].count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect headerRect = CGRectMake(0, 0, tableView.bounds.size.width, 17);
    UILabel* labelHeader = [[UILabel alloc] initWithFrame:headerRect];
    [labelHeader setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
    labelHeader.textColor = [UIColor lightGrayColor];
    labelHeader.textAlignment = UITextAlignmentCenter;
    labelHeader.text = (NSString*)[[datesRowCount allKeys] objectAtIndex:section];
    return labelHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 17;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number = [[[datesRowCount allValues] objectAtIndex:section] intValue];
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int msgIndex = 0; // real message index according to section
    for (int sec = 0; sec<indexPath.section; sec++) {
        msgIndex += [[[datesRowCount allValues] objectAtIndex:sec] intValue];
    }
    msgIndex += indexPath.row;
    
    Message* msg = (Message*)[messages objectAtIndex:msgIndex];
    
    NSString* cellId = [msg.from isEqualToString:me] ? @"MessageCellMy" : @"MessageCellCollocutor";
        
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell){
        cell.labelMessage.font = messageFont;
        cell.labelMessage.text = msg.text;
        NSDate* localTime = [Utils toLocalDate:msg.when];// !!!
        cell.labelTime.text = [Utils timeToString:localTime];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message* msg = (Message*)[messages objectAtIndex:indexPath.row];
    return [msg.text sizeWithFont:messageFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap].height + CELL_MESSAGE_TOPBOTTOM_PADDING;
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
        [actionSheet showInView:self.view];
    }
}
@end
