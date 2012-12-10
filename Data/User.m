//
//  User.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/22/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize email = _email;
@synthesize nickname = _nickname;
@synthesize languages = _languages;
@synthesize rp = _rp;

-(NSString*)getEmail{
    return [_email lowercaseString];
}

@end