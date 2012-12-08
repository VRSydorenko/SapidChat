//
//  Message.m
//  SChat
//
//  Created by Viktor Sydorenko on 6/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize text = _text;
@synthesize from = _from;
@synthesize to = _to;
@synthesize when = _when;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize initial_message_global_timestamp;

-(id) init{
    self = [super init];
    if (self){
        self.latitude = 0;
        self.longitude = 0;
    }
    return self;
}

@end
