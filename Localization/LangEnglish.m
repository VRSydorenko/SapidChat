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
+(NSString*) LOC_UNI_CANCEL{return @"Cancel";}
+(NSString*) LOC_UNI_OK{return @"OK";}
+(NSString*) LOC_UNI_EMAIL{return @"Email";}
+(NSString*) LOC_UNI_YES{return @"Yes";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Distance to collocutor";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"You can only guess where your message will settle on the globe after you've sent it but you will see the distance to the one who replies to you! Who knows how far away they are from you... it might be a thousand %@ or just few meters.", [Utils getIfMetricMeasurementSystem] ? @"kilometers" : @"miles"];
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"The distance is shown when location options is available for SapidChat on your and on your collocutor's device";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"Images in messages";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"Sending images is not a new invention nowadays, but it's easier to send an image in two taps from the chat than asking for their email address and composing a new email.";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Viktor Sydorenko";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Dmitriy Pohodyaev";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Development and decor";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Pictures";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Localization";}
+(NSString*) LOC_ABOUT_ALSO{return @"Also";}
+(NSString*) LOC_ABOUT_ICONS{return @"Icons";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Application language";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Next";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Welcome to SapidChat!\rHere you will find a sapid communication and intrigue! It is so easy!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"You compose a message and place it to a common message queue.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Somebody randomly picks your message up and replies!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"The conversation starts!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Registration";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Next";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Create account!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Done!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Back";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Password";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Nickname";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"Since the communication here is anonymous it would be good to specify a nickname in order to distinguish between interlocutors";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Choose languages you can text on";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Nick not specified";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"You cannot use this nickname";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"No languages selected";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"Completed successfuly!";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"The reasons of using email address as a login to Sapid Chat:\r\
    - for password restore (the password will be sent to your email address in case you forgot it).\r\
    - for the \"Intrigue\" feature (in case somebody knows your email and wants to make you intrigued). About the \"Intrigue\" feature you can read on the app website sapidchat.com or in the \"Intrigue\" section of the app after registration.\r\r\
    Sapid Chat does not send spam and does not expose your information to other people.";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Login";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Registration";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Forgot password?";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Password";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"About intrigue";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"With this feature you can anonymously invite somebody to communication. All you need for that is an email of the person you are interested in. Enter the email in the corresponding field and hit the \"Make intrigued\" button. After that to the entered email address will be sent an email telling the person that somebody is interested in them and anonymously invites to communication in Sapid Chat. You can optionally add an additional message to the invitation.\r\r\
    Currently Sapid Chat exists only for iOS so when making somebody intrigued with this option please be sure your partner has an iPhone or an iPad and thus will be able to run Sapid Chat and reply to you.";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"Poststamps is an internal currency of Sapid Chat. For sending one intriguing letter one poststamp is requred. Afetr the registration the user becomes 10 poststamps to their internal account for free. Checking the actual state of the poststamps balance or topping it up can be done in the \"Cabinet\".";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Messages";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"New messages: %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"No new messages";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Intrigue";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Cabinet";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Log out";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Password restore";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Please enter email you registered with:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Send password";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"The password has been sent to the entered email address";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Close";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"Hello, %@!\rYou asked to remind you about your password and we are sending it to you.\rYour password: %@\rSapid Chat wishes you an interesting communication!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue cell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Enter email of whose you want to get intrigued by inviting to the chat:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Sending: %d %@; You have: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Make intrigued!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Sent";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"Sent to your email address";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"Additional message (optional)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Hi there! \rIt was me who sent you the intrigue message per email;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"Somebody wants to intrigue you in Sapid Chat";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"Do you want to make intrigued yourself? Well, in this case we will tell what happens when sending an intriguing letter.\
    <ul type=\"Circle\">\
    <li>\
    <p>Your pair will receive an email of the following content:</p>\
    %@\
    <br/>\
    </li>\
    <li>When they open Sapid Chat after reading this email they will see the next message sent from you:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    After sending an intriguing letter it will be neccessary to wait until the person checks their mail and after getting intrigued will open Sapid Chat to reply to you.\
    <p>Have nice conversations!\
    <br/>Sapid Chat</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"And also one you specified as an additional message:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>Hello!</h4>\
    <p>Somebody, who knows your email address, wants to tell you something and anoneumosely invites to a conversations in Sapid Chat!</p>\
    <p>Sapid Chat is an application for interesting communication which has the feature of anoneumosely inviting people to a conversation (if you know their email eddress).\
    <br/><font color=\"red\"><strong>This email is not spam!</strong></font> Somebody manually entered your email address in order to make you intrigued and invite to a conversation to Sapid Chat.</p>\
    %@\
    <p><font color=\"green\"><strong>If you are interested in figuring out who is intriguing you in such way</strong></font> you can open Sapid Chat and see who of your friends sent you this invitation. Or maybe vice versa - somebody wants to get known with you and somehow fetched your email in order to make you intrigued this way ;)</p>\
    <p><strong>Important!</strong> In order to see the message you received in the app you have to enter exactly this your email address when registering.</p>\
    <p>Sapid chat wishes you an interesting conversations!\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    What else you can do:\
    <br/>\
    <ul>\
    <li>if you are not interested in who is inviting you to a conversation, you can of course simply ignore this mail. That is pity that somebody is waiting for and will not receive any answer from you.\
    </li>\
    <li>if you would like to notify the person that it is not interesting for you just reply to this email putting \"NO\" in the subject and we will tell that person that you do not want to react on the invitation.\
    </li>\
    <li>if you do not want to receive such emails from Sapid Chat in the futurejust reply to this email putting \"NEVER\" in the subject. In this case we will block your email for such intriguing letter and nobody will be able to do it in the future.\
    </li>\
    %@\
    </ul>\
    Note: processing of your reply might take some time.\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>That person has also added an additional message to th einvitation:</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>if you think the additional message which was added to the invitation is obscene, calls for violence or contains other obscene sense then please reply to this email putting \"CENSORED\" in the subject. We will review the text and block the user sent it to you. In this case we apologise for such message.\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Compose";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Pick new";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"Awaiting reply...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"No messages yet";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"Message with a picture";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"There are currently no messages in your language(s) to pick up";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"km";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"m";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"m";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"f";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Loading error :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE;{return @"Tap to load image";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"Images are available in full version";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Loading...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Reply";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Compose one more";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"Dialog actions";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Delete";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Claim";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Confirm delete";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Delete this dialog?";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"New message";}
+(NSString*) LOC_COMPOSE_MSG_SENDING{return @"Sending...";}
+(NSString*) LOC_COMPOSE_DLG_DELETING{return @"Deleting...";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_SUCCEEDED{return @"Done!";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_FAILED{return @"Error!";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"Send";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"Source:";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"Take a photo";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"Camera roll";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"Clear picture";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"The image source is unfortunately unabvailable on this device";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"Neither text nor image specified";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"Settings";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Date & Time";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Time format";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Date format";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Account";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Nickname";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Password";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Languages";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Conversations";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"New messages";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Application";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"More";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"About the app";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Rate Sapid Chat";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Please enter your nick";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Current password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Confirm new password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Change";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"New password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"The password has been changed";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Cabinet";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"Limited version!";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"Full version!";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"Advantages of Full version";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"Restore";}
+(NSString*) LOC_BALANCE_HEADER_APP{return @"Application";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"Your balance";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"poststamp";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"poststamps";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"poststamps";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"Top up your balance";}
+(NSString*) LOC_BALANCE_RESULT_TOPPED_UP{return @"Topped Up!";}
+(NSString*) LOC_BALANCE_RESULT_ERROR{return @"Error ocurred";}
+(NSString*) LOC_BALANCE_RESULT_NOTAUTHORIZED{return @"Purchaces disabled";}
+(NSString*) LOC_BALANCE_RESULT_FULL_ACTIVATED{return @"Successfuly upgraded!";}
+(NSString*) LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE{return @"Currently the action is not possible";}

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
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"Hungarian";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"Romanian";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"To the languages I know...";}

// error codes
+(NSString*) LOC_ERRORCODE_ERROR{return @"Error ocurred";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"The email is not correct";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"The user already exists";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"User not found";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"Wrong password";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"The email cannot be empty";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"Service error ocurred";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"The password is too short (min 5 characters)";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"The login cannot be empty";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"Text cannot be empty";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"Not enough poststamps";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"New password is not confirmed";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"The password not specified";}
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"Given email is not available for the Intrigue option";}

@end
