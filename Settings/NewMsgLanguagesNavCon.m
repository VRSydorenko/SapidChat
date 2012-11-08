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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) closeUsingHandler{
    [self.handler msgLangControllerToDismiss:self];
}

@end
