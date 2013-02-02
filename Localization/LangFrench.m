//
//  LangEnglish.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangFrench.h"

@implementation LangFrench

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
+(NSString*) LOC_UNI_CANCEL{return @"Cancel";}
+(NSString*) LOC_UNI_OK{return @"OK";}
+(NSString*) LOC_UNI_EMAIL{return @"Email";}
+(NSString*) LOC_UNI_YES{return @"Yes";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Distance to partner";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"You can only guess where your message will settle on the globe after you've sent it, but you will see the distance to the one who replies to you! Who knows how far away they are from you: it might be a thousand %@ or just a few %@.", [Utils getIfMetricMeasurementSystem] ? @"kilometers" : @"miles", [Utils getIfMetricMeasurementSystem] ? @"meters" : @"feet"];
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"The distance is shown when location options is available for SapidChat on both your and your partner's devices";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"Images in messages";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"Sending images is not a new invention nowadays, but it's easier to send an image with two taps within the chat rather than asking for their email address and composing a new email.";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Viktor Sydorenko";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Dmitriy Pohodyaev";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Development and themes";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Pictures";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Localization";}
+(NSString*) LOC_ABOUT_ALSO{return @"Also";}
+(NSString*) LOC_ABOUT_ICONS{return @"Icons";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Application language";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Next";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Welcome to SapidChat!\rHere you will find the sapid communication of intrigue! It is so easy!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"You compose a message and place it in a common message queue.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Somebody randomly picks up your message and replies!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"The conversation starts!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Registration";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Next";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Create account!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Done!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Back";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Password";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Nickname";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"Since the communication here is anonymous, it helps to specify a screenname in order to distinguish between conversation partners";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Choose languages you can write";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Screenname not specified";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"You cannot use this screenname";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"No languages selected";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"Completed successfuly!";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"The reason why an email address is used as a login to Sapid Chat:\r\
    - for password restore (the password will be sent to your email address in case you forgot it).\r\
    - for the \"Intrigue\" feature (in case somebody knows your email and wants to make you intrigued). More information about the \"Intrigue\" feature can be read on the app website, www.sapidchat.com, or in the \"Intrigue\" section of the app after registration.\r\r\
    Sapid Chat does not send spam and does not expose your information to other people.";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Login";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Register";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Forgot password?";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Password";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"About intrigue";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"With this feature you can anonymously invite somebody to a conversation. All you need is the email of the person you are interested in. Enter the email in the corresponding field and hit the \"Make Intrigued\" button. After that, an email will be send to the entered address telling the person that somebody is interested in them, and anonymously invites them to communicate in Sapid Chat. You can optionally add an additional message to the invitation.\r\r\
    Currently Sapid Chat exists only for iOS so when making somebody intrigued using this option please be sure that your partner has an iPhone or an iPad, and thus will be able to run Sapid Chat and reply to you.";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"Poststamps is the internal currency of Sapid Chat. For sending one Intrigue email, one poststamp is required. After the registration the user gains 10 poststamps in their internal account for free. Checking the actual state of the poststamps balance or topping it up can be done in the \"Balance\" section.";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Messages";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"New messages: %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"No new messages";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Intrigue";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Balance";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Logout";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Reset Password";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Please enter your registration email:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Send password";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"The password has been sent to the email address given";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Close";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"Hello, %@!\rYou asked to reset your password, and we are sending it to you.\rYour password: %@\rBest wishes for interesting communication from Sapid Chat!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue cell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Enter the email of the person you want to intrigue by inviting them to chat:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Sending: %d %@; Balance: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Intrigue email!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Sent";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"Sent to your email address";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"Additional message (optional)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Hi there!\rI sent you the intrigue message by email ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"An intrigue invite from Sapid Chat";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"Do you want to be intrigued? This is what happens when sending an intriguing letter.\
    <ul type=\"Circle\">\
    <li>\
    <p>Your partner will receive an email with the following content:</p>\
    %@\
    <br/>\
    </li>\
    <li>When they open Sapid Chat after reading this email they will see an introduction from you:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    After sending an intriguing letter it will be necessary to wait until the person checks their mail, and after getting intrigued, opens Sapid Chat to reply to you.\
    <p>Have nice conversations!\
    <br/>Sapid Chat</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"And also your introductory message:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>Hello!</h4>\
    <p>Somebody who knows your email address, wants to tell you something and anonymously invites to a conversations in Sapid Chat!</p>\
    <p>Sapid Chat is an application for interesting communication which has the feature of anonymously inviting people to a conversation (if you know their email address).\
    <br/><font color=\"red\"><strong>This email is not spam!</strong></font> Somebody manually entered your email address in order to make you intrigued and invite to a conversation to Sapid Chat.</p>\
    %@\
    <p><font color=\"green\"><strong>If you are interested in figuring out who is intriguing you in this way</strong></font>, you can open Sapid Chat and see which of your friends sent you this invitation. Or maybe the other way around - somebody wants to get to know you, and somehow found your email in order to make you intrigued this way ;)</p>\
    <p><strong>Important!</strong> In order to see the message you received in the app you have to enter this email address when registering.</p>\
    <p>Sapid chat wishes you interesting conversations!\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    Other things you can do:\
    <br/>\
    <ul>\
    <li>If you are not interested by who is inviting you to a conversation, you can of course simply ignore this mail. It is a pity that somebody is waiting and will not receive any answer from you.\
    </li>\
    <li>If you would like to notify the person that you are not interested, just reply to this email putting \"NO\" in the subject, and we will tell that person that you do not want to respond to the invitation.\
    </li>\
    <li>If you do not want to receive such emails from Sapid Chat in the future, just reply to this email putting \"NEVER\" in the subject. In this case we will block your email for these intriguing letters and nobody will be able to send them in the future.\
    </li>\
    %@\
    </ul>\
    Note: processing your reply might take some time.\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>That person has also added an additional message to the invitation:</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>If you think that the custom message which was added to the invitation is obscene, calls for violence or contains spam, then please reply to this email and put \"CENSORED\" in the subject. We will review the text and block the user who sent it to you. In this case we apologize for such a message.\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Compose";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Pick new message";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"Awaiting reply...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"No messages yet";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"Picture message";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"There are currently no messages in your language(s) to pick up";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"km";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"m";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"mi";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"ft";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Loading error :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE;{return @"Tap to load image";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"Images are available in full version";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Loading...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Reply";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Compose one more";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"More actions";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Delete";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Claim";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Confirm delete";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Delete?";}
+(NSString*) LOC_MESSAGES_REPORT_PICKED_UP{return @"%@ picked up your message!";}
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
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"Remove picture";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"The image source is unfortunately unabvailable on this device";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"Please enter text or an image to send";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"Settings";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Date & Time";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Time format";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Date format";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Account";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Screenname";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Password";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Languages";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Conversations";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"New messages";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Application";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"More";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"About the app";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Rate Sapid Chat";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Please enter your screenname";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Current password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Confirm new password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Change";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"New password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"The password has been changed";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Balance";}
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
+(NSString*) LOC_SETTINGS_LANGUAGES_DANISH{ return @"Danish";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"English";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"French";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"German";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HINDI{ return @"Hindi";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Italian";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Japanese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Korean";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Portuguese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Russian";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Spanish";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"Hungarian";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"Romanian";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"Languages I know";}

// error codes
+(NSString*) LOC_ERRORCODE_ERROR{return @"Error ocurred";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"The email is invalid";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"The user already exists";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"User not found";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"Wrong password";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"The email cannot be empty";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"Service error ocurred";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"The password is too short (min 5 characters)";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"The username cannot be empty";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"Text cannot be empty";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"Out of credit";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"Passwords don’t match";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"The password not specified";}
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"Given email is not available for Intrigue";}

@end
