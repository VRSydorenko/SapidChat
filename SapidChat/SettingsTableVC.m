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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.switchSaveCreds.on = [UserSettings getSaveCredentials];
}

-(void) viewWillAppear:(BOOL)animated{
    [self updateLabelValues];
}

-(void) updateLabelValues{
    self.labelTimeZone.text = [UserSettings getTimeZone];
    self.labelTimeFormat.text = [Utils timeToString:[NSDate date]];
    self.labelDateFormat.text = [Utils dateToString:[NSDate date]];
    
    self.labelNickname.text = [UserSettings getNickname];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: // hardcoded!!!
                    valuesMode = VALUES_TIME_ZONE;
                    [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
                    break;
                case 1:
                    valuesMode = 1;//VALUES_TIME_FORMAT;
                    [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
                    break;
                case 2:
                    valuesMode = VALUES_DATE_FORMAT;
                    [self performSegueWithIdentifier:@"SegueSettingsToValuesList" sender:self];
                    break;
            }
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
    [super viewDidUnload];
}
@end
