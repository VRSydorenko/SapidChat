//
//  NewMsgLanguageVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangsIKnowVC.h"
#import "DataManager.h"
#import "UserSettings.h"
#import "Utils.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "DbModel.h"

@interface LangsIKnowVC (){
    NSMutableArray* languages;
}
@end

@implementation LangsIKnowVC

@synthesize textLangsIKnow;
@synthesize tableLanguages;
@synthesize btnBack;

- (void)viewWillAppear:(BOOL)animated{
    languages = [[NSMutableArray alloc] initWithArray:[DataManager getCurrentUser].languages];
    [self.tableLanguages reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textLangsIKnow.text = [Lang LOC_SEPSETTINGS_LANGSIKNOW_TEXT];
    [LocalizationUtils setTitle:[Lang LOC_SEPSETTINGS_LANGSIKNOW_BTN_BACK] forButton:self.btnBack];
    self.tableLanguages.dataSource = self;
    self.tableLanguages.delegate = self;
}

- (void)dealloc
{
    [self setTableLanguages:nil];
    [self setTextLangsIKnow:nil];
    [self setBtnBack:nil];
    languages = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return LANG_COUNT;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellLanguage"];
    if (cell){
        cell.accessoryType = UITableViewCellAccessoryNone;
        int row = indexPath.row;
        cell.textLabel.text = [Utils getLanguageName:row needSelfName:NO];
        cell.detailTextLabel.text = [Utils getLanguageName:row needSelfName:YES];
        for (NSNumber *num in languages) {
            if (num.intValue == row){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableLanguages cellForRowAtIndexPath:indexPath];
    if (cell){
        NSNumber *row = [NSNumber numberWithInt:indexPath.row];
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            [languages addObject:row];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else if (languages.count > 1){
            [languages removeObject:row];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [DataManager setMsgLanguagesForCurrentUser:languages];
    }
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
