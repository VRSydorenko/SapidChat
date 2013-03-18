//
//  NewMsgLanguageVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/7/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllLangsVC;

@protocol OneLanguagePickerDelegate
@required
- (void) languagePicked:(NSNumber*)lang inController:(AllLangsVC*)allLangsViewController;
@end

@interface AllLangsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableLanguages;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (assign) id <OneLanguagePickerDelegate> handler;
@property (assign, nonatomic) BOOL onlyAppLanguages;
@property (strong, nonatomic) IBOutlet UIView *fakeNavBar;
- (IBAction)closePressed:(id)sender;

@end
