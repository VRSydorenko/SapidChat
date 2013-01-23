//
//  CurrentBalanceCell.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentBalanceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelCurrentBalance;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
