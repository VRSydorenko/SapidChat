//
//  Utils.h
//  SChat
//
//  Created by Viktor Sydorenko on 6/8/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbModel.h"

@interface Utils : NSObject

+(ErrorCodes) validateEmail:(NSString*)email;
+(NSArray*) buildDialogsOfUser:(NSString*)user msgs:(NSArray*)messages;
+(NSString*) getErrorDescription:(ErrorCodes)error;
+(NSString*) dateToString:(NSDate*)dateTime;
+(NSString*) timeToString:(NSDate*)dateTime;

+(NSString*) getSettingsKeyWHEN:(int)slot;
+(NSString*) getSettingsKeyTO:(int)slot;
+(NSString*) getSettingsKeyFROM:(int)slot;
+(NSString*) getSettingsKeyTEXT:(int)slot;

@end
