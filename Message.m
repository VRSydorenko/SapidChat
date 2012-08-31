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

/*-(id) initWithData:(User*)from to:(User*)to at:(NSDate*)when text:(NSString*)text{
    self = [super init];
    if (self){
        self.text = text;
        self.from = from;
        self.to = to;
        self.when = when;
    }
    return self;
}*/

@end
