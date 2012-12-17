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
#define DBTYPE_BOOL @"boolean"
#define DBTYPE_BLOB @"blob"

#define F_ID @"f_id"

#define T_USERS @"t_users"
#define F_EMAIL @"f_email"
#define F_NICK @"f_nick"
#define F_LANGS @"f_langs" // comma separated language numbers
#define F_RP @"f_rp" // regular poststamps
#define F_RP_BUF @"f_rp_buf" // regular poststamps buffer

#define T_MSGS @"t_msgs"
#define F_AUTHOR @"f_author" // for separating data between different users on the same iOS device
#define F_FROM @"f_from"
#define F_TO @"f_to"
#define F_WHEN @"f_when"
#define F_TEXT @"f_text"
#define F_TYPE @"f_type"
#define F_LATD @"f_latitude"
#define F_LOND @"f_longitude"
#define F_ATTNAME @"f_att_name"
#define F_ATTDATA @"f_att_data"
#define F_UNREAD @"f_unread"
#define F_INITIAL_TIMESTAMP @"f_initial_timestamp"

@interface DBDefinition : NSObject

-(NSString*) getTablesCreationSQL;

@end
