//
//  Dialog.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface Dialog : NSObject

@property (nonatomic) NSString* me;
@property (nonatomic) NSString* collocutor;

-(id) initWithMe:(NSString*)me collocutor:(NSString*)collocutor;
-(void) addMessage:(Message*)message;
-(NSArray*) getSortedMessages;

@end
