//
//  BalanceVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "BalanceVC.h"
#import "UserSettings.h"
#import "CurrentProModeCell.h"
#import "LocalizationUtils.h"
#import "Lang.h"
#import "ReadAboutProCell.h"
#import "MakeItProCell.h"
#import "CurrentBalanceCell.h"
#import "DataManager.h"
#import "BuyOptionCell.h"

@interface BalanceVC ()

@end

@implementation BalanceVC
@synthesize tableContent;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = [Lang LOC_BALANCE_SCREEN_TITLE];
    self.tableContent.dataSource = self;
    self.tableContent.delegate = self;
}

- (void)viewDidUnload{
    [self setTableContent:nil];
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0: // Pro or not Pro
            return [UserSettings premiumUnlocked] ? 2 : 3; // state and info [plus buy button]
        case 1: // Balance state
            return 1;
        case 2: // purchases
            return 3; // 1 header and 3 options
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3; // current mode, balance state, purchases
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    CurrentProModeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellProOrNotPro"];
                    cell.textCurrentProMode.text = [self getCurrentProModeCellText];
                    return  cell;
                }
                case 1:{
                    ReadAboutProCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReadMoreAboutPro"];
                    cell.labelReadAboutPro.text = [Lang LOC_BALANCE_WHAT_IN_PRO];
                    return cell;
                }
                case 2:{
                    MakeItProCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellMakeItPro"];
                    [cell.segmentedControl setTitle:[Lang LOC_BALANCE_BTN_MAKEPRO] forSegmentAtIndex:0];
                    [cell.segmentedControl setTitle:[Lang LOC_BALANCE_BTN_RESTORE] forSegmentAtIndex:1];
                    return cell;
                }
            }
            break;
        case 1:
        {
            CurrentBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCurrentBalance"];
            int poststamps = [DataManager getTotalAvailablePoststamps];
            NSString* text = [self getQuantifierStringForAmount:poststamps];
            cell.labelCurrentBalance.text = [NSString stringWithFormat:@"%d %@", poststamps, text];
            return cell;
        }
        case 2:
        {
            BuyOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellBuyOption"];
            int amountToBuy = indexPath.row == 0 ? 10 : indexPath.row == 1 ? 30 : 50;
            cell.labelQuantity.text = [NSString stringWithFormat:@"%d %@", amountToBuy, [self getQuantifierStringForAmount:amountToBuy]];
            cell.labelPercentageOff.text = indexPath.row == 0 ? @"" : indexPath.row == 1 ? @"[-30%]" : @"[-40%]";
            cell.labelPrice.text = indexPath.row == 0 ? @"$0.99" : indexPath.row == 1 ? @"$1.99" : @"$2.99";
            return cell;
        }
    }

    return [[UITableViewCell alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return nil;
    }
    
   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor brownColor];//colorWithRed:145 green:10 blue:65 alpha:100];
    
    int leftMargin = 10;
     int height = 20;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, 0, tableView.bounds.size.width - 2 * leftMargin, height)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:255 green:223 blue:0 alpha:100];
    label.font = [UIFont boldSystemFontOfSize:14];
    
    [headerView addSubview:label];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return [Lang LOC_BALANCE_HEADER_YOUR_BALANCE];
        case 2:
           return[Lang LOC_BALANCE_HEADER_TOPUP];
    }
    return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0.0 : 30.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0){
        return 50;
    }
    return 35;
}

-(NSString*) getCurrentProModeCellText{
    return [UserSettings premiumUnlocked] ? [Lang LOC_BALANCE_PRO_YES] : [Lang LOC_BALANCE_PRO_NO];
}

-(NSString*) getQuantifierStringForAmount:(int)amount{
    NSString* text;
    int tail = amount%10;
    if (amount%100 == 11){
        text = [Lang LOC_BALANCE_POSTSTAMPS_5];
    } else if (tail == 1){
        text = [Lang LOC_BALANCE_POSTSTAMPS_1];
    } else if (tail >= 1 && tail <= 3){
        text = [Lang LOC_BALANCE_POSTSTAMPS_3];
    } else {
        text = [Lang LOC_BALANCE_POSTSTAMPS_5];
    }
    return text;
}

@end
