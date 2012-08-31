//
//  DbItemHelper.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/22/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "Data/User.h"

@interface DbItemHelper : NSObject

+ (Message*) prepareMessage:(NSDictionary*)item;
+ (User*) prepareUser:(NSDictionary*)item;

@end
