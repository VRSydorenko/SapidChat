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
    [tUsers addField:F_EMAIL type:DBTYPE_TEXT notNull:YES];
    [tUsers addField:F_NICK type:DBTYPE_TEXT notNull:YES];
    [tUsers addField:F_LANGS type:DBTYPE_TEXT notNull:NO];
    [tables addObject:tUsers];
}

-(NSString*) getTablesCreationSQL{
    NSString* sql = [[NSString alloc] init];
    for (DbTable* table in tables) {
        sql = [sql stringByAppendingString:[table getTableCreationSQL]];
    }
    return sql;
}

@end
