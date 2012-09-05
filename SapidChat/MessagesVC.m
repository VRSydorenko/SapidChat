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

@interface MessagesVC (){
    NSArray *messages;
    NSDictionary* datesRowCount;
    NSString* me;
    
    // dimensions
    UIFont* messageFont;
    CGSize boundingSize;
}

@end

@implementation MessagesVC
@synthesize tabelMessages;
@synthesize dialog = _dialog;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    boundingSize = CGSizeMake(240, CGFLOAT_MAX); // 240 is the width of the message's UILabel
    messageFont = [UIFont fontWithName:@"Helvetica" size:FONT_MSG_SIZE];
    
    [self updateMessages];
    
    me = [UserSettings getEmail];
    self.tabelMessages.dataSource = self;
    self.tabelMessages.delegate = self;
    self.title = [self getCollocutor];
    
    [UserSettings resetUnreadMessagesCountForCollocutor:self.dialog.collocutor];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTabelMessages:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) updateMessages{
    messages = [self.dialog getSortedMessages];
    
    datesRowCount = [[NSMutableDictionary alloc] init];
    for (int i=0; i<messages.count; i++) {
        NSString* date = [Utils dateToString:((Message*)[messages objectAtIndex:i]).when];
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
        cell.labelTime.text = [Utils timeToString:[Utils toLocalTime:msg.when]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message* msg = (Message*)[messages objectAtIndex:indexPath.row];
    return [msg.text sizeWithFont:messageFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap].height+10;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueDialogToCompose"]){
        ComposeVC* compoceVC = (ComposeVC*)segue.destinationViewController;
        compoceVC.composeHandler = self;
        compoceVC.collocutor = [self getCollocutor];
        compoceVC.initialMsgGlobalTimstamp = [self getInitialMessageGlobalTimestamp];
    }
}

-(void) composeCompleted:(Message*)composedMsg{
    [self.dialog addMessage:composedMsg];
    [self updateMessages];
    [self.tabelMessages reloadData];
}

-(NSString*) getCollocutor{
    Message* anyMsg = (Message*)[messages objectAtIndex:0];
    NSString* col = [anyMsg.to isEqualToString:me] ? anyMsg.from : anyMsg.to;
    return [col isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR] ? nil : col;
}

-(int) getInitialMessageGlobalTimestamp{// dates
    for (Message* msg in messages) {
        if ([msg.from isEqualToString:me]){ // it's not the first respond, return nil
            return 0;
        } else {
            return (int)[msg.when timeIntervalSinceReferenceDate];
        }
    }
    return 0;
}

@end
