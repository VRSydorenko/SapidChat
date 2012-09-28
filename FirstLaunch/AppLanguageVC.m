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

@interface AppLanguageVC (){
    NSArray* appLangs;
}

@end

@implementation AppLanguageVC
@synthesize tableAppLanguages;
@synthesize btnNext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appLangs = [UserSettings getAppSupportedLanguages];
    [UserSettings setAppLanguage:2];// English by default
    self.tableAppLanguages.dataSource = self;
    self.tableAppLanguages.delegate = self;
    [self localize];
}

- (void)viewDidUnload
{
    [self setTableAppLanguages:nil];
    [self setBtnNext:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return appLangs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellAppLanguage"];
    if (cell){
        int lang = ((NSString*)[appLangs objectAtIndex:indexPath.row]).intValue;
        cell.textLabel.text = [Lang getAppLanguageStringForFirstLaunch:lang];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UserSettings setAppLanguage:((NSString*)[appLangs objectAtIndex:indexPath.row]).intValue];
    [self localize];
}

-(void)localize{
    [LocalizationUtils setTitle:[Lang LOC_FIRSTLAUNCH_BTN_NEXT] forButton:self.btnNext];
}

@end
