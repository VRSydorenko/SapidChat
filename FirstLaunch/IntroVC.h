//
//  IntroVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroScreenDelegate

- (void) introCloseButtonPressed;

@end

@interface IntroVC : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property id<IntroScreenDelegate> delegate;

- (IBAction)pageChanged:(id)sender;
- (IBAction)closePressed:(id)sender;

@end
