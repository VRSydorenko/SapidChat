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
    AMAZON_SERVICE_ERROR= 7,
    PASSWORD_TOO_SHORT  = 8,
    LOGIN_NOT_SPECIFIED = 9,
    TEXT_NOT_SPECIFIED  = 10,
    SYSTEM_NO_MESSAGES_TO_PICKUP = 11,
    SYSTEM_NO_SUCH_MESSAGE  = 12,
    SYSTEM_CONVERSATION_LANGUAGES_NOT_CONFIGURED = 13,
    POSTSTAMPS_NOT_ENOUGH   = 14,
    PASSWORDS_NOT_MATCH = 15,
    PASSWORD_NOT_SPECIFIED = 16,
} ErrorCodes;

typedef enum Languages{ // !!! Don't change the numbers !!!
    ARABIC      = 0,
    CHINESE     = 1,
    ENGLISH     = 2,
    FRENCH      = 3,
    GERMAN      = 4,
    HINDI       = 5,
    ITALIAN     = 6,
    JAPANESE    = 7,
    KOREAN      = 8,
    PORTUGESE   = 9,
    RUSSIAN     = 10,
    SPANISH     = 11,
    //---------------
    LANG_COUNT  = 12,
} Languages;


typedef enum MessageTypes{ // !!! Don't change the numbers !!!
    MSG_SYSTEM      = 0,
    MSG_REGULAR     = 1,
    MSG_INTRIGUE    = 2,
} MessageTypes;

#define SYSTEM_USER @"info@sapidchat.com"
#define SYSTEM_INTRIGUE_USER @"intrigue@sapidchat.com"

// s3
#define ATTACHMENTS_BUCKET_NAME @"sapid-chat-images"

// database

#define DBTABLE_USERS @"t_users"
#define DBFIELD_USERS_EMAIL @"email"
#define DBFIELD_USERS_PASSWORD @"pass"
#define DBFIELD_USERS_NICKNAME @"nick"
#define DBFIELD_USERS_LANGS @"langs"
#define DBFIELD_USERS_RP @"rp"

#define DBTABLE_MSGS_SENT @"t_msgs_sent"
#define DBTABLE_MSGS_RECEIVED @"t_msgs_received"
#define DBFIELD_MSGS_INITIAL_MSG @"initial_msg"

// common message related fields
#define DBFIELD_MSGS_FROM @"from"
#define DBFIELD_MSGS_TO @"to"
#define DBFIELD_MSGS_WHEN @"when"
#define DBFIELD_MSGS_TEXT @"text"
#define DBFIELD_MSGS_TYPE @"type"
#define DBFIELD_MSGS_LATD @"latd" // latitude
#define DBFIELD_MSGS_LOND @"lond" // longitude
#define DBFIELD_MSGS_ATT @"att"   // attachment filename

#define DBTABLE_MSGS_BANK @"t_msgs_bank"
#define DBFIELD_MSGS_BANK_LANG @"lang"
// to
// from
// when

// system definitions
#define APPLICATION_NAME_FONT @"billabong"
#define SYSTEM_WAITS_FOR_REPLY_COLLOCUTOR @"WaitForReplyCollocutor"
#define MINIMUM_PASSWORD_LENGTH 5

@interface DbModel : NSObject

@end
