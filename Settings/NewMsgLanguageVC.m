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
#import "NewMsgLanguagesNavCon.h"

@interface NewMsgLanguageVC (){
    NSArray* languages;
}

@end

@implementation NewMsgLanguageVC
@synthesize tableLanguages;
@synthesize btnToLangsIKnow;

- (void)viewWillAppear:(BOOL)animated{
    languages = [[NSMutableArray alloc] initWithArray:[DataManager getCurrentUser].languages];
    
    [self updateNewMessagesLanguageSelection];
    
    [self.tableLanguages reloadData];
}

-(void) updateNewMessagesLanguageSelection{
    bool langIsSet = NO;
    for (int i = 0; i < languages.count; i++) {
        if ([UserSettings getNewMessagesLanguage] == [[languages objectAtIndex:i] intValue]){
            [UserSettings setNewMessagesLanguage:[[languages objectAtIndex:i] intValue]];
            langIsSet = YES;
            break;
        }
    }
    if (!langIsSet){
        [UserSettings setNewMessagesLanguage:[[languages objectAtIndex:0] intValue]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [Lang LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES];
    
    [LocalizationUtils setTitle:[Lang LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW] forButton:self.btnToLangsIKnow];
    [self.btnToLangsIKnow sizeToFit];
    CGRect frame = self.btnToLangsIKnow.frame;
    frame.origin.x = 320/*display width*/ - 20/*padding*/ - self.btnToLangsIKnow.bounds.size.width;
    self.btnToLangsIKnow.frame = frame;
    
    self.tableLanguages.dataSource = self;
    self.tableLanguages.delegate = self;
}

- (void)dealloc
{
    [self setTableLanguages:nil];
    [self setBtnToLangsIKnow:nil];
    languages = nil;
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
    [(NewMsgLanguagesNavCon*)self.navigationController closeUsingHandler];
}

- (IBAction)toLangsIKnowPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueNewMsgLangsToLangsIKnow" sender:self];
}

- (IBAction)closePressed:(id)sender {
    [(NewMsgLanguagesNavCon*)self.navigationController closeUsingHandler];
}
@end
