//
//  UserRegistrator.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/5/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationNavController.h"

@interface UserRegistrator : NSObject

+ (void) registerUserOverCurrentViewController:(UIViewController*)currentViewController;

@end
