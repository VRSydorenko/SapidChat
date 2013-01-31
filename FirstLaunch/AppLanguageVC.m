//
//  AppLanguageVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "AppLanguageVC.h"
#import "UserSettings.h"
#import "Lang.h"
#import "FirstLaunchNavController.h"
#import "ViewController.h"
#import "LocalizationUtils.h"
#import "DbModel.h"
#import "Utils.h"
#import "LanguageCell.h"

@interface AppLanguageVC (){
    NSArray* appLangs;
}

@end

@implementation AppLanguageVC
@synthesize tableAppLanguages;
@synthesize btnNext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appLangs = [UserSettings getAppSupportedLanguages];
    self.btnNext.hidden = YES;
    self.tableAppLanguages.dataSource = self;
    self.tableAppLanguages.delegate = self;
    
    self.fakeNavBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barGreenBackground.png"]];
    self.labelTitle.font = [UIFont fontWithName:APPLICATION_NAME_FONT size:20.0];
}

- (void)dealloc
{
    [self setTableAppLanguages:nil];
    [self setBtnNext:nil];
    appLangs = nil;
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return appLangs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LanguageCell* cell = (LanguageCell*)[tableView dequeueReusableCellWithIdentifier:@"CellAppLanguage"];
    if (!cell){
        cell = [[LanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellAppLanguage"];
    }
    
    int lang = ((NSNumber*)[appLangs objectAtIndex:indexPath.row]).intValue;
    cell.labelLanguage.text = [Utils getLanguageName:lang needSelfName:YES];
    cell.imageFlag.image = [Utils getFlagForLanguage:lang];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UserSettings setAppLanguage:((NSNumber*)[appLangs objectAtIndex:indexPath.row]).intValue];
    [self localize];
    self.btnNext.hidden = NO;
}

-(void)localize{
    [LocalizationUtils setTitle:[Lang LOC_FIRSTLAUNCH_BTN_NEXT] forButton:self.btnNext];
    [Utils fitButtonInHorizontalCenter:self.btnNext];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueFirstLaunchToIntro"]){
        IntroVC* introVC = (IntroVC*)segue.destinationViewController;
        introVC.delegate = (FirstLaunchNavController*)self.navigationController;
    }
}

- (void)viewDidUnload {
    [self setFakeNavBar:nil];
    [self setLabelTitle:nil];
    [super viewDidUnload];
}
@end
