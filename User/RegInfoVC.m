//
//  InfoVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "RegInfoVC.h"
#import "Utils.h"

@interface RegInfoVC ()

@end

@implementation RegInfoVC

@synthesize textInfo;
@synthesize infoString;

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
    self.textInfo.text = self.infoString;
}

- (void)viewDidUnload
{
    [self setTextInfo:nil];
    [super viewDidUnload];
}


@end
