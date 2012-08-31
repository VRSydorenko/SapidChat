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

@interface DialogsVC (){
    MainNavController* navController;
    
    BOOL noEntries;
    Dialog *selectedDialog;
}

@end

@implementation DialogsVC
@synthesize tableDialogs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    navController = (MainNavController*)self.navigationController;
    self.tableDialogs.dataSource = self;
    self.tableDialogs.delegate = self;
    selectedDialog = nil;
    [self refreshPressed:self.navigationItem.rightBarButtonItem];
}

- (void)viewDidUnload
{
    [self setTableDialogs:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
        cell.textLabel.text = @"No records to display";
        noEntries = YES;
        return cell;
    }
    
    noEntries = NO;
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialogCell"];
    
    if (cell){
        Dialog *dialog = [navController.dialogs objectAtIndex:indexPath.row];
        NSString* stringCollocutor = dialog.collocutor ? dialog.collocutor : navController.me;
        cell.labelCollocutor.text = stringCollocutor;
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
}


- (IBAction)refreshPressed:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t refreshQueue = dispatch_queue_create("refresh Queue", NULL);
    dispatch_async(refreshQueue, ^{
        [DataManager getDialogs:navController.me];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = sender;
        });
    });
    dispatch_release(refreshQueue);
}
@end
