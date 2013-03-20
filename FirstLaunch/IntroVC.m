//
//  IntroVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "IntroVC.h"
#import "Lang.h"
#import "FirstLaunchNavController.h"
#import "DbModel.h"

@interface IntroVC (){
    bool isChanginPage;
}

@end

@implementation IntroVC

@synthesize scrollView;
@synthesize pageControl;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.fakeNavBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barGreenBackground.png"]];
    self.labelTitle.font = [UIFont fontWithName:APPLICATION_NAME_FONT size:20.0];
    
    self.scrollView.delegate = self;
    [self setupContent];
}

- (void)dealloc
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setDelegate:nil];
    [super viewDidUnload];
}

- (IBAction)pageChanged:(id)sender {
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
	
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    isChanginPage = YES;
}

- (void)setupContent
{
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	
    const int pageCount     = 4;
    const int scrollViewHeight = self.scrollView.frame.size.height;
	const int screenWidth   = 320;
    const int imageHeight   = 290;
    const int imageWidth    = 320;
    const int labelMargin   = 20;
    
    UIFont* textFront = [UIFont fontWithName:@"Helvetica" size:15.0f];
    NSString* imageName = @"";
	for (int i = 0; i < pageCount; i++) { // 4 pages
        
        // setup image
        
        switch (i) {
            case 0: imageName = @"intro_welcome.png";   break;
            case 1: imageName = @"intro_compose.png";   break;
            case 2: imageName = @"intro_pickup.png";    break;
            case 3: imageName = @"intro_communicate.png";   break;
        }
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		CGRect imageRect = imageView.frame;
		imageRect.size.height = imageHeight;
		imageRect.size.width = imageWidth;
		imageRect.origin.x = i * screenWidth;
		imageRect.origin.y = scrollViewHeight - imageHeight;
        
		imageView.frame = imageRect;

        [self.scrollView addSubview:imageView];
        
		// setup label
        
        CGRect labelRect = CGRectMake(i * screenWidth + labelMargin, labelMargin, screenWidth - 2 * labelMargin, scrollViewHeight - imageHeight - 5.0);
        
        UILabel *labelView = [[UILabel alloc] initWithFrame:labelRect];
        labelView.font = textFront;
        labelView.lineBreakMode = NSLineBreakByWordWrapping;
        labelView.numberOfLines = 0;
        
        switch (i) {
            case 0: labelView.text = [Lang LOC_FIRSTLAUNCH_LABEL_WELCOME];   break;
            case 1: labelView.text = [Lang LOC_FIRSTLAUNCH_LABEL_COMPOSE];   break;
            case 2: labelView.text = [Lang LOC_FIRSTLAUNCH_LABEL_PICKITUP];  break;
            case 3: labelView.text = [Lang LOC_FIRSTLAUNCH_LABEL_COMMUNICATE];   break;
        }
        [labelView sizeToFit];
        
        [self.scrollView addSubview:labelView];
	}
	
	[self.scrollView setContentSize:CGSizeMake(screenWidth * pageCount, [self.scrollView bounds].size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (isChanginPage) {
        return;
    }
    
	/*
	 *	We switch page at 50% across
	 */
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    isChanginPage = NO;
}

- (IBAction)closePressed:(id)sender {
    [self.delegate introCloseButtonPressed:self];
}


- (void)viewDidUnload {
    [self setLabelTitle:nil];
    [self setFakeNavBar:nil];
    [super viewDidUnload];
}
@end
