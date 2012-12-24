//
//  Lang.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "Lang.h"
#import "UserSettings.h"
#import "LangEnglish.h"
#import "LangRussian.h"

@implementation Lang

+(Class) AppLanguage{
    switch ([UserSettings getAppLanguage]) {
        case 2: return [LangEnglish class];
        case 10: return [LangRussian class];
    }
    return nil;
}

+(NSString*)getAppLanguageStringForFirstLaunch:(int)lang{
    switch (lang) {
        case 2: return [LangEnglish LOC_FIRSTLAUNCH_APPLANGUAGE];
        case 10: return [LangRussian LOC_FIRSTLAUNCH_APPLANGUAGE];
    }
    return nil;
}

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
// system messages
+(NSString*) LOC_SYS_MSG_WELCOME{ return [[self AppLanguage] LOC_SYS_MSG_WELCOME];}
+(NSString*) LOC_SYS_MSG_INCOME_LOOK{ return [[self AppLanguage] LOC_SYS_MSG_INCOME_LOOK];}
+(NSString*) LOC_SYS_MSG_OUTGOING_LOOK{ return [[self AppLanguage] LOC_SYS_MSG_OUTGOING_LOOK];}
+(NSString*) LOC_SYS_MSG_INTRIGUE_LOOK{ return [[self AppLanguage] LOC_SYS_MSG_INTRIGUE_LOOK];}
+(NSString*) LOC_SYS_MSG_SYSTEM_LOOK{ return [[self AppLanguage] LOC_SYS_MSG_SYSTEM_LOOK];}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return [[self AppLanguage] LOC_INFO_FEATURE_TITLE_DISTANCE];}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{ return [[self AppLanguage] LOC_INFO_FEATURE_DESCR_DISTANCE];}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return [[self AppLanguage] LOC_INFO_FEATURE_NOTE_DISTANCE];}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return [[self AppLanguage] LOC_INFO_FEATURE_TITLE_IMAGE];}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return [[self AppLanguage] LOC_INFO_FEATURE_DESCR_IMAGE];}
// about screen
+(NSString*) LOC_ABOUT_SCREEN_TITLE{ return [[self AppLanguage] LOC_ABOUT_SCREEN_TITLE];}
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return [[self AppLanguage] LOC_ABOUT_VIKTOR_SYDORENKO];}
+(NSString*) LOC_ABOUT_DASHA_DESIGNER{ return [[self AppLanguage] LOC_ABOUT_DASHA_DESIGNER];}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{ return [[self AppLanguage] LOC_ABOUT_IDEA_AND_DEVELOPMENT];}
+(NSString*) LOC_ABOUT_DESIGN{ return [[self AppLanguage] LOC_ABOUT_DESIGN];}
+(NSString*) LOC_ABOUT_LOCALIZATION{ return [[self AppLanguage] LOC_ABOUT_LOCALIZATION];}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return [[self AppLanguage] LOC_FIRSTLAUNCH_APPLANGUAGE];}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return [[self AppLanguage] LOC_FIRSTLAUNCH_BTN_NEXT];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_WELCOME];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_COMPOSE];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_PICKITUP];}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return [[self AppLanguage] LOC_FIRSTLAUNCH_LABEL_COMMUNICATE];}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE { return [[self AppLanguage] LOC_REGISTATOR_TITLE];}
+(NSString*) LOC_REGISTATOR_BTN_CANCEL { return [[self AppLanguage] LOC_REGISTATOR_BTN_CANCEL];}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return [[self AppLanguage] LOC_REGISTATOR_BTN_NEXT];}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return [[self AppLanguage] LOC_REGISTATOR_BTN_REGISTER];}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return [[self AppLanguage] LOC_REGISTATOR_BTN_CLOSE];}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return [[self AppLanguage] LOC_REGISTATOR_BTN_BACK];}
+(NSString*) LOC_REGISTATOR_FIELD_EMAIL { return [[self AppLanguage] LOC_REGISTATOR_FIELD_EMAIL];}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return [[self AppLanguage] LOC_REGISTATOR_FIELD_PASSWORD];}
+(NSString*) LOC_REGISTATOR_SWITCH_SAVECREDS { return [[self AppLanguage] LOC_REGISTATOR_SWITCH_SAVECREDS];}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return [[self AppLanguage] LOC_REGISTATOR_FIELD_NICK];}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return [[self AppLanguage] LOC_REGISTATOR_TEXT_SPECIFYNICK];}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return [[self AppLanguage] LOC_REGISTATOR_LABEL_SELECT_LANGS];}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{ return [[self AppLanguage] LOC_REGISTATOR_ERR_EMPTYNICK];}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{ return [[self AppLanguage] LOC_REGISTATOR_ERR_INVALIDNICK];}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{ return [[self AppLanguage] LOC_REGISTATOR_ERR_NOLANGS_SELECTED];}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return [[self AppLanguage] LOC_LOGIN_BTN_LOGIN];}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return [[self AppLanguage] LOC_LOGIN_BTN_REGISTRATION];}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD{return [[self AppLanguage] LOC_LOGIN_BTN_FORGOTPASSWORD];}
+(NSString*) LOC_LOGIN_TXT_LOGIN_PLACEHOLDER {return [[self AppLanguage] LOC_LOGIN_TXT_LOGIN_PLACEHOLDER];}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER{return [[self AppLanguage] LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER];}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return [[self AppLanguage] LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE];}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return [[self AppLanguage] LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE];}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES{return [[self AppLanguage] LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES{return [[self AppLanguage] LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES];}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES{return [[self AppLanguage] LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES];}
+(NSString*) LOC_MAIN_CELL_INTRIGUE{return [[self AppLanguage] LOC_MAIN_CELL_INTRIGUE];}
+(NSString*) LOC_MAIN_CELL_BALANCE{return [[self AppLanguage] LOC_MAIN_CELL_BALANCE];}
+(NSString*) LOC_MAIN_BUTTON_SETTINGS{return [[self AppLanguage] LOC_MAIN_BUTTON_SETTINGS];}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return [[self AppLanguage] LOC_MAIN_BUTTON_LOGOUT];}
+(NSString*) LOC_MAIN_BUTTON_FORGOTPASS{return [[self AppLanguage] LOC_MAIN_BUTTON_FORGOTPASS];}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return [[self AppLanguage] LOC_RESTORE_SCREEN_TITLE];}
+(NSString*) LOC_RESTORE_TXT_EMAIL_PLACEHOLDER{return [[self AppLanguage] LOC_RESTORE_TXT_EMAIL_PLACEHOLDER];}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return [[self AppLanguage] LOC_RESTORE_LABEL_INSTRUCTION];}
+(NSString*) LOC_RESTORE_BTN_GO{return [[self AppLanguage] LOC_RESTORE_BTN_GO];}
+(NSString*) LOC_RESTORE_BTN_CANCEL{return [[self AppLanguage] LOC_RESTORE_BTN_CANCEL];}
+(NSString*) LOC_RESTORE_ALERT_STATE{return [[self AppLanguage] LOC_RESTORE_ALERT_STATE];}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return [[self AppLanguage] LOC_RESTORE_ALERT_BTN_OK];}
// intrigue sell screen
+(NSString*) LOC_INTRIGUE_SCREEN_TITLE{ return [[self AppLanguage] LOC_INTRIGUE_SCREEN_TITLE];}
+(NSString*) LOC_INTRIGUE_SELL_DESCRIPTION{ return [[self AppLanguage] LOC_INTRIGUE_SELL_DESCRIPTION];}
+(NSString*) LOC_INTRIGUE_SELL_BTN_ACTIVATE{ return [[self AppLanguage] LOC_INTRIGUE_SELL_BTN_ACTIVATE];}
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return [[self AppLanguage] LOC_INTRIGUE_LABEL_ENTERMAIL];}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return [[self AppLanguage] LOC_INTRIGUE_LABEL_CONDITIONS];}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return [[self AppLanguage] LOC_INTRIGUE_BTN_SEND];}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return [[self AppLanguage] LOC_INTRIGUE_SERVICEMSG_SENDING_OK];}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_INPROGRESS{return [[self AppLanguage] LOC_INTRIGUE_SERVICEMSG_SENDING_INPROGRESS];}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_EMAIL{return [[self AppLanguage] LOC_INTRIGUE_EDIT_PLACEHOLDER_EMAIL];}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return [[self AppLanguage] LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG];}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return [[self AppLanguage] LOC_INTRIGUE_COLLOCUTOR_MESSAGE];}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return [[self AppLanguage] LOC_INTRIGUE_MAIL_SUBJECT];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [[self AppLanguage] LOC_INTRIGUE_MAIL_CONTENT_DEFAULT];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [[self AppLanguage] LOC_INTRIGUE_MAIL_CONTENT_CUSTOM];}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [[self AppLanguage] LOC_MESSAGES_TITLE];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return [[self AppLanguage] LOC_MESSAGES_BTN_COMPOSE];}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return [[self AppLanguage] LOC_MESSAGES_BTN_PICKNEW];}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return [[self AppLanguage] LOC_MESSAGES_CELL_WAIT_FOR_REPLY];}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return [[self AppLanguage] LOC_MESSAGES_CELL_NO_RECORDS];}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return [[self AppLanguage] LOC_MESSAGES_CELL_NO_MSG_TOPICKUP];}
+(NSString*) LOC_MESSAGES_CELL_BTN_HIDE{return [[self AppLanguage] LOC_MESSAGES_CELL_BTN_HIDE];}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return [[self AppLanguage] LOC_MESSAGES_CELL_DISTANCE_KILOMETERS];}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return [[self AppLanguage] LOC_MESSAGES_CELL_DISTANCE_METERS];}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return [[self AppLanguage] LOC_MESSAGES_CELL_DISTANCE_MILES];}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return [[self AppLanguage] LOC_MESSAGES_CELL_DISTANCE_FEETS];}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return [[self AppLanguage] LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE];}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE{return [[self AppLanguage] LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE];}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return [[self AppLanguage] LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE];}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return [[self AppLanguage] LOC_MESSAGES_CELL_LOADING];}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY{return [[self AppLanguage] LOC_MESSAGES_MESSAGES_BTN_REPLY];}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE{return [[self AppLanguage] LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE];}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return [[self AppLanguage] LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE];}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return [[self AppLanguage] LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE];};
    +(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return [[self AppLanguage] LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM];}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CANCEL{return [[self AppLanguage] LOC_MESSAGES_DIALOG_ACTIONSHEET_CANCEL];};
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLEAR{return [[self AppLanguage] LOC_MESSAGES_DIALOG_ACTIONSHEET_CLEAR];};
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_EDIT{return [[self AppLanguage] LOC_MESSAGES_DIALOG_ACTIONSHEET_EDIT];};
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return [[self AppLanguage] LOC_MESSAGES_ALERT_DELETION_TITLE];}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return [[self AppLanguage] LOC_MESSAGES_ALERT_DELETION_QUESTION];}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_CANCEL{return [[self AppLanguage] LOC_MESSAGES_ALERT_DELETION_CANCEL];}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_OK{return [[self AppLanguage] LOC_MESSAGES_ALERT_DELETION_OK];}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return [[self AppLanguage] LOC_COMPOSE_TITLE];}
+(NSString*) LOC_COMPOSE_BTN_SEND{return [[self AppLanguage] LOC_COMPOSE_BTN_SEND];}
+(NSString*) LOC_COMPOSE_BTN_ATTACH_IMG{return [[self AppLanguage] LOC_COMPOSE_BTN_ATTACH_IMG];}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return [[self AppLanguage] LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM];}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return [[self AppLanguage] LOC_COMPOSE_ACTSHEET_CAMERA];}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return [[self AppLanguage] LOC_COMPOSE_ACTSHEET_CAMERA_ROLL];}
+(NSString*) LOC_COMPOSE_ACTSHEET_CANCEL{return [[self AppLanguage] LOC_COMPOSE_ACTSHEET_CANCEL];}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return [[self AppLanguage] LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE];}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS {return [[self AppLanguage] LOC_SETTINGS_WINDOWTITLE_SETTINGS];}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return [[self AppLanguage] LOC_SETTINGS_SECTIONHEADER_DATEnTIME];}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEZONE {return [[self AppLanguage] LOC_SETTINGS_SECTION_DATEnTIME_TIMEZONE];}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return [[self AppLanguage] LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT];}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return [[self AppLanguage] LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT];}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return [[self AppLanguage] LOC_SETTINGS_SECTIONHEADER_ACCOUNT];}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return [[self AppLanguage] LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME];}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return [[self AppLanguage] LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD];}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_SAVECREDS {return [[self AppLanguage] LOC_SETTINGS_SECTION_ACCOUNT_SAVECREDS];}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return [[self AppLanguage] LOC_SETTINGS_SECTIONHEADER_LANGUAGES];}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return [[self AppLanguage] LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION];}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return [[self AppLanguage] LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES];}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return [[self AppLanguage] LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION];}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_BTN_OK{return [[self AppLanguage] LOC_SETTINGS_POPUPEDIT_BTN_OK];}
+(NSString*) LOC_SETTINGS_POPUPEDIT_BTN_CANCEL{return [[self AppLanguage] LOC_SETTINGS_POPUPEDIT_BTN_CANCEL];}
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return [[self AppLanguage] LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE];}

+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT];}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_NEW{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_PLACEHLDR_NEW];}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM];}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_BTN_OK];}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE];}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_RESULT_MSG];}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_BTN_OK{return [[self AppLanguage] LOC_SETTINGS_CHANGEPASS_RESULT_BTN_OK];}


// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return [[self AppLanguage] LOC_BALANCE_SCREEN_TITLE];}
+(NSString*) LOC_BALANCE_PRO_NO{return [[self AppLanguage] LOC_BALANCE_PRO_NO];}
+(NSString*) LOC_BALANCE_PRO_YES{return [[self AppLanguage] LOC_BALANCE_PRO_YES];}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return [[self AppLanguage] LOC_BALANCE_WHAT_IN_PRO];}
+(NSString*) LOC_BALANCE_BTN_MAKEPRO{return [[self AppLanguage] LOC_BALANCE_BTN_MAKEPRO];}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return [[self AppLanguage] LOC_BALANCE_BTN_RESTORE];}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return [[self AppLanguage] LOC_BALANCE_HEADER_YOUR_BALANCE];}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return [[self AppLanguage] LOC_BALANCE_POSTSTAMPS_1];}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return [[self AppLanguage] LOC_BALANCE_POSTSTAMPS_3];}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return [[self AppLanguage] LOC_BALANCE_POSTSTAMPS_5];}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return [[self AppLanguage] LOC_BALANCE_HEADER_TOPUP];}
+(NSString*) LOC_BALANCE_BUY_POSTSTAMPS{return [[self AppLanguage] LOC_BALANCE_BUY_POSTSTAMPS];}

// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME {return [[self AppLanguage] LOC_SYS_LANGUAGE_SELFNAME];}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_ARABIC];}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_CHINESE];}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_ENGLISH];}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_FRENCH];}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_GERMAN];}
+(NSString*) LOC_SETTINGS_LANGUAGES_HINDI{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_HINDI];}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_ITALIAN];}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_JAPANESE];}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_KOREAN];}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_PORTUGESE];}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_RUSSIAN];}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{return [[self AppLanguage] LOC_SETTINGS_LANGUAGES_SPANISH];}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_TEXT_PICKLANGFROMKNOWN{return [[self AppLanguage] LOC_SEPSETTINGS_NEWMSGLANG_TEXT_PICKLANGFROMKNOWN];}
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{return [[self AppLanguage] LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW];}
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_CANCEL{return [[self AppLanguage] LOC_SEPSETTINGS_NEWMSGLANG_BTN_CANCEL];}
+(NSString*) LOC_SEPSETTINGS_LANGSIKNOW_TEXT{return [[self AppLanguage] LOC_SEPSETTINGS_LANGSIKNOW_TEXT];}
+(NSString*) LOC_SEPSETTINGS_LANGSIKNOW_BTN_BACK {return [[self AppLanguage] LOC_SEPSETTINGS_LANGSIKNOW_BTN_BACK];}

// error codes
+(NSString*) LOC_ERRORCODE_OK {return [[self AppLanguage] LOC_ERRORCODE_OK];}
+(NSString*) LOC_ERRORCODE_ERROR{return [[self AppLanguage] LOC_ERRORCODE_ERROR];}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return [[self AppLanguage] LOC_ERRORCODE_INVALID_EMAIL];}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return [[self AppLanguage] LOC_ERRORCODE_USER_EXISTS];}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return [[self AppLanguage] LOC_ERRORCODE_NO_SUCH_USER];}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return [[self AppLanguage] LOC_ERRORCODE_WRONG_PASSWORD];}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return [[self AppLanguage] LOC_ERRORCODE_EMAIL_NOT_SPECIFIED];}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return [[self AppLanguage] LOC_ERRORCODE_AMAZON_SERVICE_ERROR];}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return [[self AppLanguage] LOC_ERRORCODE_PASSWORD_TOO_SHORT];}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return [[self AppLanguage] LOC_ERRORCODE_LOGIN_NOT_SPECIFIED];}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return [[self AppLanguage] LOC_ERRORCODE_TEXT_NOT_SPECIFIED];}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return [[self AppLanguage] LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH];}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return [[self AppLanguage] LOC_ERRORCODE_PASSWORDS_NOT_MATCH];}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return [[self AppLanguage] LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED];}

@end
