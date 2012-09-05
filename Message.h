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
// initial messages are timestamps of first messages in the current dialog
@property (nonatomic) int initial_message_global_timestamp;


@end
