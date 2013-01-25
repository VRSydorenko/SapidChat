//
//  DbHelper.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/26/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSiOSSDK/AmazonServiceRequest.h>
#import "User.h"
#import "Message.h"

#define USER_LANGS_SEPARATOR @","

@protocol AttachmentDataUpdateDelegate

-(void)attachmentDataUpdatedForName:(NSString*)attachmentName data:(NSData*)attachmentData;

@end

@interface DbManager : NSObject<AmazonServiceRequestDelegate>

@property id<AttachmentDataUpdateDelegate> attachmentUpdateDelegate;

-(id) init;

-(void) open;
-(void) close;

-(void) saveUser:(User*)user;
-(void) deleteUser:(NSString*)user;
-(User*) loadUser:(NSString*)email;
-(void)updateOwnNick:(NSString*)nick;
-(void) setMsgLanguages:(NSArray*)languages forUser:(NSString*)email;
-(void) saveMessage:(Message*)msg;
-(void) deleteMessage:(int)whenCreated;
-(NSArray*) loadMessagesWithCondition:(NSString*)condition;
-(void)setCollocutor:(NSString*)collocutor forExistingMessage:(int)globalInitialMessagesTimestamp;
-(int) getLastInMessageTimestamp;
-(int) getMaxInSystemMessageTimestamp;
-(int) getLastOutMessageTimestamp;
-(int) getUnreadMessagesCount;
-(int) getUnreadMessagesCountForCollocutor:(NSString*)user;
-(void) resetUnreadMessagesCountForCollocutor:(NSString*)email;

-(int) getRegularPoststampsCount;
-(void) addRegularPoststamps:(int)count;
-(int) getRegularPoststampsFromLocalBuffer;
-(void) addRegularPoststampsToLocalBuffer:(int)count;

-(void)request:(AmazonServiceRequest *)request didCompleteWithResponse:(AmazonServiceResponse *)response;
-(void)request:(AmazonServiceRequest *)request didFailWithServiceException:(NSException *)exception;

@end
