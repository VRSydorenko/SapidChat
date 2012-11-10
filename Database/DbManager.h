//
//  DbHelper.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/26/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Message.h"

#define USER_LANGS_SEPARATOR @","

@interface DbManager : NSObject

-(id) init;

-(void) open;
-(void) close;

-(void) saveUser:(User*)user;
-(User*) loadUser:(NSString*)email;
-(void) setMsgLanguages:(NSArray*)languages forUser:(NSString*)email;
-(void) saveMessage:(Message*)msg;
-(void) deleteMessage:(int)whenCreated;
-(NSArray*) loadMessagesWithCondition:(NSString*)condition;
-(void)setCollocutor:(NSString*)collocutor forExistingMessage:(int)globalInitialMessagesTimestamp;
-(int) getLastInMessageTimestamp;
-(int) getLastOutMessageTimestamp;
-(int) getUnreadMessagesCount;
-(void) resetUnreadMessagesCountForCollocutor:(NSString*)email;

@end
