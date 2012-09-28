//
//  UserRegistrationVC.m
//  SChat
//
//  Created by Viktor Sydorenko on 6/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "UserRegistrationVC.h"
#import "RegistrationNavController.h"
#import "DataManager.h"
#import "Utils.h"
#import "DbModel.h"
#import "AmazonKeyChainWrapper.h"

@interface UserRegistrationVC (){
    RegistrationNavController* navController;
    BOOL isRegistering;
    BOOL registered;
    User* user;
}

@end

@implementation UserRegistrationVC
@synthesize textEmail;
@synthesize textPassword;
@synthesize switchSaveCreds;
@synthesize textNick;
@synthesize labelServiseMessage;
@synthesize spinner;
@synthesize tableLanguages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    navController = (RegistrationNavController*)self.navigationController;
    if ([navController nowIsFinish]){
        user = [navController composeUser];
        [self registerAsync];
    } else {
        [self initControlsData];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelPressed:(id)sender {
    [navController cancel];
}

- (IBAction)nextPressed:(UIBarButtonItem *)sender {
    if ([navController nowIsInit]){
        if (textEmail.text.length == 0 || [Utils validateEmail:textEmail.text] != OK || [DataManager existsUserWithEmail:textEmail.text]){
            textEmail.textColor = [UIColor redColor];
            return;
        }
        if (textPassword.text.length < 5){
            textPassword.textColor = [UIColor redColor];
            return;
        }
    }
    if ([navController nowIsLanguages]){
        if (navController.selectedLanguages.count == 0){
            return;
        }
    }
    NSString* s = [navController getNextSegueId];
    if (!s){ // last segue reached. We are done.
        [navController.handler controllerToDismiss:navController whichRegisteredTheUser: registered ? user : nil];
    } else {
        [self saveControlsData];
        [self performSegueWithIdentifier:s sender:self];
    }
}

- (IBAction)textDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [navController increaseCurrentSegue];
}

-(void) viewWillDisappear:(BOOL)animated{
    if ([navController.viewControllers indexOfObject:self] == NSNotFound){ // back button
        [self saveControlsData];
        [navController decreaseCurrentSegue];
    }
}

- (void)viewDidUnload {
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setSwitchSaveCreds:nil];
    [self setTextNick:nil];
    [self setLabelServiseMessage:nil];
    [self setSpinner:nil];
    [self setTableLanguages:nil];
    [super viewDidUnload];
}

// private methods

-(void) initControlsData{
    if (self.textEmail && navController.email.length > 0){
        self.textEmail.text = navController.email;
    }
    if (self.textPassword && navController.password.length > 0){
        self.textPassword.text = navController.password;
    }
    if (self.switchSaveCreds){
        self.switchSaveCreds.on = navController.saveCreds;
    }
    if (self.textNick && navController.nickname){
        self.textNick.text = navController.nickname;
    }
    if (self.tableLanguages){
        self.tableLanguages.dataSource = self;
        self.tableLanguages.delegate = self;
        //[self.tableLanguages reloadData];
    }
}

-(void) saveControlsData{
    if (self.textEmail){
        navController.email = self.textEmail.text;
    }
    if (self.textPassword){
        navController.password = self.textPassword.text;
    }
    if (self.switchSaveCreds){
        navController.saveCreds = self.switchSaveCreds.on;
    }
    if (self.textNick){
        navController.nickname = self.textNick.text;
    }
    // languages are saved directly from the table
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return LANG_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableLanguages dequeueReusableCellWithIdentifier:@"LanguageCell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (cell){
        int row = indexPath.row;
        cell.textLabel.text = [Utils getLanguageName:row needSelfName:NO];
        cell.detailTextLabel.text = [Utils getLanguageName:row needSelfName:YES];
        if ([navController.selectedLanguages containsObject:[NSNumber numberWithInt:row]]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableLanguages cellForRowAtIndexPath:indexPath];
    NSNumber *row = [NSNumber numberWithInt:indexPath.row];
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        [navController.selectedLanguages addObject:row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [navController.selectedLanguages removeObject:row];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

-(void) registerAsync{
    isRegistering = YES;
    self.labelServiseMessage.text = @"";
    [self.spinner startAnimating];
    
    dispatch_queue_t regQueue = dispatch_queue_create("registration queue", NULL);
    dispatch_async(regQueue, ^{
        ErrorCodes errCode = [DataManager registerNewUser:user password:navController.password];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (errCode == OK){
                registered = YES;
                [AmazonKeyChainWrapper storeValueInKeyChain:navController.password forKey:user.email];
            } else {
                self.labelServiseMessage.text = [Utils getErrorDescription:registered];
            }
            [self.spinner stopAnimating];
            isRegistering = NO;
        });
    });
}



@end
