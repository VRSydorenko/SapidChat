//
//  Dialog.m
//  SChat
//
//  Created by Viktor Sydorenko on 6/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "Dialog.h"
#import "Message.h"

@interface Dialog(){
  NSMutableArray* messages;
}

@end

@implementation Dialog

@synthesize me = _me;
@synthesize collocutor = _collocutor;

-(id) initWithMe:(NSString*)me collocutor:(NSString*)collocutor{
    self = [super init];
    if (self){
        self.me = me;
        self.collocutor = collocutor;
        messages = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addMessage:(Message*)message{
    [messages addObject:message];
}

-(NSArray*) getSortedMessages{
    [messages sortUsingComparator:^(Message* msg1, Message* msg2){
        return [[NSNumber numberWithInt:msg1.when] compare:[NSNumber numberWithInt:msg2.when]];
    }];
    return [[NSArray alloc] initWithArray:messages];
}

-(void) dealloc{
    messages = nil;
}

@end
