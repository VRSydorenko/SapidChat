//
//  BuyOptionCell.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyOptionCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelPercentageOff;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;

@end
