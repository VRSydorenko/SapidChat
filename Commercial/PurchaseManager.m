//
//  PurchaseManager.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/12/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "PurchaseManager.h"
#import "UserSettings.h"
#import "DataManager.h"

@implementation PurchaseManager

// if returns OK: user is charged on the server side and poststamps can be spent
+(ErrorCodes) beginRegularPoststampsSpending:(int)amount{
    ErrorCodes result = OK;
    
    int bufferedPoststamps = [DataManager getRegularPoststampsFromLocalBuffer];
    if (bufferedPoststamps < amount){ // fill buffer with enough amount
        int amountToChargeOnServer = amount - bufferedPoststamps;
        result = [DataManager spendRegularPoststamps:amountToChargeOnServer];
        if (result != OK){
            return result;
        }
        [DataManager addRegularPoststampsToLocalBuffer:amountToChargeOnServer]; // now new complete amount is in the buffer
    }
    
    return result;
}

+(void) finishRegularPoststampsSpending:(int)amount{
    int bufferedPoststamps = [DataManager getRegularPoststampsFromLocalBuffer];
    if (bufferedPoststamps < amount){
        NSLog(@"payment functionality sucks :( shouldn't has came here");
    }
    [DataManager addRegularPoststampsToLocalBuffer: -amount];
}

+(ErrorCodes) purchaseRegularPoststamps{
    ErrorCodes result = OK;
    return result;
}
+(ErrorCodes) purchaseBonusPoststamps{ // actually bonus ones are free, just such naming
    ErrorCodes result = OK;
    return result;
}

// private methods

+(ErrorCodes) synchronizeWithAWS{
    ErrorCodes result = OK;
    return result;
}

@end
