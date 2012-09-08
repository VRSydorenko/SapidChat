//
//  SettingsValuesListTableVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/13/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SettingsValuesListTableVC.h"
#import "UserSettings.h"

@interface SettingsValuesListTableVC (){
    NSArray* values;
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
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellValue"];
    if (cell){
        NSString* value = (NSString*)[values objectAtIndex:indexPath.row];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        switch (self.valuesMode) {
            case VALUES_TIME_FORMAT:{
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:value];
                cell.textLabel.text = [formatter stringFromDate:[NSDate date]];
                if ([[UserSettings getTimeFormat] isEqualToString:value]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                break;
            }
            case VALUES_DATE_FORMAT:{
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:value];
                cell.textLabel.text = [formatter stringFromDate:[NSDate date]];
                if ([[UserSettings getDateFormat] isEqualToString:value]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                break;
            }
            case VALUES_TIME_ZONE:{
                if ([[UserSettings getTimeZone] isEqualToString:value]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                cell.textLabel.text = value;
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
        case VALUES_TIME_ZONE:
            [UserSettings setTimeZone:selectedValue];
            break;
        case VALUES_DATE_FORMAT:
            [UserSettings setDateFormat:selectedValue];
            break;
    }
    
    [self.tableView reloadData];
}

@end
