//
//  NewMsgLanguageVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "AllLangsVC.h"
#import "DataManager.h"
#import "UserSettings.h"
#import "Utils.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "DbModel.h"

@interface AllLangsVC (){
    NSMutableArray* languages;
}
@end

@implementation AllLangsVC

@synthesize tableLanguages;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fakeNavBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barGreenBackground.png"]];
    
    self.labelTitle.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.labelTitle.shadowOffset = CGSizeMake(0, -1.0);
    self.labelTitle.text = [Lang LOC_SETTINGS_SECTIONHEADER_LANGUAGES];
       
    self.tableLanguages.dataSource = self;
    self.tableLanguages.delegate = self;
}

- (void)dealloc
{
    [self setTableLanguages:nil];
    languages = nil;
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
        cell.imageView.image = [Utils getFlagForLanguage:row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableLanguages cellForRowAtIndexPath:indexPath];
    if (cell){
        NSNumber *row = [NSNumber numberWithInt:indexPath.row];
        [self.handler languagePicked:row inController:self];
    }
}

- (void)viewDidUnload {
    [self setLabelTitle:nil];
    [self setBtnClose:nil];
    [self setFakeNavBar:nil];
    [super viewDidUnload];
}
- (IBAction)closePressed:(id)sender {
    [self.handler languagePicked:nil inController:self];
}
@end
