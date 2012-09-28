//
//  SettingsValuesListTableVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/13/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SettingsValuesListTableVC.h"
#import "UserSettings.h"
#import "Utils.h"
#import "User.h"
#import "DataManager.h"

@interface SettingsValuesListTableVC (){
    NSArray* values;
    User* currentUser;
}

@end

@implementation SettingsValuesListTableVC

@synthesize valuesMode = _valuesMode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (self.valuesMode) {
        case 0: // time zones
            values = [NSTimeZone knownTimeZoneNames];
            break;
        case 1: // time formats
            values = [[NSArray alloc] initWithObjects:@"HH:mm", @"hh:mm", @"hh:mm a", nil];
            break;
        case 2: // date formats
            values = [[NSArray alloc] initWithObjects:@"YYYY-MM-dd E", @"YYYY.MM.dd", @"YYYY-MM-dd", @"MM.dd E", @"dd.MM.YYYY", @"E dd.MM.YYYY", @"E dd.MM", @"dd.MM", nil];
            break;
        case 3: // languages
            currentUser = [DataManager getCurrentUser];
            // languages are loaded directly to the table
            break;
        case 4: // app languages
            values = [[NSArray alloc] initWithObjects:@"2", @"10", nil];
            break;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.valuesMode == VALUES_MSG_LANGUAGES){
        return LANG_COUNT;
    }
    return values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    bool languageMode = self.valuesMode == VALUES_MSG_LANGUAGES || self.valuesMode == VALUES_APP_LANGUAGES;
    NSString* cellId = languageMode ? @"CellLanguage" : @"CellValue";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell){
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        switch (self.valuesMode) {
            case VALUES_TIME_FORMAT:{
                NSString* value = (NSString*)[values objectAtIndex:indexPath.row];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:value];
                cell.textLabel.text = [formatter stringFromDate:[NSDate date]];
                if ([[UserSettings getTimeFormat] isEqualToString:value]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                break;
            }
            case VALUES_DATE_FORMAT:{
                NSString* value = (NSString*)[values objectAtIndex:indexPath.row];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:value];
                cell.textLabel.text = [formatter stringFromDate:[NSDate date]];
                if ([[UserSettings getDateFormat] isEqualToString:value]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                break;
            }
            case VALUES_TIME_ZONE:{
                NSString* value = (NSString*)[values objectAtIndex:indexPath.row];
                if ([[UserSettings getTimeZone] isEqualToString:value]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                cell.textLabel.text = value;
                break;
            }
            case VALUES_MSG_LANGUAGES:{
                int row = indexPath.row;
                cell.textLabel.text = [Utils getLanguageName:row needSelfName:NO];
                cell.detailTextLabel.text = [Utils getLanguageName:row needSelfName:YES];
                for (NSNumber *num in currentUser.languages) {
                    if (num.intValue == row){
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        break;
                    }
                }
                break;
            }
            case VALUES_APP_LANGUAGES:{
                int lang = ((NSString*)[values objectAtIndex:indexPath.row]).intValue;
                cell.textLabel.text = [Utils getLanguageName:lang needSelfName:NO];
                cell.detailTextLabel.text = [Utils getLanguageName:lang needSelfName:YES];
                if ([UserSettings getAppLanguage] == lang){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* selectedValue = [values objectAtIndex:indexPath.row];
    
    switch (self.valuesMode) {
        case VALUES_TIME_FORMAT:
            [UserSettings setTimeFormat:selectedValue];
            break;
        case VALUES_TIME_ZONE:
            [UserSettings setTimeZone:selectedValue];
            break;
        case VALUES_DATE_FORMAT:
            [UserSettings setDateFormat:selectedValue];
            break;
        case VALUES_MSG_LANGUAGES:{
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            bool currentNo = cell.accessoryType == UITableViewCellAccessoryNone;
            [UserSettings setKnowlege:currentNo forLanguage:indexPath.row];
            cell.accessoryType = currentNo ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
        break;
        case VALUES_APP_LANGUAGES:{
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if( cell.accessoryType == UITableViewCellAccessoryNone){
                int lang = ((NSString*)[values objectAtIndex:indexPath.row]).intValue;
                [UserSettings setAppLanguage:lang];
                [self.tableView reloadData];
            }
        break;
        }
    }
    
    [self.tableView reloadData];
}

@end
