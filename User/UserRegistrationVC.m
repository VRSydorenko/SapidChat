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
#import "UserSettings.h"
#import "SapidInfoBarManager.h"
#import "InfoVC.h"

@interface UserRegistrationVC (){
    RegistrationNavController* navController;
    BOOL isRegistering;
    BOOL registered;
    BOOL emailChecked;
    User* user;
    
    NSString* SEGUE_EMAIL_TO_NICK;
    NSString* SEGUE_NICK_TO_LANGS;
    NSString* SEGUE_LANGS_TO_FINISH;
}

@end

@implementation UserRegistrationVC
@synthesize textEmail;
@synthesize textPassword;
@synthesize textNick;
@synthesize txtSpecifyNick;
@synthesize spinner;
@synthesize tableLanguages;
@synthesize btnNext;
@synthesize btnRegister;
@synthesize btnClose;
@synthesize txtSelectLangs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navController = (RegistrationNavController*)self.navigationController;
    
    self.title = [Lang LOC_REGISTATOR_TITLE];
    
    if (!self.textEmail && !self.btnClose){ // if neither the first nor the last segue then no back button
        self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    }
    
    if (self.btnClose){ // last segue!
        self.navigationItem.hidesBackButton = YES;
        user = [navController composeUser];
        [self registerAsync];
    } else {
        [self initControlsData];
    }
    [self setLocalizableValues];
    
    SEGUE_EMAIL_TO_NICK = @"SegueEmailToNick";
    SEGUE_NICK_TO_LANGS = @"SegueNickToLangs";
    SEGUE_LANGS_TO_FINISH = @"SegueLangsToFinish";
}

-(void) viewWillDisappear:(BOOL)animated{
    if ([navController.viewControllers indexOfObject:self] == NSNotFound){ // back button
        [self saveControlsData];
    }
}

-(void) setLocalizableValues{
    if (self.btnNext){
        [LocalizationUtils setTitle:[Lang LOC_REGISTATOR_BTN_NEXT] forButton:self.btnNext];
        [Utils fitButtonInHorizontalCenter:self.btnNext];
    }
    if (self.btnClose){
        [LocalizationUtils setTitle:[Lang LOC_REGISTATOR_BTN_CLOSE] forButton:self.btnClose];
        [Utils fitButtonInHorizontalCenter:self.btnClose];
    }
    if (self.btnRegister){
        [LocalizationUtils setTitle:[Lang LOC_REGISTATOR_BTN_REGISTER] forButton:self.btnRegister];
        [Utils fitButtonInHorizontalCenter:self.btnRegister];
    }
    if (self.textEmail){
        self.textEmail.placeholder = [Lang LOC_UNI_EMAIL];
    }
    if (self.textPassword){
        self.textPassword.placeholder = [Lang LOC_REGISTATOR_FIELD_PASSWORD];
    }
    if (self.txtSpecifyNick){
        self.txtSpecifyNick.text = [Lang LOC_REGISTATOR_TEXT_SPECIFYNICK];
    }
    if (self.textNick){
        self.textNick.placeholder = [Lang LOC_REGISTATOR_FIELD_NICK];
    }
    if (self.txtSelectLangs){
        self.txtSelectLangs.text = [Lang LOC_REGISTATOR_LABEL_SELECT_LANGS];
    }
}

- (IBAction)cancelPressed:(id)sender {
    [navController cancel];
}

-(void) backPressed{
    [navController popViewControllerAnimated:YES];
}

- (IBAction)nextPressed:(UIBarButtonItem *)sender {
    NSString *nextSegueId = nil;
    if (self.textEmail){ // now is initial screen
        nextSegueId = SEGUE_EMAIL_TO_NICK;
        self.textEmail.text = [Utils trimWhitespaces:self.textEmail.text];
        if (self.textEmail.text.length == 0){
            [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:EMAIL_NOT_SPECIFIED]];
            return;
        }
        if ([Utils validateEmail:self.textEmail.text] != OK || [self.textEmail.text isEqualToString:SYSTEM_USER] || [self.textEmail.text isEqualToString:@"intrigue@sapidchat.com"]){
            [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:INVALID_EMAIL]];
            return;
        }
        if (self.textPassword.text.length  == 0){
            [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:PASSWORD_NOT_SPECIFIED]];
            return;
        }
        if (self.textPassword.text.length < MINIMUM_PASSWORD_LENGTH){
            [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:PASSWORD_TOO_SHORT]];
            return;
        }
        if (!emailChecked && [DataManager existsUserWithEmail:self.textEmail.text]){
            [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:USER_EXISTS]];
            emailChecked = NO;
            return;
        }
        emailChecked = YES;
    }
    if (self.textNick){
        self.textNick.text = [Utils trimWhitespaces:self.textNick.text];
        if (self.textNick.text.length == 0){
            [navController showInfoBarWithNegativeMessage:[Lang LOC_REGISTATOR_ERR_EMPTYNICK]];
            return;
        } else if (![Utils isNicknameValid:self.textNick.text]){
            [navController showInfoBarWithNegativeMessage:[Lang LOC_REGISTATOR_ERR_INVALIDNICK]];
            return;
        }
        nextSegueId = SEGUE_NICK_TO_LANGS;
    }
    if (self.tableLanguages){ // now is languages screen
        nextSegueId = SEGUE_LANGS_TO_FINISH;
        if (navController.selectedLanguages.count == 0){
            [navController showInfoBarWithNegativeMessage:[Lang LOC_REGISTATOR_ERR_NOLANGS_SELECTED]];
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

- (IBAction)editingChanged:(id)sender {
    emailChecked = NO;
}

- (void)dealloc {
    [self setTextEmail:nil];
    [self setTextPassword:nil];
    [self setTextNick:nil];
    [self setSpinner:nil];
    [self setTableLanguages:nil];
    [self setBtnNext:nil];
    [self setBtnRegister:nil];
    [self setBtnClose:nil];
    [self setTxtSelectLangs:nil];
    [self setTxtSpecifyNick:nil];
    navController = nil;
    user = nil;
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
        cell.imageView.image = [Utils getFlagForLanguage:row];
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
    [self.spinner startAnimating];
    
    dispatch_queue_t regQueue = dispatch_queue_create("registration queue", NULL);
    dispatch_async(regQueue, ^{
        ErrorCodes errCode = [DataManager registerNewUser:user password:navController.password];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (errCode == OK){
                registered = YES;
                [AmazonKeyChainWrapper storeValueInKeyChain:navController.password forKey:user.email];
                [navController showInfoBarWithPositiveMessage:[Lang LOC_REGISTATOR_SUCCESS]];
            } else {
                [navController showInfoBarWithNegativeMessage:[Utils getErrorDescription:errCode]];
            }
            [self.spinner stopAnimating];
            isRegistering = NO;
            self.btnClose.hidden = NO;
            self.imgDone.hidden = NO;
        });
    });
    dispatch_release(regQueue);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueEmailToInfo"]){
        InfoVC* infoVC = (InfoVC*)segue.destinationViewController;
        infoVC.infoString = [Lang LOC_REGISTATOR_WHY_EMAIL];
        infoVC.title = [Lang LOC_UNI_EMAIL];
    }
}

@end
