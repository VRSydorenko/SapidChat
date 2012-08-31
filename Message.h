//
//  Message.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic) NSString* text;
@property (nonatomic) NSString* from;
@property (nonatomic) NSString* to;
@property (nonatomic) NSDate* when;


@end
