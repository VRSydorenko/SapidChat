//
//  IntrigueSellVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 10/3/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntrigueSellVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textViewDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnActivate;
- (IBAction)activatePressed:(id)sender;
@end
