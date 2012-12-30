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
#import "Lang.h"

@interface SettingsValuesListTableVC (){
    NSArray* values;
    NSMutableArray* msgLanguages;
}

@end

@implementation SettingsValuesListTableVC

@synthesize valuesMode = _valuesMode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (self.valuesMode) {
        case VALUES_TIME_FORMAT:
            values = [[NSArray alloc] initWithObjects:@"HH:mm", @"hh:mm", @"hh:mm a", nil];
            break;
        case VALUES_DATE_FORMAT:
            values = [[NSArray alloc] initWithObjects:@"YYYY-MM-dd E", @"YYYY.MM.dd", @"YYYY-MM-dd", @"MM.dd E", @"dd.MM.YYYY", @"E dd.MM.YYYY", @"E dd.MM", @"dd.MM", nil];
            break;
        case VALUES_CNV_LANGUAGES: {
            msgLanguages = [[NSMutableArray alloc] initWithArray:[DataManager getCurrentUser].languages];
            // languages are loaded directly to the table
            self.title = [Lang LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION];
            break;
        }
        case VALUES_APP_LANGUAGES:{
            values = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d", RUSSIAN],
                                                      [NSString stringWithFormat:@"%d", ENGLISH], nil];
            self.title = [Lang LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION];
            break;
        }
        case VALUES_NEWMSG_LANGUAGES:{
            values = [[NSMutableArray alloc] initWithArray:[DataManager getCurrentUser].languages];
            self.title = [Lang LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES];
            break;
        }
    }
}

-(void) viewDidUnload{
    values = nil;
    msgLanguages = nil;
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.valuesMode == VALUES_CNV_LANGUAGES){
        return LANG_COUNT;
    }
    return values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    bool languageMode = self.valuesMode == VALUES_CNV_LANGUAGES || self.valuesMode == VALUES_APP_LANGUAGES || self.valuesMode == VALUES_NEWMSG_LANGUAGES;
    NSString* cellId = languageMode ? @"CellLanguage" : @"CellValue";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            case VALUES_CNV_LANGUAGES:{
                int row = indexPath.row;
                cell.textLabel.text = [Utils getLanguageName:row needSelfName:NO];
                cell.detailTextLabel.text = [Utils getLanguageName:row needSelfName:YES];
                for (NSNumber *num in msgLanguages) {
                    if (num.intValue == row){
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        break;
                    }
                }
                break;
            }
            case VALUES_NEWMSG_LANGUAGES:{
                int lang = ((NSString*)[values objectAtIndex:indexPath.row]).intValue;
                cell.textLabel.text = [Utils getLanguageName:lang needSelfName:NO];
                cell.detailTextLabel.text = [Utils getLanguageName:lang needSelfName:YES];
                if ([UserSettings getNewMessagesLanguage] == lang){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
                break;
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
        case VALUES_DATE_FORMAT:
            [UserSettings setDateFormat:selectedValue];
            break;
        case VALUES_CNV_LANGUAGES:{
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
             NSNumber *row = [NSNumber numberWithInt:indexPath.row];
            if (cell.accessoryType == UITableViewCellAccessoryNone){
                [msgLanguages addObject:row];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else if (msgLanguages.count > 1){
                [msgLanguages removeObject:row];
                [DataManager setNewMessageLanguageFromUserLanguages:msgLanguages];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            [DataManager setMsgLanguagesForCurrentUser:msgLanguages];
            break;
        }
        case VALUES_NEWMSG_LANGUAGES:{
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if(cell.accessoryType == UITableViewCellAccessoryNone){
                [UserSettings setNewMessagesLanguage:selectedValue.intValue];
                [self.tableView reloadData];
            }
            break;
        }
        case VALUES_APP_LANGUAGES:{
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if(cell.accessoryType == UITableViewCellAccessoryNone){
                [UserSettings setAppLanguage:selectedValue.intValue];
                self.title = [Lang LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION];
                
                [self.tableView reloadData];
            }
            break;
        }
    }
    
    [self.tableView reloadData];
}

@end
