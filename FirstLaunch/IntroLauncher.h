//
//  IntroLauncher.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 2/9/13.
//  Copyright (c) 2013 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroVC.h"

@interface IntroLauncher : NSObject

+ (void) showIntroOverCurrentViewController:(UIViewController <IntroScreenDelegate>*)currentViewController;

@end
