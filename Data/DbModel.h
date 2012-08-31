//
//  DbModel.h
//  SChat
//
//  Created by Viktor Sydorenko on 5/22/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import <Foundation/Foundation.h>

// error codes

typedef enum ErrorCodes{
    OK              = 0,
    ERROR           = 1,
    INVALID_EMAIL   = 2,
    USER_EXISTS     = 3,
    NO_SUCH_USER    = 4,
    WRONG_PASSWORD  = 5,
    EMAIL_NOT_SPECIFIED = 6,
    AMAZON_SERVICE_ERROR = 7,
    PASSWORD_TOO_SHORT = 8,
    LOGIN_NOT_SPECIFIED = 9,
} ErrorCodes;

// database


#define DBTABLE_USERS @"t_users"
#define DBFIELD_USERS_EMAIL @"email"
#define DBFIELD_USERS_PASSWORD @"pass"
#define DBFIELD_USERS_NICKNAME @"nick"

#define DBTABLE_MSGS_SENT @"t_msgs_sent"
#define DBTABLE_MSGS_RECEIVED @"t_msgs_received"
#define DBFIELD_MSGS_FROM @"from"
#define DBFIELD_MSGS_TO @"to"
#define DBFIELD_MSGS_WHEN @"when"
#define DBFIELD_MSGS_TEXT @"text"

#define DBTABLE_MSGS_BANK @"t_msgs_bank"
#define DBFIELD_MSGS_BANK_LANG @"lang"
#define DBFIELD_MSGS_BANK_WHEN @"when"
#define DBFIELD_MSGS_BANK_FROM @"from"
#define DBFIELD_MSGS_BANK_TEXT @"text"

@interface DbModel : NSObject

@end
