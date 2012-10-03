//
//  MainVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "MainVC.h"
#import "MainCell.h"
#import "DataManager.h"
#import "UserSettings.h"
#import "MainNavController.h"
#import "Lang.h"
#import "LocalizationUtils.h"

@interface MainVC ()
@end

@implementation MainVC
@synthesize btnLogout;
@synthesize tableMain;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:[UserSettings getTimeZone]]];
    [DataManager getDialogs];
    self.tableMain.dataSource = self;
    self.tableMain.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.title = [Lang LOC_UNI_APP_NAME];
    self.navigationItem.rightBarButtonItem.title = [Lang LOC_MAIN_BUTTON_REFRESH];
    self.btnLogout.title = [Lang LOC_MAIN_BUTTON_LOGOUT];
    [self.tableMain reloadData];
}

- (void)viewDidUnload
{
    [self setTableMain:nil];
    [self setBtnLogout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId;
    switch (indexPath.row) {
        case 0:
            reuseId = @"MainCellMessages";
            break;
        case 1:
            reuseId = @"MainCellIntrigue";
            break;
        case 2:
            reuseId = @"MainCellSettings";
            break;
    }
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (cell){
        switch (indexPath.row) {
            case 0:{
                cell.labelTitle.text = [Lang LOC_MAIN_CELL_MESSAGES];
                int unreadMsgs = [DataManager getUnreadMessagesCount];
                NSString* infoMessage = unreadMsgs == 0 ? [Lang LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES] : [NSString stringWithFormat:[Lang LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES], unreadMsgs];
                cell.labelMessagesInfoMessage.text = infoMessage;
                break;
            }
            case 1:
                cell.labelTitle.text = [Lang LOC_MAIN_CELL_INTRIGUE];
                break;
            case 2:
                cell.labelTitle.text = [Lang LOC_MAIN_CELL_SETTINGS];
                break;

        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"SegueMainToDialogs" sender:self];
            break;
        case 1:{
            NSString* intrigueSegue = [UserSettings intrigueUnlocked] ? @"SegueMainToIntrigue" : @"SegueMainToSellIntrigue";
            [self performSegueWithIdentifier:intrigueSegue sender:self];
            break;
        }
        case 2:
            [self performSegueWithIdentifier:@"SegueMainToSettings" sender:self];
            break;
    }
}

- (IBAction)refreshPressed:(UIBarButtonItem *)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t refreshQueue = dispatch_queue_create("refresh Queue", NULL);
    dispatch_async(refreshQueue, ^{
        ((MainNavController*)self.navigationController).dialogs = [DataManager getDialogs];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableMain reloadData];
            self.navigationItem.rightBarButtonItem = sender;
        });
    });
    dispatch_release(refreshQueue);
}

- (IBAction)logoutPressed:(id)sender {
    [((MainNavController*)self.navigationController).logoutHandler controllerToLogout:self.navigationController];
}

@end
