//
//  LangEnglish.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangEnglish.h"

@implementation LangEnglish

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Application language";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Next";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_GO{ return @"Go!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Welcome!\rHere you will find interesting chatting! The intrigue is the essential thing which can be achieved by three simple steps.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"You compose a message which is placed to the shared message queue.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Somebody picks it up and replies!\rIn the same way you can pick someone's message!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"Communication starts!\rYou don't know who is the person replied you, you don't know where they are from and they don't know about you anything!\rAll what happening is a message luckily sent to somebody! The intrigue!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Registration";}
+(NSString*) LOC_REGISTATOR_BTN_CANCEL { return @"Cancel";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Next";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Create account!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Done!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Back";}
+(NSString*) LOC_REGISTATOR_FIELD_EMAIL { return @"E-mail";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Password";}
+(NSString*) LOC_REGISTATOR_SWITCH_SAVECREDS { return @"Save password";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Nickname";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Choose languages you can text on";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Login";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Registration";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Messages";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"%d new messages";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"No new messages";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Intrigue";}
+(NSString*) LOC_MAIN_CELL_SETTINGS {return @"Settings";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Log out";}
// intrigue sell screen
+(NSString*) LOC_INTRIGUE_SELL_DESCRIPTION{return @"Here is a description of the amazing option!\rIt is sending an anonymous email!";}
+(NSString*) LOC_INTRIGUE_SELL_BTN_ACTIVATE{ return @"Activate";}
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Enter email of whose you want to get intrigued by inviting to the chat:";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Make intrigued!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Sent";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Compose";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Pick new";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"Awaiting reply...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"No records to display";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Reply";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Compose one more";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"Settings";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Date & Time";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEZONE {return @"Time zone";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Time format";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Date format";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Account";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Nickname";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Password";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_SAVECREDS {return @"Save credentials";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Languages";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Conversations";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"New messages";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Application";}
// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"English";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"Arabic";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"Chinese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"English";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"French";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"German";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HINDI{ return @"Hindi";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Italian";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Japanese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Korean";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Portugese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Russian";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Spanish";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_TEXT_PICKLANGFROMKNOWN{ return @"Choose from the languages you know one for the new message";}
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_TEXT_LANGS_I_KNOW{ return @"Select languages you can communicate in";}
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"The languages I know";}

@end
