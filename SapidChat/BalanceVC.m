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
#import "Utils.h"
#import "MainNavController.h"

@interface BalanceVC (){
    MainNavController* navController;
    PurchaseManager* purchaseManager;
    bool operationInProgress;
    bool productsLoading;
}

@end

@implementation BalanceVC
@synthesize tableContent;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    operationInProgress = YES;
    productsLoading = YES;
    
    navController = (MainNavController*)self.navigationController;
    purchaseManager = [[PurchaseManager alloc] initWithDelegate:self];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
    self.title = [Lang LOC_BALANCE_SCREEN_TITLE];
    self.tableContent.dataSource = self;
    self.tableContent.delegate = self;
}

- (void)dealloc{
    [self setTableContent:nil];
    purchaseManager = nil;
    [super viewDidUnload];
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
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
                    cell.labelProMode.text = [self getCurrentProModeCellText];
                    cell.imageCurrentVersion.image = [self getCurrentProModeCellImage];
                    return  cell;
                }
                case 1:{
                    ReadAboutProCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReadMoreAboutPro"];
                    cell.labelReadAboutPro.text = [Lang LOC_BALANCE_WHAT_IN_PRO];
                    return cell;
                }
                case 2:{
                    MakeItProCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellMakeItPro"];
                    [cell.segmentedControl setTitle:[Lang LOC_BALANCE_PRO_YES] forSegmentAtIndex:0];
                    [cell.segmentedControl setTitle:[Lang LOC_BALANCE_BTN_RESTORE] forSegmentAtIndex:1];
                    
                    UIFont *font = [UIFont boldSystemFontOfSize:15.0f];
                    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                             forKey:UITextAttributeFont];
                    [cell.segmentedControl setTitleTextAttributes:attributes
                                                    forState:UIControlStateNormal];
                    
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
            if (operationInProgress){
                [cell.spinner startAnimating];
            } else {
                [cell.spinner stopAnimating];
            }
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [Lang LOC_BALANCE_HEADER_APP];
        case 1:
            return [Lang LOC_BALANCE_HEADER_YOUR_BALANCE];
        case 2:
           return [Lang LOC_BALANCE_HEADER_TOPUP];
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 2){ // only poststamps cells are active
        return;
    }
    if (operationInProgress){
        return;
    }
    
    operationInProgress = YES;
    
    switch (indexPath.row) {
        case 0:
            [purchaseManager purchasePoststamps10];
            break;
        case 1:
            [purchaseManager purchasePoststamps30];
            break;
        case 2:
            [purchaseManager purchasePoststamps50];
            break;
        default:
            operationInProgress = NO;
            break;
    }
    
    [self.tableContent reloadData];
}

-(NSString*) getCurrentProModeCellText{
    return [UserSettings premiumUnlocked] ? [Lang LOC_BALANCE_PRO_YES] : [Lang LOC_BALANCE_PRO_NO];
}

-(UIImage*) getCurrentProModeCellImage{
    NSString* imageName = [UserSettings premiumUnlocked] ? @"check.png" : @"exclamation.png";
    return [UIImage imageNamed:imageName];
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

- (IBAction)segmentPicked:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    [self.tableContent reloadData];
    if (segmentedControl.selectedSegmentIndex == 0){
        operationInProgress = YES;
        [purchaseManager makeItPro];
    } else {
        [purchaseManager restoreFullVersion];
    }
    [segmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

-(void)fullVersionActivated{
    [navController showInfoBarWithPositiveMessage:[Lang LOC_BALANCE_RESULT_FULL_ACTIVATED]];
    operationInProgress = NO;
    [self.tableContent reloadData];
}

-(void)poststampsPurchased{
    [navController showInfoBarWithPositiveMessage:[Lang LOC_BALANCE_RESULT_TOPPED_UP]];
    operationInProgress = NO;
    [self.tableContent reloadData];
}

-(void)errorOcurred{
    [navController showInfoBarWithNegativeMessage:[Lang LOC_BALANCE_RESULT_ERROR]];
    operationInProgress = NO;
    [self.tableContent reloadData];
}

-(void)purchasesDenied{
    [navController showInfoBarWithNeutralMessage:[Lang LOC_BALANCE_RESULT_NOTAUTHORIZED]];
    operationInProgress = NO;
    [self.tableContent reloadData];
}

-(void)productsLoaded{
    operationInProgress = NO;
    productsLoading = NO;
    [self.tableContent reloadData];
}

-(void) userCancelled{
    operationInProgress = NO;
    [self.tableContent reloadData];
}

-(void) actionImpossible{
    [navController showInfoBarWithNeutralMessage:[Lang LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE]];
    operationInProgress = NO;
    [self.tableContent reloadData];
}

@end
