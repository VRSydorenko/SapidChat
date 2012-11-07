//
//  NewMsgLanguageVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewMsgLanguageVC;

@protocol NewMsgLanguagesSettingsDelegate
@required
- (void) msgLangControllerToDismiss:(NewMsgLanguageVC*)msgLangController;
@end

@interface NewMsgLanguageVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign) id <NewMsgLanguagesSettingsDelegate> handler;
@property (strong, nonatomic) IBOutlet UITextView *textNewMsgLangs;
@property (strong, nonatomic) IBOutlet UIButton *btnToLangsIKnow;
@property (strong, nonatomic) IBOutlet UITableView *tableLanguages;
- (IBAction)toLangsIKnowPressed:(id)sender;
@end
