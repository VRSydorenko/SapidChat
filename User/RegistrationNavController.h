//
//  RegistratinoWizardPageVC.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/25/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class RegistrationNavController;

@protocol UserRegistrationDelegate
@required
- (void) controllerToDismiss:(RegistrationNavController*)regController whichRegisteredTheUser:(User*) user;
@end

@interface RegistrationNavController: UINavigationController

@property (nonatomic) NSString* currentSegue;

@property (nonatomic) NSString* email;
@property (nonatomic) NSString* password;
@property (nonatomic) NSString* nickname;
@property (nonatomic) NSMutableArray* selectedLanguages;

@property (assign) id <UserRegistrationDelegate> handler;
-(void) cancel;

-(User*) composeUser;

@end
