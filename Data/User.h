//
//  User.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 8/22/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSString* email;
@property (nonatomic) NSString* password;
@property (nonatomic) NSString* nickname;

@end
