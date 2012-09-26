//
//  DBDefinition.h
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/26/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATABASE_NAME @"sapidchat.db"

#define DBTYPE_TEXT @"text"
#define DBTYPE_REAL @"real"

#define F_ID @"_id"

#define T_USERS @"t_users"
#define F_EMAIL @"f_email"
#define F_NICK @"f_nick"
#define F_LANGS @"f_langs" // comma separated language numbers

#define T_MSGS @"t_msgs"
#define FK_FROM @"f_from"
#define FK_TO @"f_to"
#define F_WHEN @"f_when"
#define F_TEXT @"text"

@interface DBDefinition : NSObject

-(NSString*) getTablesCreationSQL;

@end
