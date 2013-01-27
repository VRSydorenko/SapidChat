//
//  SettingsTableVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/13/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SettingsTableVC.h"
#import "UserSettings.h"
#import "SettingsValuesListTableVC.h"
#import "Utils.h"
#import "DataManager.h"
#import "Lang.h"
#import "LocalizationUtils.h"
#import "AmazonKeyChainWrapper.h"

@interface SettingsTableVC (){
    int valuesMode;
}

@end

@implementation SettingsTableVC
@synthesize labelTimeFormat;
@synthesize labelDateFormat;
@synthesize labelNickname;
@synthesize labelCnvLanguages;
@synthesize labelNewMsgLanguage;
@synthesize labelAppLanguage;
@synthesize loc_DateTime_TimeFormat;
@synthesize loc_DateTime_DateFormat;
@synthesize loc_Acc_Nickname;
@synthesize loc_Acc_Password;
@synthesize loc_Langs_Conversation;
@synthesize loc_Langs_Application;
@synthesize loc_Langs_NewMessages;

-(void) viewDidLoad{
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.tableView];
}

-(void) viewWillAppear:(BOOL)animated{
    [self updateLabelValues];
    [self updateLocalizableValues];
    
    [self.tableView reloadData];
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) updateLabelValues{
    User* user = [DataManager getCurrentUser];
    self.labelTimeFormat.text = [Utils timeToString:[NSDate date]];
    self.labelDateFormat.text = [Utils dateToString:[NSDate date]];
    self.labelNickname.text = user.nickname;

    NSMutableString* msgLangs = [[NSMutableString alloc] init];
    for (NSNumber* num in user.languages) {
        if (msgLangs.length > 0){
            [msgLangs appendString:@", "];
        }
        [msgLangs appendString:[Utils getLanguageName:num.intValue needSelfName:NO]];
    }
    
    [LocalizationUtils setText:msgLangs  forLabel:self.labelCnvLanguages];
    [LocalizationUtils setText:[Utils getLanguageName:[UserSettings getNewMessagesLanguage] needSelfName:NO] forLabel:self.labelNewMsgLanguage];
    [LocalizationUtils setText:[Utils getLanguageName:[UserSettings getAppLanguage] needSelfName:NO] forLabel:self.labelAppLanguage];
}

-(void) updateLocalizableValues{
    self.title = [Lang LOC_SETTINGS_WINDOWTITLE_SETTINGS];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT] forLabel:self.loc_DateTime_TimeFormat];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT] forLabel:self.loc_DateTime_DateFormat];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME] forLabel:self.loc_Acc_Nickname];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD] forLabel:self.loc_Acc_Password];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION] forLabel:self.loc_Langs_Conversation];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES] forLabel:self.loc_Langs_NewMessages];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION] forLabel:self.loc_Langs_Application];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_MORE_ABOUT] forLabel:self.labelMore_About];
    [LocalizationUtils setText:[Lang LOC_SETTINGS_SECTION_MORE_RATE] forLabel:self.labelMore_Rate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0: // time and data section
            switch (indexPath.row) {
                case 0:
                    valuesMode = VALUES_TIME_FORMAT;
                    break;
                case 1:
                    valuesMode = VALUES_DATE_FORMAT;
                    break;
            }
            [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
            break;
        case 1: // account section
            switch (indexPath.row) {
                case 0:{
                    NSString* captionNick = [Lang LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME];
                    NSString* currentNick = [DataManager getCurrentUser].nickname;
                    NSString* placeholder = [Lang LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE];
                    [self editSimpleTextSetting:captionNick currentText:currentNick placeholder:placeholder];
                    break;
                }
            }
            break;
        case 2: // languages section
            switch (indexPath.row) {
                case 0: // conversation language
                    valuesMode = VALUES_CNV_LANGUAGES;
                    break;
                case 1: // newly composed messages
                    valuesMode = VALUES_NEWMSG_LANGUAGES;
                    break;
                case 2: // application language
                    valuesMode = VALUES_APP_LANGUAGES;
                    break;
            }
            [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
            break;
        case 3: // additional section
            switch (indexPath.row) {
                case 0: // about screen
                    [self performSegueWithIdentifier:@"SegueSettingsToAbout" sender:self];
                    break;
                case 1:{ // rate the app
                    NSString* url = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=595828753&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8";
                    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
                    break;
                }
            }
            break;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return [Lang LOC_SETTINGS_SECTIONHEADER_DATEnTIME];
        case 1: return [Lang LOC_SETTINGS_SECTIONHEADER_ACCOUNT];
        case 2: return [Lang LOC_SETTINGS_SECTIONHEADER_LANGUAGES];
        case 3: return [Lang LOC_SETTINGS_SECTIONHEADER_MORE];
    }
    return [super tableView:tableView titleForHeaderInSection:section];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueSettingsToValuesList"]){
        SettingsValuesListTableVC* valuesListVC = (SettingsValuesListTableVC*)segue.destinationViewController;
        valuesListVC.valuesMode = valuesMode;
    }
}

- (void) editSimpleTextSetting:(NSString*)title currentText:(NSString*)currentValue placeholder:(NSString*)placeholder{
    NSString* btnOkText = [Lang LOC_UNI_OK];
    NSString* btnCancelText = [Lang LOC_UNI_CANCEL];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:self cancelButtonTitle:btnCancelText otherButtonTitles:btnOkText, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = placeholder;
    alertTextField.text = currentValue;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        return;
    }
    
    NSString* newNick = [[alertView textFieldAtIndex:0] text];
    // TODO: check nick for acceptable values
    if ([DataManager updateOwnNick:newNick] == OK){
        [DataManager updateOwnNickInDb:newNick];
        self.labelNickname.text = newNick;
    }
}

- (void)dealloc {
    [self setLabelTimeFormat:nil];
    [self setLabelDateFormat:nil];
    [self setLabelNickname:nil];
    [self setLabelCnvLanguages:nil];
    [self setLabelAppLanguage:nil];
    [self setLoc_DateTime_TimeFormat:nil];
    [self setLoc_DateTime_DateFormat:nil];
    [self setLoc_Acc_Nickname:nil];
    [self setLoc_Acc_Password:nil];
    [self setLoc_Langs_Conversation:nil];
    [self setLoc_Langs_Application:nil];
    [self setLoc_Langs_NewMessages:nil];
    [self setLabelNewMsgLanguage:nil];
    [super viewDidUnload];
}
- (void)viewDidUnload {
    [self setLabelMore_About:nil];
    [super viewDidUnload];
}
@end
