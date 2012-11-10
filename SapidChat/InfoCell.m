//
//  NoMessageToPickUpCell.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/10/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

@synthesize handler;

-(void)awakeFromNib{
    [self.btnHideCell addTarget:self action:@selector(hidePressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) hidePressed{
    [self.handler infoCellHideButtonPressed];
}

@end
