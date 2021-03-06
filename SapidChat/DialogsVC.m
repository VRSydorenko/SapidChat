//
//  DialogsVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "DialogsVC.h"
#import "Dialog.h"
#import "DialogCell.h"
#import "DataManager.h"
#import "MainNavController.h"
#import "MessagesVC.h"
#import "ComposeVC.h"
#import "UserSettings.h"
#import "Lang.h"
#import "LocalizationUtils.h"
#import "SapidInfoBarManager.h"
#import "Utils.h"

@interface DialogsVC (){
    MainNavController* navController;
    
    bool isPicking;
    Dialog *selectedDialog;
}

@end

@implementation DialogsVC
@synthesize btnPick;
@synthesize btnCompose;
@synthesize tableDialogs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    self.title = [Lang LOC_MESSAGES_TITLE];
    
    [LocalizationUtils setTitle:[Lang LOC_MESSAGES_BTN_COMPOSE] forButton:self.btnCompose];
    [self.btnCompose sizeToFit];
    
    [LocalizationUtils setTitle:[Lang LOC_MESSAGES_BTN_PICKNEW] forButton:self.btnPick];
    [self.btnPick sizeToFit];
    CGRect frame = self.btnPick.frame;
    frame.origin.x = 320/*display width*/ - 20/*padding*/ - self.btnPick.bounds.size.width;
    self.btnPick.frame = frame;
    
    isPicking = NO;
    navController = (MainNavController*)self.navigationController;
    self.tableDialogs.dataSource = self;
    self.tableDialogs.delegate = self;
    selectedDialog = nil;
}

- (void)dealloc
{
    [self setTableDialogs:nil];
    [self setBtnPick:nil];
    [self setBtnCompose:nil];
    selectedDialog = nil;
    navController = nil;
}

-(void) viewWillAppear:(BOOL)animated{
    navController.dialogs = [DataManager getSavedDialogs];
    [self.tableDialogs reloadData];
}

-(void) viewWillDisappear:(BOOL)animated{
    if ([navController.viewControllers indexOfObject:self] == NSNotFound){ // back button
        [navController stopMonitoringLocation];
    }
}

-(void) backPressed{
    [navController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (navController.dialogs.count == 0){
        return 1; // for "No data" message
    }
    return navController.dialogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (navController.dialogs.count == 0) { // if no data - return one cell-message
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = [Lang LOC_MESSAGES_CELL_NO_RECORDS];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialogCell"];
    if (cell){
        Dialog *dialog = [navController.dialogs objectAtIndex:indexPath.row];
        NSString* stringCollocutor = dialog.collocutor ? dialog.collocutor : [UserSettings getEmail];
        cell.labelCollocutor.text = [Utils getUserString:stringCollocutor];
        Message *msg = (Message*)[[dialog getSortedMessages] lastObject];
        cell.infoMessage.text = msg.text.length > 0 ? msg.text : msg.attachmentName.length > 0 ? [Lang LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT] : @"ERROR";
        
        cell.viewEnvelopePattern.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"envelope_pattern.png"]];
        
        if (dialog.collocutor && [DataManager getUnreadMessagesCountForCollocutor:dialog.collocutor] > 0){
            cell.imageEnvelopeRight.image = [UIImage imageNamed:@"envelope_right.png"];
        } else {
            cell.imageEnvelopeRight.image = [UIImage imageNamed:@"envelope_right_torn.png"];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (navController.dialogs.count > 0){
        selectedDialog = [navController.dialogs objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"SegueDialogsToDialog" sender:self];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueDialogsToDialog"]){
        MessagesVC* messagesVC = (MessagesVC*)segue.destinationViewController;
        messagesVC.dialog = selectedDialog;
    }
    if ([segue.identifier isEqualToString:@"SegueDialogsToCompose"]){
        ComposeVC *composeVC = (ComposeVC*) segue.destinationViewController;
        composeVC.composeHandler = self;
        [composeVC setNavigationController:navController]; // for GPS
    }
}

-(void)startSpinnerOnRightBarButtonItem{
    if (self.navigationItem.rightBarButtonItem == self.btnRefresh){
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    }
}

- (IBAction)refreshPressed:(id)sender {
    [self startSpinnerOnRightBarButtonItem];
    
    dispatch_queue_t refreshQueue = dispatch_queue_create("refresh Queue", NULL);
    dispatch_async(refreshQueue, ^{
        [navController performSelectorOnMainThread:@selector(setDialogs:) withObject:[DataManager getAllDialogs] waitUntilDone:YES];
//        navController.dialogs = [DataManager getAllDialogs];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableDialogs reloadData];
            if (!isPicking){
                self.navigationItem.rightBarButtonItem = self.btnRefresh;
            }
        });
    });
}

- (IBAction)pickPressed:(id)sender {
    if (!isPicking){
        isPicking = YES;
        [self startSpinnerOnRightBarButtonItem];
        
        dispatch_queue_t refreshQueue = dispatch_queue_create("pick Queue", NULL);
        dispatch_async(refreshQueue, ^{
            ErrorCodes pickResult = [DataManager pickNewMessage];
            if (pickResult == OK){
                navController.dialogs = [DataManager getAllDialogs];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (pickResult == OK){
                    [self.tableDialogs reloadData];
                } else if (pickResult == SYSTEM_NO_MESSAGES_TO_PICKUP){
                    [navController showInfoBarWithNeutralMessage:[Lang LOC_MESSAGES_CELL_NO_MSG_TOPICKUP]];
                }
                self.navigationItem.rightBarButtonItem = self.btnRefresh;
                isPicking = NO;
            });
        });
    }
}

- (IBAction)composePressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueDialogsToCompose" sender:self];
}

-(void) composeCompleted:(Message*)composedMsg{
    [self refreshPressed:self.navigationItem.rightBarButtonItem];
}

- (void)viewDidUnload {
    [self setBtnRefresh:nil];
    [super viewDidUnload];
}
@end
