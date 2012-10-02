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
#import "Lang.h"
#import "LocalizationUtils.h"

@interface UserRegistrationVC (){
    RegistrationNavController* navController;
    BOOL isRegistering;
    BOOL registered;
    User* user;
    
    NSString* SEGUE_EMAIL_TO_NICK;
    NSString* SEGUE_NICK_TO_LANGS;
    NSString* SEGUE_LANGS_TO_FINISH;
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
@synthesize btnNext;
@synthesize btnRegister;
@synthesize btnClose;
@synthesize labelEmail;
@synthesize labelPassword;
@synthesize labelSaveCreds;
@synthesize labelNickname;
@synthesize labelSelectLangs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    navController = (RegistrationNavController*)self.navigationController;
    if (self.btnClose){ // last segue!
        user = [navController composeUser];
        [self registerAsync];
        self.navigationItem.hidesBackButton = YES;
        [self.navigationController setNavigationBarHidden:YES];
    } else {
        [self initControlsData];
    }
    [self setLocalizableValues];
    
    SEGUE_EMAIL_TO_NICK = @"SegueEmailToNick";
    SEGUE_NICK_TO_LANGS = @"SegueNickToLangs";
    SEGUE_LANGS_TO_FINISH = @"SegueLangsToFinish";
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"";
}
-(void) viewWillDisappear:(BOOL)animated{
    self.navigationItem.title = [Lang LOC_REGISTATOR_BTN_BACK];
    if ([navController.viewControllers indexOfObject:self] == NSNotFound){ // back button
        [self saveControlsData];
    }
}

-(void) setLocalizableValues{
    if (!self.btnClose){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[Lang LOC_REGISTATOR_BTN_CANCEL] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPressed:)];
    }

    if (self.btnNext){
        [LocalizationUtils setTitle:[Lang LOC_REGISTATOR_BTN_NEXT] forButton:self.btnNext];
    }
    if (self.btnClose){
        self.btnClose.title = [Lang LOC_REGISTATOR_BTN_CLOSE];
    }
    if (self.btnRegister){
        self.btnRegister.title = [Lang LOC_REGISTATOR_BTN_REGISTER];
    }
    if (self.labelEmail){
        [LocalizationUtils setText:[Lang LOC_REGISTATOR_FIELD_EMAIL] forLabel:self.labelEmail];
    }
    if (self.labelPassword){
        [LocalizationUtils setText:[Lang LOC_REGISTATOR_FIELD_PASSWORD] forLabel:self.labelPassword];
    }
    if (self.labelSaveCreds){
        [LocalizationUtils setText:[Lang LOC_REGISTATOR_SWITCH_SAVECREDS] forLabel:self.labelSaveCreds];
    }
    if (self.labelNickname){
        [LocalizationUtils setText:[Lang LOC_REGISTATOR_FIELD_NICK] forLabel:self.labelNickname];
    }
    if (self.labelSelectLangs){
        [LocalizationUtils setText:[Lang LOC_REGISTATOR_LABEL_SELECT_LANGS] forLabel:self.labelSelectLangs];
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
    NSString *nextSegueId = nil;
    if (self.textEmail){ // not is initial screen
        nextSegueId = SEGUE_EMAIL_TO_NICK;
        if (self.textEmail.text.length == 0 || [Utils validateEmail:self.textEmail.text] != OK || [DataManager existsUserWithEmail:self.textEmail.text]){
            self.textEmail.textColor = [UIColor redColor];
            return;
        }
        if (self.textPassword.text.length < 5){
            self.textPassword.textColor = [UIColor redColor];
            return;
        }
    }
    if (self.textNick){
        nextSegueId = SEGUE_NICK_TO_LANGS;
    }
    if (self.tableLanguages){ // now is languages screen
        nextSegueId = SEGUE_LANGS_TO_FINISH;
        if (navController.selectedLanguages.count == 0){
            return;
        }
    }
    
    if (self.btnClose){ // last segue reached. We are done.
        [navController.handler controllerToDismiss:navController whichRegisteredTheUser: registered ? user : nil];
    } else {
        [self saveControlsData];
        [self performSegueWithIdentifier:nextSegueId sender:self];
    }
}

- (IBAction)textDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidUnload {
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setSwitchSaveCreds:nil];
    [self setTextNick:nil];
    [self setLabelServiseMessage:nil];
    [self setSpinner:nil];
    [self setTableLanguages:nil];
    [self setBtnNext:nil];
    [self setBtnRegister:nil];
    [self setBtnClose:nil];
    [self setLabelEmail:nil];
    [self setLabelPassword:nil];
    [self setLabelSaveCreds:nil];
    [self setLabelNickname:nil];
    [self setLabelSelectLangs:nil];
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