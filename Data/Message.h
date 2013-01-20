//
//  Message.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject <NSCopying>

@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* from;
@property (nonatomic, copy) NSString* to;
@property (nonatomic) int when;
@property (nonatomic) int type;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, copy) NSData* attachmentData;
@property (nonatomic, copy) NSString* attachmentName;
// initial messages are timestamps of first messages in the current dialog
@property (nonatomic) int initial_message_global_timestamp;


@end