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

@interface InfoAboutProVC (){
    UIFont *descrFont;
    CGSize boundingSize;
}

@end

@implementation InfoAboutProVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    boundingSize = CGSizeMake(240.0f, CGFLOAT_MAX); // 260 is the width of UILabel
    descrFont = [UIFont fontWithName:@"Helvetica" size:13.0f];
    
    self.tabelFeatures.dataSource = self;
    self.tabelFeatures.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AboutProFeatureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProFeatureCell"];
    if (!cell){
        cell = [[AboutProFeatureCell alloc] init];
        cell.labelDescription.font = descrFont;
    }
    
    switch (indexPath.row) {
        case 0:{
            cell.labelTitle.text = [Lang LOC_INFO_FEATURE_TITLE_DISTANCE];
            [cell.labelTitle sizeToFit];
            cell.labelDescription.text = [Lang LOC_INFO_FEATURE_DESCR_DISTANCE];
            [cell.imageIcon setImage:[UIImage imageNamed:@"feature_distance.png"]];
            break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:{
            height = [[Lang LOC_INFO_FEATURE_DESCR_DISTANCE] sizeWithFont:descrFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap].height + 110.0f; // 100 - height of title label + padding
            break;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

@end
