//
//  SapidInfoBarManager.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/29/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SapidInfoBarView.h"

typedef enum MessageMoodTypes{
    POSITIVE,
    NEUTRAL,
    NEGATIVE
} MessageMoodTypes;

@interface SapidInfoBarManager : NSObject

@property (strong, nonatomic) SapidInfoBarView *infoBar;

+ (SapidInfoBarManager*)sharedManager;

- (void)initInfoBarWithTopViewFrame:(CGRect)frame andHeight:(CGFloat)height;
- (void)showInfoBarWithMessage:(NSString *)message withMood:(MessageMoodTypes)mood;

@end