//
//  NewMsgLanguageVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LangsIKnowVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textLangsIKnow;
@property (strong, nonatomic) IBOutlet UITableView *tableLanguages;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)backPressed:(id)sender;

@end
