//
//  ComposeVC.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/1/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "NewMsgLanguagesNavCon.h"
#import "MainNavController.h"
#import "ATMHudDelegate.h"

@protocol ComposeNewMessageResponseDelegate
@required
- (void) composeCompleted:(Message*)composedMsg;
@end

@interface ComposeVC : UIViewController<NewMsgLanguagesSettingsDelegate,
                                        UINavigationControllerDelegate,
                                        UIImagePickerControllerDelegate,
                                        UIActionSheetDelegate,
                                        ATMHudDelegate>

@property (strong, nonatomic) id <ComposeNewMessageResponseDelegate> composeHandler;
@property (strong, nonatomic) IBOutlet UITextView *textMessage;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *buttonLanguageIcon;
@property (strong, nonatomic) IBOutlet UILabel *labelInfoText;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIButton *btnSendIcon;
@property (strong, nonatomic) IBOutlet UIButton *btnAttachData;
@property (strong, nonatomic) IBOutlet UIButton *btnProInfo;

// for sending message to collocutor
@property (nonatomic) int initialMsgGlobalTimstamp;
@property (nonatomic) NSString* collocutor;

- (void)backPressed;
- (IBAction)sendPressed:(id)sender;
- (IBAction)languagePressed:(id)sender;
- (IBAction)attachDataPressed:(id)sender;

- (void)setNavigationController:(MainNavController*)controller;

@end
