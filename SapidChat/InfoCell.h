//
//  NoMessageToPickUpCell.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/10/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoCellDelegate
@required
- (void) infoCellHideButtonPressed;
@end

@interface InfoCell : UITableViewCell

@property (strong, nonatomic) UIViewController<InfoCellDelegate>* handler;
@property (strong, nonatomic) IBOutlet UITextView *textNoMessageToPickUp;
@property (strong, nonatomic) IBOutlet UIButton *btnHideCell;

@end
