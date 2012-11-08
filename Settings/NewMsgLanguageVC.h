//
//  NewMsgLanguageVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMsgLanguageVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textNewMsgLangs;
@property (strong, nonatomic) IBOutlet UIButton *btnToLangsIKnow;
@property (strong, nonatomic) IBOutlet UITableView *tableLanguages;
- (IBAction)toLangsIKnowPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)cancelPressed:(id)sender;

@end
