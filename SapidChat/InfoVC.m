//
//  InfoVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "InfoVC.h"

@interface InfoVC ()

@end

@implementation InfoVC

@synthesize textInfo;
@synthesize infoString;

-(void) viewDidLoad{
    [super viewDidLoad];
    self.textInfo.text = self.infoString;
}

- (void)viewDidUnload
{
    [self setTextInfo:nil];
    [super viewDidUnload];
}


@end
