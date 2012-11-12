//
//  DbHelper.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/26/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "DbManager.h"
#import "DBDefinition.h"
#import "sqlite3.h"
#import "Message.h"
#import "UserSettings.h"

@implementation DbManager{
    sqlite3 *sapidDb;
}

-(id) init{
    self = [super init];
    if (self){
        [self initDatabase];
    }
    return self;
}

-(void) open{
    [self initDatabase];
}

-(void) close{
    sqlite3_close(sapidDb);
}

-(void) initDatabase{
    // Get the documents directory
    NSArray* dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: DATABASE_NAME]];
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &sapidDb) == SQLITE_OK)
    {
        char *errMsg;
        DBDefinition* dbDef = [[DBDefinition alloc] init];
        const char *sql = [[dbDef getTablesCreationSQL] UTF8String];
        if (sqlite3_exec(sapidDb, sql, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Error creating DB table(s)");
        }
    } else {
        NSLog(@"Failed to open/create database");
    }
    
}

-(int) getUserDbId:(NSString*)userEmail{
    NSString *querySQL = [NSString stringWithFormat: @"SELECT %@ FROM %@ WHERE %@=\"%@\"", F_ID, T_USERS, F_EMAIL, userEmail];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString *idField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            return idField.intValue;
        }
        sqlite3_finalize(statement);
    }
    return -1;
}

// public methods
-(void) saveUser:(User*)user{ // user specific method
    User* exists = [self loadUser:user.email];
    NSString* languages = [self buildLanguagesString:user.languages];
    NSString* sql;
    NSString *logMsg = @"";
    if (exists){ // already exists so update
        sql = [NSString stringWithFormat: @"UPDATE %@ SET %@ = \"%@\", %@ = \"%@\", %@ = %d, %@ = %d WHERE %@ =\"%@\" AND %@ = \"%@\"", T_USERS, F_NICK, user.nickname, F_LANGS, languages, F_RP, user.rp, F_BP, user.bp, F_EMAIL, user.email, F_AUTHOR, [UserSettings getEmail]];
        logMsg = @"User updated!!!";
    } else { // doesnt exist so insert
        sql = [NSString stringWithFormat: @"INSERT INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %d, %d, 0, 0)", T_USERS, F_AUTHOR, F_EMAIL, F_NICK, F_LANGS, F_RP, F_BP, F_RP_BUF, F_BP_BUF, [UserSettings getEmail], user.email, user.nickname, languages, user.rp, user.bp];
        logMsg = @"User inserted!!!";
    }
    const char *insert_stmt = [sql UTF8String];
    
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(sapidDb, insert_stmt, -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"%@", logMsg);
    } else {
        NSLog(@"Failed to save user");
    }
    sqlite3_finalize(statement);
}

-(User*) loadUser:(NSString*)email{ // user specific method
    NSString *querySQL = [NSString stringWithFormat: @"SELECT %@, %@ FROM %@ WHERE %@=\"%@\" AND %@=\"%@\"", F_NICK, F_LANGS, T_USERS, F_AUTHOR, [UserSettings getEmail], F_EMAIL, email];
    const char *query_stmt = [querySQL UTF8String];
    
    User* user = nil;
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            //NSLog(@"User found");
            user = [[User alloc] init];
            user.email = email;
            
            NSString *nickField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            user.nickname = nickField;
            
            NSString *langsField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            NSMutableArray* langNumbers = [[NSMutableArray alloc] init];
            if (langsField.length > 0){
                NSArray* langStrings = [langsField componentsSeparatedByString: USER_LANGS_SEPARATOR];
                for (NSString* lang in langStrings) {
                    [langNumbers addObject:[NSNumber numberWithInt:lang.intValue]];
                }
                user.languages = langNumbers;
            }
        } else {
            NSLog(@"User not found in the database");
        }
    }
    sqlite3_finalize(statement);
    
    return user;
}

-(void) setMsgLanguages:(NSArray*)languages forUser:(NSString*)email{ // user specific method
    NSString* langsString = [self buildLanguagesString:languages];
    NSString* querySQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ = \"%@\" WHERE \"%@\" = \"%@\"", T_USERS, F_LANGS, langsString, F_EMAIL, [UserSettings getEmail]];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
        } else {
            NSLog(@"Error updating message (set collocutor)");
        }
    }
}

-(void) saveMessage:(Message*)msg{ // user specific method
    BOOL isNew = [[UserSettings getEmail] isEqualToString:msg.to];
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO %@ (%@, %@, %@, %@, %@, %@) VALUES (\"%@\", \"%@\", \"%@\", %d, \"%@\", %d)", T_MSGS, F_AUTHOR, F_FROM, F_TO, F_WHEN, F_TEXT, F_UNREAD, [UserSettings getEmail], msg.from, msg.to, msg.when, msg.text, isNew];
    const char *insert_stmt = [insertSQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, insert_stmt, -1, &statement, NULL) == SQLITE_OK){
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
}

-(void) deleteMessage:(int)whenCreated{ // user specific method
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %d AND %@ = \"%@\"",T_MSGS, F_WHEN, whenCreated, F_AUTHOR, [UserSettings getEmail]];
    const char *delete_stmt = [deleteSQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, delete_stmt, -1, &statement, NULL) == SQLITE_OK){
        if (sqlite3_step(statement) == SQLITE_DONE){
        } else {
            NSLog(@"Error deleting message from database");
        }
    }
    sqlite3_finalize(statement);
}

-(NSArray*) loadMessagesWithCondition:(NSString*)condition{ // user specific method
    NSString* cond = condition.length > 0 ? [NSString stringWithFormat:@" AND %@", condition] : @"";
    NSString *querySQL = [NSString stringWithFormat: @"SELECT %@, %@, %@, %@ FROM %@ WHERE %@=\"%@\" %@", F_FROM, F_TO, F_WHEN, F_TEXT, T_MSGS, F_AUTHOR, [UserSettings getEmail], cond];
    const char *query_stmt = [querySQL UTF8String];
    
    NSMutableArray* msgs = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            Message* msg = [[Message alloc] init];
            
            NSString *fromField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            msg.from = fromField;
            
            NSString *toField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            msg.to = toField;
            
            msg.when = sqlite3_column_int(statement, 2);
            
            NSString *textField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
            msg.text = textField;
            
            [msgs addObject:msg];
        }
    }
    sqlite3_finalize(statement);
    
    return [[NSArray alloc] initWithArray:msgs];
}

-(void)setCollocutor:(NSString*)collocutor forExistingMessage:(int)globalInitialMessagesTimestamp{
    NSString* querySQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ = \"%@\" WHERE %@ = %d", T_MSGS, F_TO, collocutor, F_WHEN, globalInitialMessagesTimestamp];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
        } else {
            NSLog(@"Error updating message (set collocutor)");
        }
    }
}

-(int) getLastInMessageTimestamp{ // user specific method
    NSString *querySQL = [NSString stringWithFormat: @"SELECT MAX(%@) FROM %@ WHERE %@=\"%@\" AND %@=\"%@\"", F_WHEN, T_MSGS, F_AUTHOR, [UserSettings getEmail], F_TO, [UserSettings getEmail]];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            return sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
    }
    return 0;
}

-(int) getLastOutMessageTimestamp{ // user specific method
    NSString *querySQL = [NSString stringWithFormat: @"SELECT MAX(%@) FROM %@ WHERE %@=\"%@\" AND %@=\"%@\"", F_WHEN, T_MSGS, F_AUTHOR, [UserSettings getEmail], F_FROM, [UserSettings getEmail]];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            return sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
    }
    return 0;
}

-(int) getUnreadMessagesCount{
    NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM %@ WHERE %@=\"%@\" AND %@=1", T_MSGS, F_AUTHOR, [UserSettings getEmail], F_UNREAD];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString *countField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            return countField.intValue;
        }
        sqlite3_finalize(statement);
    }
    return -1;
}

-(void) resetUnreadMessagesCountForCollocutor:(NSString*)email{ // User specific method
    NSString* querySQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ = 0 WHERE %@=\"%@\" AND %@=\"%@\"", T_MSGS, F_UNREAD, F_AUTHOR, [UserSettings getEmail], F_TO, [UserSettings getEmail]];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
        } else {
            NSLog(@"Error resetting unread flag of messages with collocutor)");
        }
    }
}

-(int) getRegularPoststampsCount{ // user specific method
    return [self getPoststampsCount:NO buffer:NO];
}

-(int) getBonusPoststampsCount{ // user specific method
    return [self getPoststampsCount:YES buffer:NO];
}

-(int) getRegularPoststampsFromLocalBuffer{ // user specific method
    return [self getPoststampsCount:NO buffer:YES];
}

-(int) getBonusPoststampsFromLocalBuffer{ // user specific method
    return [self getPoststampsCount:YES buffer:YES];
}

-(void) addRegularPoststamps:(int)count{ // user specific method
    [self addPoststamps:count bonus:NO toBuffer:NO];
}

-(void) addBonusPoststamps:(int)count{ // user specific method
    [self addPoststamps:count bonus:YES toBuffer:NO];
}

-(void) addRegularPoststampsToLocalBuffer:(int)count{ // user specific method
    [self addPoststamps:count bonus:NO toBuffer:YES];
}

-(void) addBonusPoststampsToLocalBuffer:(int)count{ // user specific method
    [self addPoststamps:count bonus:YES toBuffer:YES];
}

// private methods

-(NSString*) buildLanguagesString:(NSArray*)langs{
    NSString* languages = @"";
    for (NSNumber* lang in langs) {
        languages = [languages stringByAppendingFormat:@"%@%@",(languages.length>0?USER_LANGS_SEPARATOR:@""), lang];
    }
    return languages;
}

-(int) getPoststampsCount:(bool)bonus buffer:(bool)fromBuffer{ // user specific method
    NSString* field = bonus ? (fromBuffer ? F_BP_BUF : F_BP) : (fromBuffer ? F_RP_BUF : F_RP);
    NSString *querySQL = [NSString stringWithFormat: @"SELECT %@ FROM %@ WHERE %@=\"%@\" AND %@=\"%@\"", field, T_USERS, F_EMAIL, [UserSettings getEmail], F_AUTHOR, [UserSettings getEmail]];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString *countField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            return countField.intValue;
        }
        sqlite3_finalize(statement);
    }
    return -1;
}

-(void) addPoststamps:(int)count bonus:(bool)bonus toBuffer:(bool)toBuffer{ // user specific method
    NSString* field = bonus ? (toBuffer ? F_BP_BUF : F_BP) : (toBuffer ? F_RP_BUF : F_RP);
    int currentValue = [self getPoststampsCount:bonus buffer:toBuffer];
    NSString* querySQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ = %d WHERE %@=\"%@\" AND %@=\"%@\"", T_USERS, field, currentValue + count, F_EMAIL, [UserSettings getEmail], F_AUTHOR, [UserSettings getEmail]];
    const char *query_stmt = [querySQL UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
        } else {
            NSLog(@"Error resetting unread flag of messages with collocutor)");
        }
    }
}


@end