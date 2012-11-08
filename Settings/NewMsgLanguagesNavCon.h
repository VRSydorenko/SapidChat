//
//  NewMsgLanguagesNavCon.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMsgLanguageVC.h"

@class NewMsgLanguagesNavCon;

@protocol NewMsgLanguagesSettingsDelegate
@required
- (void) msgLangControllerToDismiss:(NewMsgLanguagesNavCon*)msgLangController;
@end

@interface NewMsgLanguagesNavCon : UINavigationController

@property (assign) id <NewMsgLanguagesSettingsDelegate> handler;

-(void) closeUsingHandler;

@end
