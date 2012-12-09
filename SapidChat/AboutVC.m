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
	
    self.title = [Lang LOC_ABOUT_SCREEN_TITLE];
    personFont = [UIFont fontWithName:@"Helvetica" size:14.0f];
    self.tableAbout.dataSource = self;
    self.tableAbout.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4; // main cell, idea, graphics, localization
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 3 ? 3 : 1; // 3 rows only for localization section
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"AboutAppMainCell"];
    }
    
    UITableViewCell *cell;
    if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"LocalizationCell"];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LocalizationCell"];
            cell.textLabel.font = personFont;
            cell.detailTextLabel.font = personFont;
        }
        NSString* person;
        NSString* lang;
        switch (indexPath.row) {
            case 0:{
                person = [Lang LOC_ABOUT_VIKTOR_SYDORENKO];
                lang = [Utils getLanguageName:RUSSIAN needSelfName:NO];
                break;
            }
            case 1:{
                person = @"Benjamin Sell";
                lang = [Utils getLanguageName:ENGLISH needSelfName:NO];
                break;
            }
            case 2:{
                person = @"Alice Harather";
                lang = [Utils getLanguageName:GERMAN needSelfName:NO];
                break;
            }
        }
        cell.textLabel.text = person;
        cell.detailTextLabel.text = lang;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SimpleCell"];
            cell.textLabel.font = personFont;
        }
        cell.textLabel.text = indexPath.section == 1 ? [Lang LOC_ABOUT_VIKTOR_SYDORENKO] : [Lang LOC_ABOUT_DASHA_DESIGNER];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 124.0f;
    }
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
    }
    return @"";
}

- (void)viewDidUnload
{
    [self setTableAbout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
