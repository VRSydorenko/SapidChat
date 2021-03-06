/*
 * Copyright 2010-2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import "AmazonClientManager.h"
#import <AWSiOSSDK/AmazonLogger.h>
#import "AmazonKeyChainWrapper.h"
#import "AmazonTVMClient.h"
#import <AWSiOSSDK/SES/AmazonSESClient.h>

static AmazonDynamoDBClient *ddb = nil;
static AmazonSESClient      *ses = nil;
static AmazonS3Client       *s3  = nil;
static AmazonTVMClient      *tvm = nil;

@implementation AmazonClientManager

+(AmazonDynamoDBClient*)ddb
{
    [AmazonClientManager validateCredentials];
    return ddb;
}

+(AmazonSESClient*)ses
{
    [AmazonClientManager validateCredentials];
    return ses;
}

+(AmazonS3Client*)s3
{
    [AmazonClientManager validateCredentials];
    return s3;
}

+(AmazonTVMClient*)tvm
{
    if (tvm == nil) {
        tvm = [[AmazonTVMClient alloc] initWithEndpoint:@"sapidchat.elasticbeanstalk.com" useSSL:NO];
    }
    
    return tvm;
}

+(Response *)validateCredentials
{
    Response *ableToGetToken = [[[Response alloc] initWithCode:200 andMessage:@"OK"] autorelease];
    
    if ([AmazonKeyChainWrapper areCredentialsExpired]) {
        
        @synchronized(self)
        {
            if ([AmazonKeyChainWrapper areCredentialsExpired]) {
                
                ableToGetToken = [[AmazonClientManager tvm] anonymousRegister];
                
                if ( [ableToGetToken wasSuccessful])
                {
                    ableToGetToken = [[AmazonClientManager tvm] getToken];
                    
                    if ( [ableToGetToken wasSuccessful])
                    {
                        [AmazonClientManager initClients];
                    }
                }
            }
        }
    }
    else if (ddb == nil || ses == nil)
    {
        @synchronized(self)
        {
            if (ddb == nil || ses == nil)
            {
                [AmazonClientManager initClients];
            }
        }
    }
    
    return ableToGetToken;
}

+(void)initClients
{
    AmazonCredentials *credentials = [AmazonKeyChainWrapper getCredentialsFromKeyChain];
    
    [ddb release];
    ddb = [[AmazonDynamoDBClient alloc] initWithCredentials:credentials];
    
    [ses release];
    ses = [[AmazonSESClient alloc] initWithCredentials:credentials];
    
    [s3 release];
    s3 = [[AmazonS3Client alloc] initWithCredentials:credentials];
}

+(void)wipeAllCredentials
{
    @synchronized(self)
    {
        [AmazonKeyChainWrapper wipeCredentialsFromKeyChain];
        
        [ddb release];
        ddb = nil;
        
        [ses release];
        ses = nil;
    }
}

+ (void)wipeCredentialsOnAuthError:(NSError *)error
{
    id exception = [error.userInfo objectForKey:@"exception"];
    
    if([exception isKindOfClass:[AmazonServiceException class]])
    {
        AmazonServiceException *e = (AmazonServiceException *)exception;
        
        if(
           // STS http://docs.amazonwebservices.com/STS/latest/APIReference/CommonErrors.html
           [e.errorCode isEqualToString:@"IncompleteSignature"]
           || [e.errorCode isEqualToString:@"InternalFailure"]
           || [e.errorCode isEqualToString:@"InvalidClientTokenId"]
           || [e.errorCode isEqualToString:@"OptInRequired"]
           || [e.errorCode isEqualToString:@"RequestExpired"]
           || [e.errorCode isEqualToString:@"ServiceUnavailable"]
           
           // DynamoDB http://docs.amazonwebservices.com/amazondynamodb/latest/developerguide/ErrorHandling.html#APIErrorTypes
           || [e.errorCode isEqualToString:@"AccessDeniedException"]
           || [e.errorCode isEqualToString:@"IncompleteSignatureException"]
           || [e.errorCode isEqualToString:@"MissingAuthenticationTokenException"]
           || [e.errorCode isEqualToString:@"ValidationException"]
           || [e.errorCode isEqualToString:@"InternalFailure"]
           || [e.errorCode isEqualToString:@"InternalServerError"])
        {
            [AmazonClientManager wipeAllCredentials];
        }
    }
}

@end
