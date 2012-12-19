//
//  DbManager.m
//  SChat
//
//  Created by Viktor Sydorenko on 5/16/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "DataManager.h"
#import "AmazonClientManager.h"
#import "DbItemHelper.h"
#import "DbModel.h"
#import "Utils.h"
#import "UserSettings.h"
#import "Message.h"
#import "Dialog.h"
#import "AmazonKeyChainWrapper.h"

@interface DataManager()

@end

@implementation DataManager

+(DbManager*) getDbManager{ // private
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).dbManager;
}

+(User*) getCurrentUser{
    return [[self getDbManager] loadUser:[UserSettings getEmail]];
}

+(void) setMsgLanguagesForCurrentUser:(NSArray*)langs{
    [[self getDbManager] setMsgLanguages:langs forUser:[UserSettings getEmail]];
}

+(int) getLastInMessageTimestamp{
    return [[self getDbManager] getLastInMessageTimestamp];
}

+(int) getLastOutMessageTimestamp{
    return [[self getDbManager] getLastOutMessageTimestamp];
}

+(int) getUnreadMessagesCount{
    return [[self getDbManager] getUnreadMessagesCount];
}

+(void) resetUnreadMessagesCountForCollocutor:(NSString*)email{
    [[self getDbManager] resetUnreadMessagesCountForCollocutor:email];
}

+(void) saveUser:(User*)user{
    [[self getDbManager] saveUser:user];
}

+(void) updateOwnNickInDb:(NSString*)nick{
    [[self getDbManager] updateOwnNick:nick];
}

+(void) setNewMessageLanguageFromUserLanguages:(NSArray*)languages{
    int currentNewMsgLang = [UserSettings getNewMessagesLanguage];
    bool langFound = NO;
    for (NSNumber* num in languages) {
        if (num.intValue == currentNewMsgLang){
            langFound = YES;
            break;
        }
    }
    if (!langFound){
        int lang = ((NSNumber*)[languages objectAtIndex:0]).intValue;
        [UserSettings setNewMessagesLanguage:lang];
    }
}

+(User*) loadUser:(NSString*)email{
    return [[self getDbManager] loadUser:email];
}

+(void) saveMessage:(Message*)msg{
    [[self getDbManager] saveMessage:msg];
    if (msg.initial_message_global_timestamp > 0){
        [[self getDbManager] setCollocutor:msg.from forExistingMessage:msg.initial_message_global_timestamp];
    }
}

+(BOOL) existsUserWithEmail:(NSString*)email{
    DynamoDBGetItemRequest *getItemRequest = [[DynamoDBGetItemRequest alloc] init];
    getItemRequest.tableName = DBTABLE_USERS;
    DynamoDBAttributeValue* keyAttr = [[DynamoDBAttributeValue alloc] initWithS:email];
    DynamoDBKey *key = [[DynamoDBKey alloc] initWithHashKeyElement: keyAttr];
    getItemRequest.key = key;
    DynamoDBGetItemResponse *response = [[AmazonClientManager ddb] getItem:getItemRequest];
    return response.item.count != 0;
}

+(ErrorCodes) registerNewUser:(User*)user password:(NSString*)password{
    if ([DataManager existsUserWithEmail:user.email]){
        return USER_EXISTS;
    }
    @try
    {
        NSMutableDictionary* userDic = [[NSMutableDictionary alloc] init];
        
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:user.email] forKey:DBFIELD_USERS_EMAIL];
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:password] forKey:DBFIELD_USERS_PASSWORD];
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:user.nickname] forKey:DBFIELD_USERS_NICKNAME];
        NSMutableArray* langs = [[NSMutableArray alloc] init];
        for (NSNumber* lang in user.languages) {
            [langs addObject:lang.stringValue];
        }
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithNS:langs] forKey:DBFIELD_USERS_LANGS];
        NSString* rpString = [NSString stringWithFormat:@"%d", user.rp];
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithN:rpString] forKey:DBFIELD_USERS_RP];

        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_USERS andItem:userDic];
        DynamoDBPutItemResponse *response = nil;
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
    } @catch (NSException *exception) {
        NSLog(@"SapidChat :: Exception registering user: %@", exception);
        return ERROR;
    }
    return OK;
}

+(ErrorCodes)login:(NSString*)email password:(NSString*)password{
    ErrorCodes result = [Utils validateEmail:email];
    if (result == OK){
        User* user = nil;
        result = [self retrieveUser:&user withEmail:email];
        if (result == OK){
            if ([password isEqualToString:[AmazonKeyChainWrapper getValueFromKeyChain:user.email]]){
                [UserSettings setEmail:[email lowercaseString]];
                [AmazonKeyChainWrapper storeValueInKeyChain:password forKey:[email lowercaseString]];
                [[self getDbManager] saveUser:user];
                [self setNewMessageLanguageFromUserLanguages:user.languages];
            } else {
                result = WRONG_PASSWORD;
            }
        }
    }
    return result;
}

+(ErrorCodes) sendIntrigueTo:(NSString*)email withOptionalText:(NSString*)text{
    SESContent *messageBody = [[SESContent alloc] init];
    messageBody.data = text;
        
    SESContent *subject = [[SESContent alloc] init];
    subject.data = @"This is subject";
        
    SESBody *body = [[SESBody alloc] init];
    body.text = messageBody;
        
    SESMessage *message = [[SESMessage alloc] init];
    message.subject = subject;
    message.body    = body;
        
    SESDestination *destination = [[SESDestination alloc] init];
    [destination.toAddresses addObject:email];
    
    SESSendEmailRequest *emailRequest = [[SESSendEmailRequest alloc] init];
    emailRequest.source = @"viktor.sydorenko@gmail.com";
    emailRequest.destination = destination;
    emailRequest.message = message;
    
    Message* msg = [[Message alloc] init];
    msg.from = [UserSettings getEmail];
    msg.to = email;
    msg.text = @"Hi!! This is an intrigue message! Lets be friends! :)";
    msg.type = MSG_INTRIGUE;
    msg.when = [[NSDate date] timeIntervalSinceReferenceDate];
    
    ErrorCodes result = [self sendMessageToCollocutor:msg];
    if (result == OK){
        SESSendEmailResponse *response = nil;
        @try{
            AmazonSESClient *ses = [AmazonClientManager ses];
            response = [ses sendEmail:emailRequest];
        }
        @catch (NSException* ex) {
            result = AMAZON_SERVICE_ERROR;
            NSLog(@"%@", ex);
        }
    }
    return result;
}

+(ErrorCodes) restorePassword:(NSString*)email{
    ErrorCodes result = [Utils validateEmail:email];
    if (result != OK){
        return result;
    }
    
    User* user;
    result = [self retrieveUserPass:&user withEmail:email];
    if (result != OK){
        return result;
    }
    
    if (user.email.length == 0 || user.nickname.length == 0){
        return ERROR;
    }
    
    // user.email is the password
    
    SESContent *messageBody = [[SESContent alloc] init];
    messageBody.data = [NSString stringWithFormat:@"Hello %@,\r\rYou password: %@", user.nickname, user.email];
    
    SESContent *subject = [[SESContent alloc] init];
    subject.data = @"Sapid Chat password restore";
    
    SESBody *body = [[SESBody alloc] init];
    body.text = messageBody;
    
    SESMessage *message = [[SESMessage alloc] init];
    message.subject = subject;
    message.body    = body;
    
    SESDestination *destination = [[SESDestination alloc] init];
    [destination.toAddresses addObject:email];
    
    SESSendEmailRequest *emailRequest = [[SESSendEmailRequest alloc] init];
    emailRequest.source = @"viktor.sydorenko@gmail.com";
    emailRequest.destination = destination;
    emailRequest.message = message;
    
    SESSendEmailResponse *response = nil;
    @try{
        AmazonSESClient *ses = [AmazonClientManager ses];
        response = [ses sendEmail:emailRequest];
    }
    @catch (NSException* ex) {
        result = AMAZON_SERVICE_ERROR;
        NSLog(@"%@", ex);
    }
    
    return result;
}

+(ErrorCodes)retrieveUser:(User**)user withEmail:(NSString*)email{
    *user = nil;
    DynamoDBGetItemResponse *response = nil;
    @try {
        // login
        DynamoDBGetItemRequest *getItemRequest = [[DynamoDBGetItemRequest alloc] init];
        getItemRequest.tableName = DBTABLE_USERS;
        DynamoDBAttributeValue* keyAttr = [[DynamoDBAttributeValue alloc] initWithS:[email lowercaseString]];
        DynamoDBKey *key = [[DynamoDBKey alloc] initWithHashKeyElement: keyAttr];
        getItemRequest.key = key;
        response = [[AmazonClientManager ddb] getItem:getItemRequest];
        //
    }
    @catch (AmazonServiceException *exception) {
        NSLog(@"%@", exception);
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return AMAZON_SERVICE_ERROR;
    }
    if (response.item.count == 0){
        return NO_SUCH_USER;
    }
    *user = [DbItemHelper prepareUser:response.item];
    return OK;
}

+(ErrorCodes)retrieveUserPass:(User**)user withEmail:(NSString*)email{
    *user = nil;
    DynamoDBGetItemResponse *response = nil;
    @try {
        // login
        DynamoDBGetItemRequest *getItemRequest = [[DynamoDBGetItemRequest alloc] init];
        getItemRequest.tableName = DBTABLE_USERS;
        DynamoDBAttributeValue* keyAttr = [[DynamoDBAttributeValue alloc] initWithS:email];
        DynamoDBKey *key = [[DynamoDBKey alloc] initWithHashKeyElement: keyAttr];
        getItemRequest.key = key;
        response = [[AmazonClientManager ddb] getItem:getItemRequest];
        //
    }
    @catch (AmazonServiceException *exception) {
        NSLog(@"%@", exception);
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return AMAZON_SERVICE_ERROR;
    }
    if (response.item.count == 0){
        return NO_SUCH_USER;
    }
    
    DynamoDBAttributeValue *attrVal = (DynamoDBAttributeValue*)[response.item valueForKey:DBFIELD_USERS_EMAIL];
    User* result = [[User alloc] init];
    
    for (NSString* key in response.item.allKeys) {
        attrVal = (DynamoDBAttributeValue*)[response.item valueForKey:key];
        
        if ([key isEqualToString: DBFIELD_USERS_PASSWORD]){
            result.email = attrVal.s; // email field is used as storage
        }
        if ([key isEqualToString: DBFIELD_USERS_NICKNAME]){
            result.nickname = attrVal.s;
        }
    }
    
    *user = result;
    
    return OK;
}

+(NSArray*) getDialogs{
    return [Utils buildDialogsOfMsgs:[self loadAllMessages]];
}

+(ErrorCodes)sendMessage:(Message*)message{
    if (message.text.length == 0 && !message.attachmentData){
        return TEXT_NOT_SPECIFIED;
    }
    if (!message.to){
        return [self sendMessageToBank:message];
    } else {
        return [self sendMessageToCollocutor:message];
    }
}

+(ErrorCodes) pickNewMessage{
    ErrorCodes result = OK;
    Message* msg = nil;
    User* me = [self loadUser:[UserSettings getEmail]];
    
    if (me.languages.count == 0){
        return SYSTEM_CONVERSATION_LANGUAGES_NOT_CONFIGURED;
    }
    
    do {
        int loadedMessageLanguage = -1;
        // load new message from bank
        for (NSNumber* lang in me.languages) {
            result = [self getOneMessageFromBank:me.email inLanguage:lang.intValue message:&msg];
            if (result == SYSTEM_NO_MESSAGES_TO_PICKUP){
                continue;
            } else {
                loadedMessageLanguage = lang.intValue;
                break;
            }
        }
        
        if (result != OK){
            return result;
        }
            
        // delete it from the bank
        result = [self deleteOneMessageFromBank:me.email inLanguage:loadedMessageLanguage rangeKey:msg.when/*carefully*/ deletedMessage:&msg];
        if (result != OK){
            if (result == SYSTEM_NO_SUCH_MESSAGE){
                msg = nil; // continue
            } else {
                return result;
            }
        } else { // deleted OK
            result = [self updateNewMessageInSenderTable:msg];
            if (result != OK){
                return result;
            }
            result = [self placeNewMessageToReceived:msg];
            if (result == OK){
                User* collocutor;
                if ([self retrieveUser:&collocutor withEmail:msg.from] == OK){
                    [self saveUser:collocutor];// retrieve user
                }
            }
        }
    } while (!msg);
    
    return result;
}

+(ErrorCodes) deleteMessage:(Message*)msg{
    ErrorCodes result = OK;
    
    NSString* hashKeyString;
    NSString* table;
    if ([msg.to isEqualToString:[UserSettings getEmail]]){
        hashKeyString = [UserSettings getEmail];
        table = DBTABLE_MSGS_RECEIVED;
    } else if (![msg.to isEqualToString:SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR]){
        hashKeyString = [UserSettings getEmail];
        table = DBTABLE_MSGS_SENT;
    } else {
        //hashKeyString = msg.lang
        return ERROR; // no deletion from the bank yet
    }
    
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:hashKeyString];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", msg.when]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr andRangeKeyElement:rangeKeyAttr];
    
    DynamoDBDeleteItemRequest *delRequest = [[DynamoDBDeleteItemRequest alloc] initWithTableName:table andKey:key];
    DynamoDBDeleteItemResponse *response = nil;
    
    @try {
        response = [[AmazonClientManager ddb] deleteItem:delRequest];
        [[self getDbManager] deleteMessage:msg.when];
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    
    if (!response){
        result = AMAZON_SERVICE_ERROR;
    }
    
    return result;
}

+(ErrorCodes) updateOwnNick:(NSString*)nick{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[UserSettings getEmail]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr];
    
    DynamoDBAttributeValue *attrValue = [[DynamoDBAttributeValue alloc] initWithS:nick];
    DynamoDBAttributeValueUpdate *attrUpdate = [[DynamoDBAttributeValueUpdate alloc] initWithValue:attrValue andAction:@"PUT"];
    
    NSMutableDictionary* updatesDict = [NSMutableDictionary dictionaryWithObject:attrUpdate forKey:DBFIELD_USERS_NICKNAME];
    
    DynamoDBUpdateItemRequest *updateRequest = [[DynamoDBUpdateItemRequest alloc] initWithTableName:DBTABLE_USERS andKey:key andAttributeUpdates:updatesDict];
    [updateRequest setReturnValues:@"UPDATED_NEW"];
    
    DynamoDBUpdateItemResponse *response = nil;
    @try {
        response = [[AmazonClientManager ddb] updateItem:updateRequest];
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    if (response.attributes.count == 0){
        return ERROR;
    }
    if (![[response attributesValueForKey:DBFIELD_USERS_NICKNAME].s isEqualToString:nick]){
        return ERROR;
    }
    return OK;
}

+(ErrorCodes) updateOwnPassword:(NSString*)pass{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[UserSettings getEmail]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr];
    
    DynamoDBAttributeValue *attrValue = [[DynamoDBAttributeValue alloc] initWithS:pass];
    DynamoDBAttributeValueUpdate *attrUpdate = [[DynamoDBAttributeValueUpdate alloc] initWithValue:attrValue andAction:@"PUT"];
    
    NSMutableDictionary* updatesDict = [NSMutableDictionary dictionaryWithObject:attrUpdate forKey:DBFIELD_USERS_PASSWORD];
    
    DynamoDBUpdateItemRequest *updateRequest = [[DynamoDBUpdateItemRequest alloc] initWithTableName:DBTABLE_USERS andKey:key andAttributeUpdates:updatesDict];
    [updateRequest setReturnValues:@"NONE"];
    
    DynamoDBUpdateItemResponse *response = nil;
    @try {
        response = [[AmazonClientManager ddb] updateItem:updateRequest];
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    return OK;
}

+(ErrorCodes)upload:(NSData*)dataToUpload inBucket:(NSString*)bucket forKey:(NSString*)key
{
    bool using3G = ![Utils isWifiAvailable];
    
    @try {	
        S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:key inBucket:bucket];
        
        // The S3UploadInputStream was deprecated after the release of iOS6.
        S3UploadInputStream *stream = [S3UploadInputStream inputStreamWithData:dataToUpload];  
        if (using3G) {
            stream.delay = 0.2; // In seconds
            stream.packetSize = 16; // Number of 1K blocks
        }
        
        por.contentType = @"image/jpeg";
        por.data = dataToUpload;
        //por.stream = stream;
        // sync call on purpose
        // por.delegate =
        
        [[AmazonClientManager s3] putObject:por];
    }
    @catch (AmazonServiceException *exception) {
        NSLog(@"Upload Failed, Reason: %@", exception);
        return AMAZON_SERVICE_ERROR;
    }
    return OK;
}

+(void) requestAttachmentData:(NSString*)attachmentName delegate:(id<AttachmentDataUpdateDelegate>)delegate{
    
}

+(int) getRegularPoststampsCount{
    return [[self getDbManager] getRegularPoststampsCount];
}
+(int) getRegularPoststampsFromLocalBuffer{
    return [[self getDbManager] getRegularPoststampsFromLocalBuffer];
}
+(void) addRegularPoststampsToLocalBuffer:(int)count{
    [[self getDbManager] addRegularPoststampsToLocalBuffer:count];
}
+(int) getTotalAvailablePoststamps{
    return [self getRegularPoststampsCount] + [self getRegularPoststampsFromLocalBuffer];
}

+(ErrorCodes) spendRegularPoststamps:(int)count{
    return [self chargeUsersPoststamps:count];
}

// internal methods

+(NSArray*)loadAllMessages{
    // load and save new messages
    NSMutableArray* messages = [[NSMutableArray alloc] initWithArray:[self loadNewMessages]];
    for (Message* newMsg in messages) {
        [self saveMessage:newMsg];
    }
    
    // return messages from the local store
    return [[self getDbManager] loadMessagesWithCondition:@""];
}

+(NSArray*) loadNewMessages{
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    
    DynamoDBAttributeValue* hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[UserSettings getEmail]];
    DynamoDBAttributeValue* rangeKeyAttrIncome = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", [self getLastInMessageTimestamp]]];
    DynamoDBAttributeValue* rangeKeyAttrOutgoing = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", [self getLastOutMessageTimestamp]]];
    
    DynamoDBQueryRequest* request;
    DynamoDBQueryResponse* response = nil;
        
    DynamoDBCondition* conditionIn = [[DynamoDBCondition alloc] init];
    conditionIn.comparisonOperator = @"GT";
    [conditionIn addAttributeValueList:rangeKeyAttrIncome];
    
    DynamoDBCondition* conditionOut = [[DynamoDBCondition alloc] init];
    conditionOut.comparisonOperator = @"GT";
    [conditionOut addAttributeValueList:rangeKeyAttrOutgoing];
    
    @try {
        // sent messages
        request  = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andHashKeyValue:hashKeyAttr];
        request.rangeKeyCondition = conditionOut;
        response = [[AmazonClientManager ddb] query:request];
        //int consumedUnits = response.consumedCapacityUnits.intValue;
        if (response){
            for (NSDictionary* item in response.items) {
                [messages addObject:[DbItemHelper prepareMessage:item]];
            }
            response = nil;
        }
     
        // received messages
        request  = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_RECEIVED andHashKeyValue:hashKeyAttr];
        request.rangeKeyCondition = conditionIn;
        response = [[AmazonClientManager ddb] query:request];
        if (response){
            for (NSDictionary* item in response.items) {
                [messages addObject:[DbItemHelper prepareMessage:item]];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"SapidChat :: Exception getting dialogs: %@", exception);
    }
    return messages;
}

+(ErrorCodes) sendMessageToBank:(Message*) msg{
    if (![msg.from isEqualToString:[UserSettings getEmail]]){
        return ERROR;
    }
    NSString* attName = msg.attachmentName;
    if (msg.text.length == 0 && attName.length == 0){
        return ERROR;
    }
    
    int timestamp =  [Utils toGlobalTimestamp:msg.when];
    msg.when = timestamp;
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    if (msg.text && msg.text.length > 0){
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.text] forKey:DBFIELD_MSGS_TEXT];
    }
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.from] forKey:DBFIELD_MSGS_FROM];
    
    if (attName.length > 0){
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:attName] forKey:DBFIELD_MSGS_ATT];
    }
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", msg.type]] forKey:DBFIELD_MSGS_TYPE];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", timestamp]] forKey:DBFIELD_MSGS_WHEN];
    
    // TODO: do it in a batch!
    @try {
        // add to sent messages table
        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andItem:msgDic];
        DynamoDBPutItemResponse *response = nil;
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
        response = nil;
        
        // add to the bank table
        int newMsgLang = [UserSettings getNewMessagesLanguage];
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", newMsgLang]] forKey:DBFIELD_MSGS_BANK_LANG];
        if (msg.latitude != 0 || msg.longitude != 0){
            [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%.10f", msg.latitude]] forKey:DBFIELD_MSGS_LATD];
            [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%.10f", msg.longitude]] forKey:DBFIELD_MSGS_LOND];
        }
        
        request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andItem:msgDic];
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
        if (msg.attachmentData.length > 0){
            [self upload:msg.attachmentData inBucket:ATTACHMENTS_BUCKET_NAME forKey:msg.attachmentName];
        }
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }

    msg.to = SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR;
    [DataManager saveMessage:msg];
    
    return OK;
}

+(ErrorCodes) sendMessageToCollocutor:(Message*)message{
    if (![message.from isEqualToString:[UserSettings getEmail]]){
        return ERROR;
    }
    NSString* attName = message.attachmentName;
    int timestamp =  [Utils toGlobalTimestamp:message.when];
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    if (message.text && message.text.length > 0){
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.text] forKey:DBFIELD_MSGS_TEXT];
    }
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.from] forKey:DBFIELD_MSGS_FROM];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.to] forKey:DBFIELD_MSGS_TO];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", message.type]] forKey:DBFIELD_MSGS_TYPE];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", timestamp]] forKey:DBFIELD_MSGS_WHEN];
    if (attName.length > 0){
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:message.attachmentName] forKey:DBFIELD_MSGS_ATT];
    }
    
    // TODO: do it in a batch!
    @try {
        // add to sent messages table
        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andItem:msgDic];
        DynamoDBPutItemResponse *response = nil;
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
        response = nil;
        
        // add to the collocutor's received table
        if (message.initial_message_global_timestamp > 0){
            DynamoDBAttributeValue *n = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", message.initial_message_global_timestamp]];
            [msgDic setObject:n forKey:DBFIELD_MSGS_INITIAL_MSG];
        }
        if (message.latitude != 0 || message.longitude != 0){
            [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%.10f", message.latitude]] forKey:DBFIELD_MSGS_LATD];
            [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%.10f", message.longitude]] forKey:DBFIELD_MSGS_LOND];
        }
        
        request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_RECEIVED andItem:msgDic];
        
        response = [[AmazonClientManager ddb] putItem:request];
        if (!response){
            return AMAZON_SERVICE_ERROR;
        }
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    
    message.when = timestamp; 
    [DataManager saveMessage:message];
    
    return OK;
}

+(ErrorCodes) getOneMessageFromBank:(NSString*)me inLanguage:(int)lang message:(Message**)pickedUpMsg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", lang]];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:@"0"];
    
    DynamoDBQueryRequest* queryRequest = nil;
    DynamoDBQueryResponse* queryResponse = nil;
    
    DynamoDBCondition* condition = nil;
    
    // query one entry from the bank table
    queryRequest = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andHashKeyValue:hashKeyAttr];
    queryRequest.limit = [NSNumber numberWithInt:1];
    
    do {
        condition = [[DynamoDBCondition alloc] init];
        condition.comparisonOperator = @"GT";
        [condition addAttributeValueList:rangeKeyAttr];
        queryRequest.rangeKeyCondition = condition;
        
        @try {
            queryResponse = [[AmazonClientManager ddb] query:queryRequest];
        }
        @catch (NSException *exception) {
            return AMAZON_SERVICE_ERROR;
        }
        
        if (!queryResponse){
            return ERROR;
        }
        if (queryResponse.items.count == 0){
            return SYSTEM_NO_MESSAGES_TO_PICKUP;
        }
        
        *pickedUpMsg = [DbItemHelper prepareMessage:[queryResponse.items objectAtIndex:0]];
        NSString* from = (*pickedUpMsg).from;
        if (![from isEqualToString:me] && ![self loadUser:from]){ // not interested in own messages and in messages of already existing users
            return OK;
        } else { // if own message loaded then re-run query with new start point and condition
            rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", (*pickedUpMsg).when]];
            condition = nil;
        }
    } while (!condition); // can be just while(YES)
}

+(ErrorCodes) deleteOneMessageFromBank:(NSString*)me inLanguage:(int)lang rangeKey:(int)when deletedMessage:(Message**)deletedMsg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", lang]];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", when]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr andRangeKeyElement:rangeKeyAttr];
    
    DynamoDBDeleteItemResponse *response = nil;
    
    DynamoDBDeleteItemRequest *delRequest = [[DynamoDBDeleteItemRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andKey:key];
    [delRequest setReturnValues:@"ALL_OLD"];
    @try{
        response = [[AmazonClientManager ddb] deleteItem:delRequest];
    }
    @catch(NSException *exception){
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    if (response.attributes.count == 0){
        return SYSTEM_NO_SUCH_MESSAGE;
    }
    *deletedMsg = [DbItemHelper prepareMessage:response.attributes];
    // results customizations:
    (*deletedMsg).to = me;
    
    return OK;
}

// me = msg.to
+(ErrorCodes) placeNewMessageToReceived:(Message*)msg{
    int timestamp = msg.when;
    
    NSMutableDictionary* msgDic = [[NSMutableDictionary alloc] init];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.text] forKey:DBFIELD_MSGS_TEXT];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.from] forKey:DBFIELD_MSGS_FROM];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.to] forKey:DBFIELD_MSGS_TO];
    if (msg.latitude != 0 || msg.longitude != 0){
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%.10f", msg.latitude]] forKey:DBFIELD_MSGS_LATD];
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%.10f", msg.longitude]] forKey:DBFIELD_MSGS_LOND];
    }
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", msg.type]] forKey:DBFIELD_MSGS_TYPE];
    [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", timestamp]] forKey:DBFIELD_MSGS_WHEN];
    if (msg.attachmentName && msg.attachmentName.length > 0){
        [msgDic setObject:[[DynamoDBAttributeValue alloc] initWithS:msg.attachmentName] forKey:DBFIELD_MSGS_ATT];
    }
    
    @try {
        DynamoDBPutItemRequest *request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_RECEIVED andItem:msgDic];
        DynamoDBPutItemResponse *response = [[AmazonClientManager ddb] putItem:request];;
        if (!response){
            return ERROR;
        }
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    
    return OK;
}

// sender = msg.from
+(ErrorCodes) updateNewMessageInSenderTable:(Message*)msg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:msg.from];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", msg.when]];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr andRangeKeyElement:rangeKeyAttr];
    
    DynamoDBAttributeValue *attrValue = [[DynamoDBAttributeValue alloc] initWithS:msg.to];
    DynamoDBAttributeValueUpdate *attrUpdate = [[DynamoDBAttributeValueUpdate alloc] initWithValue:attrValue andAction:@"PUT"];
    
    NSMutableDictionary* updatesDict = [NSMutableDictionary dictionaryWithObject:attrUpdate forKey:DBFIELD_MSGS_TO];
    
    DynamoDBUpdateItemRequest *updateRequest = [[DynamoDBUpdateItemRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andKey:key andAttributeUpdates:updatesDict];
    [updateRequest setReturnValues:@"UPDATED_NEW"];
    
    DynamoDBUpdateItemResponse *response = nil;
    @try {
        response = [[AmazonClientManager ddb] updateItem:updateRequest];
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    if (response.attributes.count == 0){
        return SYSTEM_NO_SUCH_MESSAGE;
    }
    /*if ([response attributesValueForKey:DBFIELD_MSGS_TO].s != msg.to){
     return ERROR;
     }*/    
    return OK;
}

+(ErrorCodes) chargeUsersPoststamps:(int)amount{
    User* user;
    
    ErrorCodes retrieveUser = [self retrieveUser:&user withEmail:[UserSettings getEmail]];
    if (retrieveUser != OK){
        return retrieveUser;
    }
    [self saveUser:user]; // update local poststamps
    int newValue = user.rp - amount;
    if (newValue < 0){
        return POSTSTAMPS_NOT_ENOUGH;
    }
    
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:user.email];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr];
    
    DynamoDBAttributeValue *attrValue = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", newValue]];
    DynamoDBAttributeValueUpdate *attrUpdate = [[DynamoDBAttributeValueUpdate alloc] initWithValue:attrValue andAction:@"PUT"];
    
    NSMutableDictionary* updatesDict = [NSMutableDictionary dictionaryWithObject:attrUpdate forKey: DBFIELD_USERS_RP];
    
    DynamoDBUpdateItemRequest *updateRequest = [[DynamoDBUpdateItemRequest alloc] initWithTableName:DBTABLE_USERS andKey:key andAttributeUpdates:updatesDict];
    [updateRequest setReturnValues:@"NONE"];
    
    DynamoDBUpdateItemResponse *response = nil;
    @try {
        response = [[AmazonClientManager ddb] updateItem:updateRequest];
    }
    @catch (NSException *exception) {
        return AMAZON_SERVICE_ERROR;
    }
    if (!response){
        return ERROR;
    }
    /*if (response.attributes.count == 0){
        return SYSTEM_NO_SUCH_MESSAGE;
    }*/
    /*if ([response attributesValueForKey:DBFIELD_MSGS_TO].s != msg.to){
     return ERROR;
     }*/    
    return OK;
}

@end
