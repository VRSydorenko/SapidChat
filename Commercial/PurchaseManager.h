//
//  PurchaseManager.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/12/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbModel.h" 

@interface PurchaseManager : NSObject

+(ErrorCodes) beginRegularPoststampsSpending:(int)amount;
+(void) finishRegularPoststampsSpending:(int)amount;

//+(ErrorCodes) beginBonusPoststampsSpending:(int)amount;
//+(void) finishBonusPoststampsSpending:(int)amount;

+(ErrorCodes) purchaseRegularPoststamps;
+(ErrorCodes) purchaseBonusPoststamps; // actually bonus ones are free, just such naming

@end
