//
//  NewMsgLanguagesNavCon.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "NewMsgLanguagesNavCon.h"

@interface NewMsgLanguagesNavCon ()

@end

@implementation NewMsgLanguagesNavCon

@synthesize handler;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"barGreenBackground.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void) closeUsingHandler{
    [self.handler msgLangControllerToDismiss:self];
}

@end
