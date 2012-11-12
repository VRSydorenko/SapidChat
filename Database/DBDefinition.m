//
//  DBDefinition.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/26/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "DBDefinition.h"
#import "DbTable.h"

@implementation DBDefinition{
    NSMutableArray* tables;
}

-(id) init{
    self = [super init];
    if (self){
        [self initialize];
    }
    return self;
}

-(void) initialize{
    tables = [[NSMutableArray alloc] init];
    
    DbTable* tUsers = [[DbTable alloc] initWithTableName:T_USERS];
    [tUsers addField:F_AUTHOR type:DBTYPE_TEXT notNull:YES];
    [tUsers addField:F_EMAIL type:DBTYPE_TEXT notNull:YES];
    [tUsers addField:F_NICK type:DBTYPE_TEXT notNull:YES];
    [tUsers addField:F_LANGS type:DBTYPE_TEXT notNull:YES];
    [tUsers addField:F_RP type:DBTYPE_REAL notNull:YES];
    [tUsers addField:F_BP type:DBTYPE_REAL notNull:YES];
    [tUsers addField:F_RP_BUF type:DBTYPE_REAL notNull:YES];
    [tUsers addField:F_BP_BUF type:DBTYPE_REAL notNull:YES];
    [tables addObject:tUsers];
    
    DbTable* tMessages = [[DbTable alloc] initWithTableName:T_MSGS];
    [tMessages addField:F_AUTHOR type:DBTYPE_TEXT notNull:YES];
    [tMessages addField:F_FROM type:DBTYPE_TEXT notNull:YES];
    [tMessages addField:F_TO type:DBTYPE_TEXT notNull:YES];
    [tMessages addField:F_WHEN type:DBTYPE_REAL notNull:YES];
    [tMessages addField:F_TEXT type:DBTYPE_TEXT notNull:YES];
    [tMessages addField:F_UNREAD type:DBTYPE_REAL notNull:NO];
    [tMessages addField:F_INITIAL_TIMESTAMP type:DBTYPE_REAL notNull:NO];
    [tables addObject:tMessages];
}

-(NSString*) getTablesCreationSQL{
    NSString* sql = [[NSString alloc] init];
    for (DbTable* table in tables) {
        sql = [sql stringByAppendingString:[table getTableCreationSQL]];
    }
    return sql;
}

@end
