//
//  JBInfoBarManager.h
//  InfoBar
//
//  Created by Junior on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBInfoBar.h"

@interface JBInfoBarManager : NSObject

@property (strong, nonatomic) JBInfoBar *infoBar;

+ (JBInfoBarManager *)sharedManager;

- (void)initInfoBarWithFrame:(CGRect)frame;

- (void)showInfoBarWithMessage:(NSString *)message forDuration:(float)seconds;
- (void)hideInfoBarWithMessage:(NSString *)message;

@end
