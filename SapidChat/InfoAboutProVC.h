//
//  InfoAboutProVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 12/10/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoAboutProVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *fakeNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tabelFeatures;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
- (IBAction)closePressed:(id)sender;

@end
