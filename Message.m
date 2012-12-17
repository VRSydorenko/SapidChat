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
@synthesize type = _type;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize attachmentData = _attachmentData;
@synthesize attachmentName = _attachmentName;
@synthesize initial_message_global_timestamp;

-(id) init{
    self = [super init];
    if (self){
        self.text = @"";
        self.latitude = 0;
        self.longitude = 0;
    }
    return self;
}

-(NSString*) attachmentName{
    if (_attachmentName && _attachmentName.length > 0){ // if it has already been initialised (loaded from AWS) then return it
        return _attachmentName;
    }
    if (self.from.length == 0 ||
        //self.to.length == 0 ||
        self.when == 0 ||
        self.attachmentData.length == 0){
        return @"";
    }
    return [NSString stringWithFormat:@"%@_%d", self.from, self.when];
}

@end
