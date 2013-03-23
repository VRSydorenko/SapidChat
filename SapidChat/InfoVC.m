//
//  InfoVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "InfoVC.h"
#import "Utils.h"

@interface InfoVC ()

@end

@implementation InfoVC

@synthesize textInfo;
@synthesize infoString;

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
    self.textInfo.text = self.infoString;
}

- (void)dealloc
{
    [self setTextInfo:nil];
}

-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
