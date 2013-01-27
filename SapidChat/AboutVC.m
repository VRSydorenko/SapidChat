//
//  AboutVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/9/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "AboutVC.h"
#import "Lang.h"
#import "Utils.h"

@interface AboutVC (){
    UIFont* personFont;
}

@end

@implementation AboutVC
@synthesize tableAbout;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
    self.title = [Lang LOC_SETTINGS_SECTION_MORE_ABOUT];
    personFont = [UIFont fontWithName:@"Helvetica" size:14.0f];
    self.tableAbout.dataSource = self;
    self.tableAbout.delegate = self;
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5; // main cell, idea, graphics, localization
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){return 0;}
    return section == 3 ? 3 : 1; // 3 rows only for localization section
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SomeCell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SomeCell"];
        cell.textLabel.font = personFont;
        cell.detailTextLabel.font = personFont;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.section) {
        case 0:
            // nothing to do here
            break;
        case 1:
            cell.textLabel.text = [Lang LOC_ABOUT_VIKTOR_SYDORENKO];
            break;
        case 2:
            cell.textLabel.text = [Lang LOC_ABOUT_DESIGNER];
            break;
        case 3:{
            NSString* person;
            NSString* lang;
            switch (indexPath.row) {
                case 0:{
                    person = [Lang LOC_ABOUT_VIKTOR_SYDORENKO];
                    lang = [Utils getLanguageName:RUSSIAN needSelfName:NO];
                    break;
                }
                case 1:{
                    person = @"Peter Burkimsher";
                    lang = [Utils getLanguageName:ENGLISH needSelfName:NO];
                    break;
                }
                case 2:{
                    person = @"Tamas Vajda";
                    lang = [Utils getLanguageName:HUNGARIAN needSelfName:NO];
                    break;
                }
            }
            cell.textLabel.text = person;
            cell.detailTextLabel.text = lang;
            break;
        }
        case 4:{
            cell.textLabel.text = @"Double-J Design";
            cell.detailTextLabel.text = [Lang LOC_ABOUT_ICONS];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){ return 0; }
    return 30;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return [Lang LOC_ABOUT_IDEA_AND_DEVELOPMENT];
        case 2:
            return [Lang LOC_ABOUT_DESIGN];
        case 3:
            return [Lang LOC_ABOUT_LOCALIZATION];
        case 4:
            return [Lang LOC_ABOUT_ALSO];
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4 && indexPath.row == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.doublejdesign.co.uk"]];
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return [tableView dequeueReusableCellWithIdentifier:@"AboutAppMainCell"];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 124.0;
    }
    return 30;
}

- (void)dealloc
{
    [self setTableAbout:nil];
    personFont = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
