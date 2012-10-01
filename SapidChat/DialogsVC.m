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

@interface DialogsVC (){
    MainNavController* navController;
    
    BOOL noEntries;
    bool isPicking;
    Dialog *selectedDialog;
}

@end

@implementation DialogsVC
@synthesize btnPick;
@synthesize btnCompose;
@synthesize tableDialogs;
@synthesize spinnerPick;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [Lang LOC_MESSAGES_TITLE];
    self.btnPick.title = [Lang LOC_MESSAGES_BTN_PICKNEW];
    self.btnCompose.title = [Lang LOC_MESSAGES_BTN_COMPOSE];
    self.navigationItem.rightBarButtonItem.title = [Lang LOC_MESSAGES_BTN_REFRESH];
    
    isPicking = NO;
    navController = (MainNavController*)self.navigationController;
    self.tableDialogs.dataSource = self;
    self.tableDialogs.delegate = self;
    selectedDialog = nil;
    //[self refreshPressed:self.navigationItem.rightBarButtonItem];
}

- (void)viewDidUnload
{
    [self setTableDialogs:nil];
    [self setSpinnerPick:nil];
    [self setBtnPick:nil];
    [self setBtnCompose:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewDidAppear:(BOOL)animated{
    [self refreshPressed:self.navigationItem.rightBarButtonItem];// TODO: remove this extra update!!! load only saved messages
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
        noEntries = YES;
        return cell;
    }
    
    noEntries = NO;
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialogCell"];
    
    if (cell){
        Dialog *dialog = [navController.dialogs objectAtIndex:indexPath.row];
        NSString* stringCollocutor = dialog.collocutor ? dialog.collocutor : [UserSettings getEmail];
        cell.labelCollocutor.text = [stringCollocutor isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR] ? [Lang LOC_MESSAGES_CELL_WAIT_FOR_REPLY] : stringCollocutor;
        Message *msg = (Message*)[[dialog getSortedMessages] lastObject];
        cell.infoMessage.text = msg.text;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!noEntries){
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
    }
}


- (IBAction)refreshPressed:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t refreshQueue = dispatch_queue_create("refresh Queue", NULL);
    dispatch_async(refreshQueue, ^{
        navController.dialogs = [DataManager getDialogs];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableDialogs reloadData];
            self.navigationItem.rightBarButtonItem = sender;
        });
    });
    dispatch_release(refreshQueue);
}

- (IBAction)pickPressed:(id)sender {
    if (!isPicking){
        isPicking = YES;
        [self.spinnerPick startAnimating];
        
        dispatch_queue_t refreshQueue = dispatch_queue_create("pick Queue", NULL);
        dispatch_async(refreshQueue, ^{
            ErrorCodes pickResult = [DataManager pickNewMessage];
            if (pickResult == OK){
                navController.dialogs = [DataManager getDialogs];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (pickResult == OK){
                    [self.tableDialogs reloadData];
                }
                [self.spinnerPick stopAnimating];
                isPicking = NO;
            });
        });
        dispatch_release(refreshQueue);
    }
}

-(void) composeCompleted:(Message*)composedMsg{
    [self refreshPressed:self.navigationItem.rightBarButtonItem];
}
@end
