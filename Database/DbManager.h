//
//  DbHelper.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/26/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#define USER_LANGS_SEPARATOR @","

@interface DbManager : NSObject

-(id) init;
-(void) close;

-(void) saveUser:(User*)user;

@end
