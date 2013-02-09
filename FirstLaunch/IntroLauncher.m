//
//  IntroLauncher.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 2/9/13.
//  Copyright (c) 2013 Viktor Sydorenko. All rights reserved.
//

#import "IntroLauncher.h"

@implementation IntroLauncher

+ (void) showIntroOverCurrentViewController:(UIViewController <IntroScreenDelegate>*)currentViewController{
    IntroVC *intro = [[UIStoryboard storyboardWithName:@"FirstLaunch" bundle:nil] instantiateViewControllerWithIdentifier:@"SceneIntro"];
    intro.delegate = currentViewController;
    [currentViewController presentViewController:intro animated:YES completion:nil];
}

@end
