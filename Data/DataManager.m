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
#import "Lang.h"

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

+(int) getUnreadMessagesCountForCollocutor:(NSString*)user{
    return [[self getDbManager] getUnreadMessagesCountForCollocutor:user];
}

+(void) resetUnreadMessagesCountForCollocutor:(NSString*)email{
    [[self getDbManager] resetUnreadMessagesCountForCollocutor:email];
}

+(void) saveUser:(User*)user{
    [[self getDbManager] saveUser:user];
}

+(void) deleteUser:(NSString*)user{
    [[self getDbManager] deleteUser:user];
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
    DynamoDBAttributeValue* keyAttr = [[DynamoDBAttributeValue alloc] initWithS:[email lowercaseString]];
    DynamoDBKey *key = [[DynamoDBKey alloc] initWithHashKeyElement: keyAttr];
    getItemRequest.key = key;
    DynamoDBGetItemResponse *response = nil;
    @try {
        response = [[AmazonClientManager ddb] getItem:getItemRequest];
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return NO;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return NO;
    }
    return response.item.count != 0;
}

+(ErrorCodes) registerNewUser:(User*)user password:(NSString*)password{
    if ([DataManager existsUserWithEmail:user.email]){
        return USER_EXISTS;
    }
    @try
    {
        NSMutableDictionary* userDic = [[NSMutableDictionary alloc] init];
        
        [userDic setObject:[[DynamoDBAttributeValue alloc] initWithS:[user.email lowercaseString]] forKey:DBFIELD_USERS_EMAIL];
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
    }
    @catch (AmazonServiceException *exception) {
        NSLog(@"SapidChat :: Exception registering user: %@", exception);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException* exception) {
        NSLog(@"%@", exception);
        return ERROR;
    }
    return OK;
}

+(ErrorCodes)login:(NSString*)email password:(NSString*)password{
    NSString* lowEmail = [email lowercaseString];
    ErrorCodes result = [Utils validateEmail:lowEmail];
    if (result == OK){
        User* user = nil;
        result = [self retrieveUser:&user withEmail:lowEmail];
        if (result == OK){
            if ([password isEqualToString:[AmazonKeyChainWrapper getValueFromKeyChain:user.email]]){
                [UserSettings setEmail:lowEmail];
                [AmazonKeyChainWrapper storeValueInKeyChain:password forKey:lowEmail];
                [[self getDbManager] saveUser:user];
                [self setNewMessageLanguageFromUserLanguages:user.languages];
            } else {
                result = WRONG_PASSWORD;
            }
        }
    }
    return result;
}

+(NSString*) prepareIntrigueHtmlContentTo:(NSString*)email inLanguage:(int)lang withOptionText:(NSString*)text{
    Class mailLanguageClass = [Lang getLangClassForLanguage:lang];
    
    NSString* escapeHTML1 = [text stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    NSString* escapeHTML = [escapeHTML1 stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    NSString* content = escapeHTML.length > 0 ? [NSString stringWithFormat:[mailLanguageClass LOC_INTRIGUE_MAIL_CONTENT_CUSTOM], escapeHTML] : [mailLanguageClass LOC_INTRIGUE_MAIL_CONTENT_DEFAULT];
    if ([email isEqualToString:[UserSettings getEmail]]){
        NSString* contentYourself = escapeHTML.length > 0 ? [NSString stringWithFormat:[mailLanguageClass LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF], content, escapeHTML] : [NSString stringWithFormat:[mailLanguageClass LOC_INTRIGUE_MAIL_CONTENT_YOURSELF], content];
        content = contentYourself;
    }
    
    return [NSString stringWithFormat:@"<html><head><meta http-equiv=\"Content-Type\"content=\"text/html; charset=UTF-16\"/></head><body style=\"font-family:Arial;font-size:11pt;background-color:#F7E8C3;\">%@</body></html>", content];
}

+(ErrorCodes) sendIntrigueTo:(NSString*)email inLanguage:(int)lang withOptionalText:(NSString*)text{
    Class mailLanguageClass = [Lang getLangClassForLanguage:lang];
    
    SESContent *messageBody = [[SESContent alloc] init];
    messageBody.data = [self prepareIntrigueHtmlContentTo:email inLanguage:lang withOptionText:text];
        
    SESBody *body = [[SESBody alloc] init];
    body.html = messageBody;
    
    SESContent *subject = [[SESContent alloc] init];
    subject.data = [mailLanguageClass LOC_INTRIGUE_MAIL_SUBJECT];
    
    SESMessage *message = [[SESMessage alloc] init];
    message.subject = subject;
    message.body    = body;
        
    SESDestination *destination = [[SESDestination alloc] init];
    [destination.toAddresses addObject:email];
    
    SESSendEmailRequest *emailRequest = [[SESSendEmailRequest alloc] init];
    emailRequest.source = SYSTEM_INTRIGUE_USER;
    emailRequest.destination = destination;
    emailRequest.message = message;
    
    Message* msg = [[Message alloc] init];
    msg.from = [UserSettings getEmail];
    msg.to = email;
    msg.text = [mailLanguageClass LOC_INTRIGUE_COLLOCUTOR_MESSAGE];
    msg.type = MSG_INTRIGUE;
    msg.when = [[NSDate date] timeIntervalSinceReferenceDate];
    
    bool toYourself = [email isEqualToString:[UserSettings getEmail]];
    ErrorCodes result = toYourself ? OK : [self sendMessageToCollocutor:msg]; // will not send to the same address no need to check it here
    if (result == OK){
        SESSendEmailResponse *response = nil;
        @try{
            AmazonSESClient *ses = [AmazonClientManager ses];
            response = [ses sendEmail:emailRequest];
        }
        @catch (AmazonServiceException* ex) {
            NSLog(@"%@", ex);
            return AMAZON_SERVICE_ERROR;
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
            return ERROR;
        }
        
        // now send custom message to AWS
        if (!toYourself && text.length > 0){
            msg.text = text;
            msg.type = MSG_REGULAR;
            msg.when = [[NSDate date] timeIntervalSinceReferenceDate];
            [self sendMessageToCollocutor:msg];
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
    messageBody.data = [NSString stringWithFormat:[Lang LOC_RESTORE_EMAIL_TEMPL], user.nickname, user.email];
    
    SESContent *subject = [[SESContent alloc] init];
    subject.data = [Lang LOC_RESTORE_SCREEN_TITLE];
    
    SESBody *body = [[SESBody alloc] init];
    body.text = messageBody;
    
    SESMessage *message = [[SESMessage alloc] init];
    message.subject = subject;
    message.body    = body;
    
    SESDestination *destination = [[SESDestination alloc] init];
    [destination.toAddresses addObject:email];
    
    SESSendEmailRequest *emailRequest = [[SESSendEmailRequest alloc] init];
    emailRequest.source = SYSTEM_USER;
    emailRequest.destination = destination;
    emailRequest.message = message;
    
    SESSendEmailResponse *response = nil;
    @try{
        AmazonSESClient *ses = [AmazonClientManager ses];
        response = [ses sendEmail:emailRequest];
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        result = AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        result = ERROR;
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
        [DbItemHelper prepareUser:response.item];
        //
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
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

+(NSArray*) getAllDialogs{
    return [Utils buildDialogsOfMsgs:[self loadAllMessages]];
}

+(NSArray*) getSavedDialogs{
    return [Utils buildDialogsOfMsgs:[[self getDbManager] loadMessagesWithCondition:@""]];
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
                    [self saveUser:collocutor];
                }
            }
            
            Message* reportMsg = [[Message alloc] init];
            reportMsg.from = me.email;
            reportMsg.to = msg.from;
            reportMsg.text = [NSString stringWithFormat:[Lang LOC_MESSAGES_REPORT_PICKED_UP], me.nickname];
            reportMsg.when = [[NSDate date] timeIntervalSinceReferenceDate];
            reportMsg.type = MSG_REPORT;
            reportMsg.initial_message_global_timestamp = msg.when;
            [self sendMessageToCollocutor:reportMsg];
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
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

+(void) updateOwnLanguagesInAWS{
    User* me = [self loadUser:[UserSettings getEmail]];
    
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:me.email];
    DynamoDBKey* key = [[DynamoDBKey alloc] initWithHashKeyElement:hashKeyAttr];
    
    NSMutableArray* langs = [[NSMutableArray alloc] init];
    for (NSNumber* lang in me.languages) {
        [langs addObject:lang.stringValue];
    }
    DynamoDBAttributeValue* attrValue = [[DynamoDBAttributeValue alloc] initWithNS:langs];
    
    DynamoDBAttributeValueUpdate *attrUpdate = [[DynamoDBAttributeValueUpdate alloc] initWithValue:attrValue andAction:@"PUT"];
    
    NSMutableDictionary* updatesDict = [NSMutableDictionary dictionaryWithObject:attrUpdate forKey:DBFIELD_USERS_LANGS];
    
    DynamoDBUpdateItemRequest *updateRequest = [[DynamoDBUpdateItemRequest alloc] initWithTableName:DBTABLE_USERS andKey:key andAttributeUpdates:updatesDict];
    [updateRequest setReturnValues:@"NONE"];
    
    
    dispatch_queue_t refreshQueue = dispatch_queue_create("update lang Queue", NULL);
    dispatch_async(refreshQueue, ^{
        @try {
            [[AmazonClientManager ddb] updateItem:updateRequest];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
    });
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
    }
    if (!response){
        return ERROR;
    }
    return OK;
}

+(ErrorCodes)upload:(NSData*)dataToUpload inBucket:(NSString*)bucket forKey:(NSString*)key
{
    @try {	
        S3PutObjectRequest *putObjectRequest = [[S3PutObjectRequest alloc] initWithKey:key inBucket:bucket];
        
        putObjectRequest.contentType = @"image/jpeg";
        putObjectRequest.data = dataToUpload;
        // sync call on purpose
        // por.delegate =
        
        [[AmazonClientManager s3] putObject:putObjectRequest];
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"Upload failed: %@", exception);
        return ERROR;
    }
    return OK;
}

+(void) requestAttachmentData:(NSString*)attachmentName delegate:(id<AttachmentDataUpdateDelegate>)delegate{
    S3GetObjectRequest* getObjectRequest = [[S3GetObjectRequest alloc] initWithKey:attachmentName withBucket:ATTACHMENTS_BUCKET_NAME];
    getObjectRequest.delegate = [self getDbManager];
        
    [self getDbManager].attachmentUpdateDelegate = delegate;

    @try {
        [[AmazonClientManager s3] getObject:getObjectRequest];
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"Attachment request failed: %@", ex);
    }
    @catch (NSException *exception) {
        NSLog(@"Attachment request failed: %@", exception);
    }
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
    NSString* me = [UserSettings getEmail];
    User *collocutor = nil;
    NSMutableArray* messages = [[NSMutableArray alloc] initWithArray:[self loadNewMessages]];
    for (Message* newMsg in messages) {
        [self saveMessage:newMsg];
        // if this in an income message and the user is not saved in the local db yet - save them
        if (![newMsg.from isEqualToString:me]){
            if ([self retrieveUser:&collocutor withEmail:newMsg.from] == OK){
                [self saveUser:collocutor];
                collocutor = nil;
            }
        }
    }
    
    // return messages from the local store
    return [[self getDbManager] loadMessagesWithCondition:@""];
}

+(NSArray*) loadNewMessages{
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    
    DynamoDBAttributeValue* hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[UserSettings getEmail]];
    DynamoDBAttributeValue* hashKeySysAttr = [[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", [UserSettings getAppLanguage]]];
    
    DynamoDBAttributeValue* rangeKeyAttrIncome = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", [self getLastInMessageTimestamp]]];
    DynamoDBAttributeValue* rangeKeyAttrOutgoing = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", [self getLastOutMessageTimestamp]]];
    DynamoDBAttributeValue* rangeKeyAttrSystemLow = [[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%d", 1+[[self getDbManager] getMaxInSystemMessageTimestamp]]];
    DynamoDBAttributeValue* rangeKeyAttrSystemTop = [[DynamoDBAttributeValue alloc] initWithN:@"1000"];

    DynamoDBQueryRequest* request;
    DynamoDBQueryResponse* response = nil;

    DynamoDBCondition* conditionIn = [[DynamoDBCondition alloc] init];
    conditionIn.comparisonOperator = @"GT";
    [conditionIn addAttributeValueList:rangeKeyAttrIncome];

    DynamoDBCondition* conditionOut = [[DynamoDBCondition alloc] init];
    conditionOut.comparisonOperator = @"GT";
    [conditionOut addAttributeValueList:rangeKeyAttrOutgoing];
    
    DynamoDBCondition* conditionSys = [[DynamoDBCondition alloc] init];
    conditionSys.comparisonOperator = @"BETWEEN";
    [conditionSys addAttributeValueList:rangeKeyAttrSystemLow];
    [conditionSys addAttributeValueList:rangeKeyAttrSystemTop];

    @try {
        // sent messages
        request  = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andHashKeyValue:hashKeyAttr];
        request.rangeKeyCondition = conditionOut;
        response = [[AmazonClientManager ddb] query:request];
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
        
        // system messages in bank table
        request  = [[DynamoDBQueryRequest alloc] initWithTableName:DBTABLE_MSGS_BANK andHashKeyValue:hashKeySysAttr];
        request.rangeKeyCondition = conditionSys;
        response = [[AmazonClientManager ddb] query:request];
        if (response){
            Message *tmpMsg;
            for (NSDictionary* item in response.items) {
                tmpMsg = [DbItemHelper prepareMessage:item];
                tmpMsg.to = [UserSettings getEmail];
                [messages addObject:tmpMsg];
            }
            response = nil;
        }
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"Getting dialogs error: %@", ex);
    }
    @catch (NSException *exception) {
        NSLog(@"Getting dialogs error: %@", exception);
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"Placing to bank failed: %@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"Placing to bank failed: %@", exception);
        return ERROR;
    }

    msg.to = SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR;
    [DataManager saveMessage:msg];
    
    return OK;
}

+(ErrorCodes) sendMessageToCollocutor:(Message*)message{
    if (![message.from isEqualToString:[UserSettings getEmail]]){
        return ERROR;
    }
    if ([message.to isEqualToString:[UserSettings getEmail]]){
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
        DynamoDBPutItemRequest *request;
        DynamoDBPutItemResponse *response = nil;
        // add to sent messages table
        if (message.type != MSG_REPORT){ // reporting messages such as notification about picked messages are not stored in sent table
            request = [[DynamoDBPutItemRequest alloc] initWithTableName:DBTABLE_MSGS_SENT andItem:msgDic];
        
            response = [[AmazonClientManager ddb] putItem:request];
            if (!response){
                return AMAZON_SERVICE_ERROR;
            }
            response = nil;
        }
        
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"Sending to collocutor failed: %@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"Sending to collocutor failed: %@", exception);
        return ERROR;
    }
    if (message.attachmentData.length > 0){
        [self upload:message.attachmentData inBucket:ATTACHMENTS_BUCKET_NAME forKey:message.attachmentName];
    }
    
    if (message.type != MSG_REPORT){
        message.when = timestamp;
        [DataManager saveMessage:message];
    }
    return OK;
}

+(ErrorCodes) getOneMessageFromBank:(NSString*)me inLanguage:(int)lang message:(Message**)pickedUpMsg{
    DynamoDBAttributeValue *hashKeyAttr = [[DynamoDBAttributeValue alloc] initWithS:[NSString stringWithFormat:@"%d", lang]];
    DynamoDBAttributeValue *rangeKeyAttr = [[DynamoDBAttributeValue alloc] initWithN:@"1000"]; // 0 - 1000 reserved for system notifications
    
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"Deletion from bank failed: %@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"Deletion from bank failed: %@", exception);
        return ERROR;
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"Placing to received failed: %@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"Placing to received failed: %@", exception);
        return ERROR;
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
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
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
    }
    if (!response){
        return ERROR;
    }
    
    return OK;
}

+(ErrorCodes) topUpUsersPoststamps:(int)count{
    User* user;
    
    ErrorCodes retrieveUser = [self retrieveUser:&user withEmail:[UserSettings getEmail]];
    if (retrieveUser != OK){
        return retrieveUser;
    }
    [self saveUser:user]; // update local poststamps
    int newValue = user.rp + count;
    
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
    
        if ([self retrieveUser:&user withEmail:[UserSettings getEmail]] == OK){
            [self saveUser:user]; // update local poststamps once again after topping up
        }
    }
    @catch (AmazonServiceException* ex) {
        NSLog(@"%@", ex);
        return AMAZON_SERVICE_ERROR;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return ERROR;
    }
    if (!response){
        return ERROR;
    }
    
    return OK;
}


@end
