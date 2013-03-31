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

@interface PurchaseManager(){
    SKProduct *productFullVersion;
    SKProduct *productPoststamps10;
    SKProduct *productPoststamps30;
    SKProduct *productPoststamps50;
    SKPaymentQueue* paymentQueue;
}
@end

@implementation PurchaseManager

@synthesize delegate = _delegate;

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
        NSLog(@"My payment functionality sucks :( shouldn't has came here");
    }
    [DataManager addRegularPoststampsToLocalBuffer: -amount];
}

- (id)initWithDelegate:(id<CommercialNotificationDelegate>)delegate
{
    self = [super init];
    if (self){
        self.delegate = delegate;
        paymentQueue = [SKPaymentQueue defaultQueue];
        [paymentQueue addTransactionObserver:self];
        [self requestProductsData];
    }
    return self;
}

-(void) makeItPro{
    if ([self canMakePurchases]){
        if (productFullVersion){
            SKPayment *payment = [SKPayment paymentWithProduct:productFullVersion];
            [paymentQueue addPayment:payment];
        } else {
            [self.delegate actionImpossible];
        }
    }
}

-(void) restoreFullVersion{
    [paymentQueue restoreCompletedTransactions];
}

-(void) purchasePoststamps10{
    if ([self canMakePurchases]){
        if (productPoststamps10){
            SKPayment *payment = [SKPayment paymentWithProduct:productPoststamps10];
            [paymentQueue addPayment:payment];
        } else {
            [self.delegate actionImpossible];
        }
    }
}

-(void) purchasePoststamps30{
    if ([self canMakePurchases]){
        if (productPoststamps30){
            SKPayment *payment = [SKPayment paymentWithProduct:productPoststamps30];
            [paymentQueue addPayment:payment];
        } else {
            [self.delegate actionImpossible];
        }
    }
}

-(void) purchasePoststamps50{
    if ([self canMakePurchases]){
        if (productPoststamps50){
            SKPayment *payment = [SKPayment paymentWithProduct:productPoststamps50];
            [paymentQueue addPayment:payment];
        } else {
            [self.delegate actionImpossible];
        }
    }
}

- (void)requestProductsData
{
    NSSet *productIdentifiers = [NSSet setWithObjects:PRODUCT_FULL_VERSION, PRODUCT_POSTSTAMPS_10, PRODUCT_POSTSTAMPS_30, PRODUCT_POSTSTAMPS_50, nil];
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    for (SKProduct* product in response.products) {
        if ([product.productIdentifier isEqualToString:PRODUCT_FULL_VERSION]){
            productFullVersion = product;
        } else if ([product.productIdentifier isEqualToString:PRODUCT_POSTSTAMPS_10]){
            productPoststamps10 = product;
        } else if ([product.productIdentifier isEqualToString:PRODUCT_POSTSTAMPS_30]){
            productPoststamps30 = product;
        } else if ([product.productIdentifier isEqualToString:PRODUCT_POSTSTAMPS_50]){
            productPoststamps50 = product;
        }
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        if ([invalidProductId isEqualToString:PRODUCT_FULL_VERSION]){
            productFullVersion = nil;
        } else if ([invalidProductId isEqualToString:PRODUCT_POSTSTAMPS_10]){
            productPoststamps10 = nil;
        } else if ([invalidProductId isEqualToString:PRODUCT_POSTSTAMPS_30]){
            productPoststamps30 = nil;
        } else if ([invalidProductId isEqualToString:PRODUCT_POSTSTAMPS_50]){
            productPoststamps50 = nil;
        }
    }
    
    [self.delegate productsLoaded];
    NSLog(@"Products loaded");
}

- (void)provideContent:(NSString*)productId
{
    if ([productId isEqualToString:PRODUCT_FULL_VERSION]){
        [UserSettings setPremiumUnlocked];
        [self.delegate fullVersionActivated];
    } else {
        int poststamps;
        if ([productId isEqualToString:PRODUCT_POSTSTAMPS_10]){
            poststamps = 10;
        } else if ([productId isEqualToString:PRODUCT_POSTSTAMPS_30]){
            poststamps = 30;
        } else if ([productId isEqualToString:PRODUCT_POSTSTAMPS_50]){
            poststamps = 50;
        } else {
            // unknown product. Cannot get here.
            [self.delegate errorOcurred];
            return;
        }

        if ([DataManager topUpUsersPoststamps:poststamps] != OK){
            // if user balance update (in AWS) failed for some reason so
            // store bought poststamps in local buffer in order for
            // not to lose it
            [DataManager addRegularPoststampsToLocalBuffer:poststamps];
        }
        [self.delegate poststampsPurchased];
    }
}

- (void)paymentQueue:(SKPaymentQueue*)queue updatedTransactions:(NSArray*)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self provideContent:transaction.payment.productIdentifier];
                [paymentQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                [paymentQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self provideContent:transaction.originalTransaction.payment.productIdentifier];
                [paymentQueue finishTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)failedTransaction:(SKPaymentTransaction*)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled){
        // error!
        NSLog(@"failedTransaction - FAILED");
        [self.delegate errorOcurred];
    } else {
        // the user just cancelled
        NSLog(@"failedTransaction - CANCELLED");
        [self.delegate userCancelled];
    }
}

- (BOOL)canMakePurchases
{
    if (![SKPaymentQueue canMakePayments]){
        [self.delegate purchasesDenied];
        return NO;
    }
    return YES;
}

-(void) dealloc{
    [paymentQueue removeTransactionObserver:self];
    paymentQueue = nil;
    productFullVersion = nil;
    productPoststamps10 = nil;
    productPoststamps30 = nil;
    productPoststamps50 = nil;
}

@end
