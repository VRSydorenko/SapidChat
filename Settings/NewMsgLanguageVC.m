//
//  NewMsgLanguageVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "NewMsgLanguageVC.h"
#import "DataManager.h"
#import "UserSettings.h"
#import "Utils.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "LangsIKnowVC.h"

@interface NewMsgLanguageVC (){
    NSArray* languages;
}

@end

@implementation NewMsgLanguageVC
@synthesize tableLanguages;
@synthesize handler;
@synthesize textNewMsgLangs;
@synthesize btnToLangsIKnow;

- (void)viewWillAppear:(BOOL)animated{
    languages = [[NSMutableArray alloc] initWithArray:[DataManager getCurrentUser].languages];
    [self.tableLanguages reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [LocalizationUtils setTitle:[Lang LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW] forButton:self.btnToLangsIKnow];
    self.textNewMsgLangs.text = [Lang LOC_SEPSETTINGS_NEWMSGLANG_TEXT_PICKLANGFROMKNOWN];
    self.tableLanguages.dataSource = self;
    self.tableLanguages.delegate = self;
}

- (void)viewDidUnload
{
    [self setTableLanguages:nil];
    [self setBtnToLangsIKnow:nil];
    [self setTextNewMsgLangs:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellLanguage"];
    if (cell){
        cell.accessoryType = UITableViewCellAccessoryNone;
        int lang = ((NSString*)[languages objectAtIndex:indexPath.row]).intValue;
        cell.textLabel.text = [Utils getLanguageName:lang needSelfName:NO];
        cell.detailTextLabel.text = [Utils getLanguageName:lang needSelfName:YES];
        if ([UserSettings getNewMessagesLanguage] == lang){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableLanguages cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        NSString* selectedValue = [languages objectAtIndex:indexPath.row];
        [UserSettings setNewMessagesLanguage:selectedValue.intValue];
    }
    [self.handler msgLangControllerToDismiss:self];
}

- (IBAction)toLangsIKnowPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueNewMsgLangsToLangsIKnow" sender:self];
    // HERE: next vc doesnt appear
}
@end
