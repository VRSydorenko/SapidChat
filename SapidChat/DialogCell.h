//
//  DialogCell.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 7/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *viewEnvelopePattern;
@property (strong, nonatomic) IBOutlet UIImageView *imageEnvelopeRight;
@property (strong, nonatomic) IBOutlet UILabel *labelCollocutor;
@property (strong, nonatomic) IBOutlet UILabel *infoMessage;
@end
