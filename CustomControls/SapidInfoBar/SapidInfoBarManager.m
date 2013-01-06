//
//  SapidInfoBarManager.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/29/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "SapidInfoBarManager.h"

@implementation SapidInfoBarManager

@synthesize infoBar = _infoBar;

#pragma mark Init

- (id)init {
    self = [super init];
    if (self) {
        self.infoBar = nil;
    }
    return self;
}

- (void)initInfoBarWithTopViewFrame:(CGRect)frame andHeight:(CGFloat)height {
    if (self.infoBar) {
        [self.infoBar removeFromSuperview];
        self.infoBar = nil;
    }
    CGRect newFrame = frame;
    if (frame.size.height != height){
        newFrame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - height, frame.size.width, height);
    }
    self.infoBar = [[SapidInfoBarView alloc] initWithFrame:newFrame];
}

- (void)showInfoBarWithMessage:(NSString *)message withMood:(MessageMoodTypes)mood{
    if (!self.infoBar){
        return;
    }
    switch (mood) {
        case POSITIVE:
            [self.infoBar showPositiveMessage:message];
            break;
        case NEUTRAL:
            [self.infoBar showNeutralMessage:message];
            break;
        case NEGATIVE:
            [self.infoBar showNegativeMessage:message];
            break;
    }
}

-(void) dealloc{
    self.infoBar = nil;
}

@end