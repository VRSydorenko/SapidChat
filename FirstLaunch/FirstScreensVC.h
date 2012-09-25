//
//  FirstScreensVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/25/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstScreensVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelWelcome;
@property (strong, nonatomic) IBOutlet UILabel *labelCompose;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUp;
@property (strong, nonatomic) IBOutlet UILabel *labelCommunicate;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UIButton *btnGo;
- (IBAction)goPressed:(id)sender;
@end
