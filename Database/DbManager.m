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

-(void) close{
    sqlite3_close(sapidDb);
}

-(void) saveUser:(User*)user{
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO %@ (%@, %@, %@) VALUES (\"%@\", \"%@\", \"%@\")", T_USERS, F_EMAIL, F_NICK, F_LANGS, user.email, user.nickname, user.languages];
    const char *insert_stmt = [insertSQL UTF8String];
    
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(sapidDb, insert_stmt, -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"User saved");
    } else {
        NSLog(@"Failed to save user");
    }
    sqlite3_finalize(statement);
}

-(User*) loadUser:(NSString*)email{
    NSString *querySQL = [NSString stringWithFormat: @"SELECT %@, %@ FROM %@ WHERE %@=\"%@\"", F_NICK, F_LANGS, T_USERS, F_EMAIL, email];
    const char *query_stmt = [querySQL UTF8String];
    
    User* user = nil;
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sapidDb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSLog(@"User found");
            user = [[User alloc] init];
            user.email = email;
            
            NSString *nickField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            user.nickname = nickField;
            
            NSString *langsField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            user.languages = [langsField componentsSeparatedByString: USER_LANGS_SEPARATOR];
        } else {
            NSLog(@"User not found in the database");
        }
        sqlite3_finalize(statement);
    }
    
    return user;
}

-(void) initDatabase{
    // Get the documents directory
    NSArray* dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: DATABASE_NAME]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
		const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &sapidDb) == SQLITE_OK)
        {
            char *errMsg;
            DBDefinition* dbDef = [[DBDefinition alloc] init];
            const char *sql = [[dbDef getTablesCreationSQL] UTF8String];
            if (sqlite3_exec(sapidDb, sql, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table(s)");
            }
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
}

@end