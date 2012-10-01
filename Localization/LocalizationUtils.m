//
//  LocalizationUtils.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/25/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LocalizationUtils.h"

@implementation LocalizationUtils

+(void) setTitle:(NSString*)title forButton:(UIButton*)button{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
}

+(void) setText:(NSString*)text forLabel:(UILabel*)label{
    label.text = text;
    [label sizeToFit];
}

@end
