//
//  IntroVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroVC : UIViewController <UIScrollViewDelegate>
{
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
	
    BOOL pageControlIsChangingPage;
}

- (IBAction)changePage:(id)sender;

@end

