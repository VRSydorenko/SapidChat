//
//  ComposeVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/1/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComposeNewMessageResponseDelegate
@required
- (void) composeCompleted;
@end

@interface ComposeVC : UIViewController

@property (strong, nonatomic) id <ComposeNewMessageResponseDelegate> composeHandler;
@property (strong, nonatomic) IBOutlet UITextView *textMessage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)sendPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
@end
