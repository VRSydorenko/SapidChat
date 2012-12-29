//
//  JBInfoBarManager.m
//  InfoBar
//
//  Created by Junior on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JBInfoBarManager.h"

static JBInfoBarManager *sharedJBInfoBarManager = nil;

@implementation JBInfoBarManager

@synthesize infoBar = _infoBar;

#pragma mark Init

- (id)init {
    self = [super init];
    if (self) {
        self.infoBar = nil;
    }
    return self;
}

#pragma mark -
#pragma mark Manager

- (void)initInfoBarWithFrame:(CGRect)frame {
    if (self.infoBar) {
        [self.infoBar removeFromSuperview];
        self.infoBar = nil;
    }
    self.infoBar = [[JBInfoBar alloc] initWithFrame:frame];
}

- (void)showInfoBarWithMessage:(NSString *)message forDuration:(float)seconds{
    [self.infoBar showBarWithMessage:message];
    [NSTimer scheduledTimerWithTimeInterval:seconds target:[JBInfoBarManager sharedManager] selector:@selector(hideInfoBar) userInfo:nil repeats:NO];
}

- (void)hideInfoBarWithMessage:(NSString *)message {
    [self.infoBar hideBarWithMessage:message];
}

- (void)hideInfoBar {
    [self.infoBar hideBarWithMessage:nil];
}


#pragma mark -
#pragma mark Singleton

+ (JBInfoBarManager *)sharedManager
{
    @synchronized(self) {
        if (sharedJBInfoBarManager == nil) {
            sharedJBInfoBarManager = [[super alloc] init];
        }
    }
    return sharedJBInfoBarManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedJBInfoBarManager == nil) {
            sharedJBInfoBarManager = [super allocWithZone:zone];
            return sharedJBInfoBarManager;
        }
    }
    return nil;
}

@end
