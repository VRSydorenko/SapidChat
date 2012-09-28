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

@interface SettingsTableVC (){
    int valuesMode;
}

@end

@implementation SettingsTableVC
@synthesize switchSaveCreds;
@synthesize labelTimeZone;
@synthesize labelTimeFormat;
@synthesize labelDateFormat;
@synthesize labelNickname;
@synthesize labelMsgLanguages;
@synthesize labelAppLanguage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.switchSaveCreds.on = [UserSettings getSaveCredentials];
}

-(void) viewWillAppear:(BOOL)animated{
    [self updateLabelValues];
}

-(void) updateLabelValues{
    User* user = [DataManager getCurrentUser];
    self.labelTimeZone.text = [UserSettings getTimeZone];
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
    self.labelMsgLanguages.text = msgLangs;
    
    self.labelAppLanguage.text = [Utils getLanguageName:[UserSettings getAppLanguage] needSelfName:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0: // time and data section
            switch (indexPath.row) {
                case 0: // hardcoded!!!
                    valuesMode = VALUES_TIME_ZONE;
                    break;
                case 1:
                    valuesMode = VALUES_TIME_FORMAT;
                    break;
                case 2:
                    valuesMode = VALUES_DATE_FORMAT;
                    break;
            }
            [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
            break;
        case 2: // languages section
            switch (indexPath.row) {
                case 0: // messages language
                    valuesMode = VALUES_MSG_LANGUAGES;
                    break;
                case 1: // application language
                    valuesMode = VALUES_APP_LANGUAGES;
                    break;
            }
            [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
            break;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueSettingsToValuesList"]){
        SettingsValuesListTableVC* valuesListVC = (SettingsValuesListTableVC*)segue.destinationViewController;
        valuesListVC.valuesMode = valuesMode;
    }
}

- (IBAction)switchSaveCreds:(UISwitch *)sender {
    [UserSettings setSaveCredentials:sender.on];
}
- (void)viewDidUnload {
    [self setLabelTimeZone:nil];
    [self setLabelTimeFormat:nil];
    [self setLabelDateFormat:nil];
    [self setLabelNickname:nil];
    [self setLabelMsgLanguages:nil];
    [self setLabelAppLanguage:nil];
    [super viewDidUnload];
}
@end
