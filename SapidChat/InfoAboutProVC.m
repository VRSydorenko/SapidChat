//
//  InfoAboutProVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/10/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "InfoAboutProVC.h"
#import "AboutProFeatureCell.h"
#import "Lang.h"
#import "Utils.h"

@interface InfoAboutProVC (){
    UIFont *descrFont;
    CGSize boundingSize;
}

@end

@implementation InfoAboutProVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
    self.textTitle.text = [Lang LOC_BALANCE_WHAT_IN_PRO_TITLE];
    
    boundingSize = CGSizeMake(240.0f, CGFLOAT_MAX); // 260 is the width of UILabel
    descrFont = [UIFont fontWithName:@"Helvetica" size:13.0f];
    
    self.tabelFeatures.dataSource = self;
    self.tabelFeatures.delegate = self;
}

- (void)dealloc
{
    [self setTextTitle:nil];
    [self setTabelFeatures:nil];
    descrFont = nil;
    [super viewDidUnload];
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AboutProFeatureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProFeatureCell"];
    if (!cell){
        cell = [[AboutProFeatureCell alloc] init];
        cell.labelDescription.font = descrFont;
    }
    
    switch (indexPath.section) {
        case 0:{
            cell.labelTitle.text = [Lang LOC_INFO_FEATURE_TITLE_DISTANCE];
            [cell.labelTitle sizeToFit];
            cell.labelDescription.text = [Lang LOC_INFO_FEATURE_DESCR_DISTANCE];
            [cell.imageIcon setImage:[UIImage imageNamed:@"feature_distance.png"]];
            break;
        }
        case 1:{
            cell.labelTitle.text = [Lang LOC_INFO_FEATURE_TITLE_IMAGE];
            [cell.labelTitle sizeToFit];
            cell.labelDescription.text = [Lang LOC_INFO_FEATURE_DESCR_IMAGE];
            [cell.imageIcon setImage:[UIImage imageNamed:@"feature_images.png"]];
            break;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0){
        return [Lang LOC_INFO_FEATURE_NOTE_DISTANCE];
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:{
            height = [[Lang LOC_INFO_FEATURE_DESCR_DISTANCE] sizeWithFont:descrFont constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping].height + 110.0f; // 100 - height of title label + padding
            break;
        }
        case 1:{
            height = [[Lang LOC_INFO_FEATURE_DESCR_IMAGE] sizeWithFont:descrFont constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping].height + 110.0f; // 100 - height of title label + padding
            break;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (IBAction)closePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
