//
//  PurchaseManager.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 11/12/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "DbModel.h" 

#define PRODUCT_FULL_VERSION  @"com.sapidchat.fullversion"
#define PRODUCT_POSTSTAMPS_10 @"com.sapidchat.poststamps10"
#define PRODUCT_POSTSTAMPS_30 @"com.sapidchat.poststamps30"
#define PRODUCT_POSTSTAMPS_50 @"com.sapidchat.poststamps50"

@protocol CommercialNotificationDelegate
@optional
-(void)fullVersionActivated;
-(void)poststampsPurchased;
-(void)errorOcurred;
-(void)userCancelled;
-(void)purchasesDenied;
-(void)productsLoaded;
-(void)actionImpossible;
@end

@interface PurchaseManager : NSObject<SKProductsRequestDelegate,
                                      SKPaymentTransactionObserver>

+(ErrorCodes) beginRegularPoststampsSpending:(int)amount;
+(void) finishRegularPoststampsSpending:(int)amount;

@property (nonatomic) id<CommercialNotificationDelegate> delegate;

-(id)initWithDelegate:(id<CommercialNotificationDelegate>)delegate;
-(void) makeItPro;
-(void) restoreFullVersion;
-(void) purchasePoststamps10;
-(void) purchasePoststamps30;
-(void) purchasePoststamps50;

@end