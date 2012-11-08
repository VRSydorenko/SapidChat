//
//  LangRussian.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangRussian.h"

@implementation LangRussian

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Язык приложения";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Далее";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_GO{ return @"Вперед!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Добро пожаловать!\rЗдесь вы найдете интересное общение! Итрига - залог интереса, который достигается тремя простыми действиями.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"Вы создаете сообщение и оно помещается в единое хранилище сообщений.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Кто-то другой случайным образом выбирает ваше сообщение и отвечает на него!\rТочно так же и вы можете случайным образом выбрать чье-то сообщение!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"Завязывается общение!\rВы не знаете кто ответит на ваше сообщение, вы не знаете откуда будет этот человек и он тоже о вас ничего не знает.\rВсе что есть - сообщение, отправленное на удачу кому-нибудь! Интрига! :)";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Регистрация";}
+(NSString*) LOC_REGISTATOR_BTN_CANCEL { return @"Отмена";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Далее";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Создать аккаунт!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Готово!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Назад";}
+(NSString*) LOC_REGISTATOR_FIELD_EMAIL { return @"Эл. почта";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Пароль";}
+(NSString*) LOC_REGISTATOR_SWITCH_SAVECREDS { return @"Сохранить пароль";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Ник";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Выберите языки, на которых вы можете вести переписку";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Вход";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Регистрация";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Сообщения";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"%d новых сообщений";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"Новых сообщений нет";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Интрига";}
+(NSString*) LOC_MAIN_CELL_SETTINGS {return @"Настройки";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Выйти";}
// intrigue sell screen
+(NSString*) LOC_INTRIGUE_SELL_DESCRIPTION{return @"Тут - описание замечательной опции: отсылки анонимный приглашений на почту!\rПригласите того, кто вам нравится!";}
+(NSString*) LOC_INTRIGUE_SELL_BTN_ACTIVATE{ return @"Активировать";}
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Введите e-mail того, кого хотите заинтриговать, пригласив анонимно пообщаться:";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Заинтриговать!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Отправлено";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Разместить";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Вытянуть";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"В ожидании ответа...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"Нет сообщений";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Ответить";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Разместить еще";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS {return @"Настройки";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Дата и Время";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEZONE {return @"Часовой пояс";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Формат времени";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Формат даты";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Учетная запись";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Ник";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Пароль";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_SAVECREDS {return @"Сохранить пароль";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Языки";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Общение";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"Новые сообщения";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Приложение";}
// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"Русский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"Арабский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"Китайский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"Английский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"Французский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"Немецкий";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HINDI{ return @"Хинди";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Итальянский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Японский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Корейский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Португальский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Русский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Испанский";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_TEXT_PICKLANGFROMKNOWN{ return @"Из языков, что вы знаете, выберите язык для нового сообщения";}
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"К языкам, что я знаю...";}
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_CANCEL{return @"Отмена";}
+(NSString*) LOC_SEPSETTINGS_LANGSIKNOW_TEXT{ return @"Выберите языки, на которых вы можете общаться";}
+(NSString*) LOC_SEPSETTINGS_LANGSIKNOW_BTN_BACK {return @"Назад";}

@end
