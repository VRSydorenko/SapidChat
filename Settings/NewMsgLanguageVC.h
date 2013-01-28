//
//  NewMsgLanguageVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMsgLanguageVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableLanguages;
@property (strong, nonatomic) IBOutlet UIButton *btnToLangsIKnow;
- (IBAction)toLangsIKnowPressed:(id)sender;
- (IBAction)closePressed:(id)sender;

@end
