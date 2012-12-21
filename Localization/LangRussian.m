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
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Расстояние до собеседника";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"Когда вы получаете входящее сообщение, вы видите расстояние от вас до собеседника.\rИнтересно, с кем вы общаетесь. Ваш собеседник может быть рядом, а может быть и за тысячи %@ от вас.", [Utils getIfMetricMeasurementSystem] ? @"километров" : @"миль"];
}
// about screen
+(NSString*) LOC_ABOUT_SCREEN_TITLE{ return @"О приложении";}
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Виктор Сидоренко";}
+(NSString*) LOC_ABOUT_DASHA_DESIGNER{ return @"Дарья Конопатова";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Идея и разработка";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Графика";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Локализация";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Язык приложения";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Далее";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Добро пожаловать в SapidChat!\rЗдесь вы найдете интересное общение и итригу! Это очень просто!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"Вы создаете сообщение и оно помещается в общую очередь сообщений.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Кто-то случайным образом выбирает ваше сообщение и отвечает на него!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"Завязывается общение!";}
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
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"Поскольку общение здесь анонимное, то было бы хорошо придумать себе ник чтобы было удобно различать собеседников";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Выберите языки, на которых вы можете вести переписку";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Не указан ник";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"Не выбрано ни одного языка";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Вход";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Регистрация";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Забыли пароль?";}
+(NSString*) LOC_LOGIN_TXT_LOGIN_PLACEHOLDER    {return @"Email";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Пароль";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"Об Интриге";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"С помощью этой опции вы можете анонимно пригласить кого-нибудь для общения в Sapid Chat.\rЕсли вам кто-то нравится но вы стесняетесь сказать ему/ей об этом, вы можете заинтриговать ее (или его), пригласив пообщатсья в Sapid Chat, где и впоследствии раскрыть свой секрет.\rЭто только одна из причин, которые подойдуть для использовании данной опции.\rВажно: в настоящее время Sapid Chat существует только на платформе iOS, поэтому, приглашая кого-то пообщаться в Sapid Chat, убедитесь в том, что у нее/него есть iPhone или iPad и поэтому будет возможность ответить на ваше анонимное сообщние в Sapid Chat.";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Сообщения";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"%d новых сообщений";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"Новых сообщений нет";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Интрига";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Ваш баланс";}
+(NSString*) LOC_MAIN_BUTTON_SETTINGS {return @"Настройки";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Выйти";}
+(NSString*) LOC_MAIN_BUTTON_FORGOTPASS{ return @"Забыли пароль?";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Восстановление пароля";}
+(NSString*) LOC_RESTORE_TXT_EMAIL_PLACEHOLDER{return @"Email";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Введите email, указанный при регистрации:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Выслать пароль";}
+(NSString*) LOC_RESTORE_BTN_CANCEL{return @"Отмена";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"Пароль отправлен по указанному адресу";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Закрыть";}
// intrigue sell screen
+(NSString*) LOC_INTRIGUE_SCREEN_TITLE{return @"Интрига";}
+(NSString*) LOC_INTRIGUE_SELL_DESCRIPTION{return @"Тут - описание замечательной опции: отсылки анонимный приглашений на почту!\rПригласите того, кто вам нравится!";}
+(NSString*) LOC_INTRIGUE_SELL_BTN_ACTIVATE{ return @"Активировать";}
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Введите e-mail того, кого хотите заинтриговать, анонимно пригласив пообщаться:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Отправка: %d %@; У вас: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Заинтриговать!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Отправлено";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_INPROGRESS{return @"Отправка...";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_EMAIL{return @"Email";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"Ваше сообщение (не обязательно)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Привет!\rЭто я отправил тебе то интригующее сообщение на почту ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"Кто-то хочет заинтриговать вас в Sapid Chat";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"Здравствуйте!<br>\
    <br>\
    Кто-то, кто знает адрес вашей электронной почты, хочет вам что-то сказать и анонимно приглашает пообщаться в Sapid Chat!<br>\
    <br>\
    Sapid Chat - это приложение для интересного общения. В нем есть опция, с помощью которой можно анонимно пригласить знакомого человека пообщаться, зная адрес его электронной почты.<br>\
    Это письмо - не спам! Кто-то вручную ввел адрес вашей электронной почты чтобы заинтриговать и позвать пообщаться в Sapid Chat.<br>\
    %@\
    <br>\
    Если вам интересно узнать кто вас так интригует, то вы можете зайти в Sapid Chat и узнать, кто же из знакомых отправил вам это приглашение. А может, наоборот, кто-то хочет познакомиться и узнал ваш email чтобы заинтриговать вас таким вот образом ;)<br>\
    Важно: если вы не зарегистрированы в Sapid Chat, то для того чтобы увидеть отправленное вам сообщение в программе, вам нужно при регистрации указать именно этот ваш адрес электронной почты.<br>\
    <br>\
    Что еще вы можете сделать:<br>\
    - если вам не интересно узнать кто вас приглашает к общению, вы можете, конечно, просто проигнорировать это письмо. Жаль, конечно, что в таком случае кто-то так и не дождется от вас никакого ответа.<br>\
    - если вы все же хотите сообщить приглашающему, что вам это не интересно, то ответьте на это письмо, указав в теме \"NO\" и мы сообщим этому человеку, что вы не хотите как-либо реагировать.<br>\
    - если вы больше никогда не хотите получать подобные письма от Sapid Chat в будущем, ответьте на это письмо указав в теме письма \"NEVER\". В таком случае мы заблокируем отправку приглашений на ваш адрес и если кто-либо захочет в будущем вас заинтриговать, сделать это уже не получится.<br>\
    %@Примечание: обработка вашего ответного письма может занять некоторое время.<br>\
    <br>\
    Sapid Chat желает вам хорошего настроения и интересного общения!<br>\
    sapidchat.com<br>\
    info@sapidchat.com";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<br>\
    Этот человек также добавил к этому приглашению следующее сообщение:<br>\
    <i>\" %@ \"</i><br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"- если вам кажется, что дополнительное сообщение, которое было добавлено к этому приглашению носит [blah blah blah] характер, то, пожалуйста, ответьте на это письмо, указав в теме \"CENSORED\". В таком случае мы рассмотрим этот текст и при подтверждении ваших подозрений, заблокируем пользователя. В таком случае приносим извинения за подобное сообщение.<br>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Разместить";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Вытянуть";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"В ожидании ответа...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"Пока что нет сообщений";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"Сейчас нету сообщения на вашем языке(ах) для выборки.";}
+(NSString*) LOC_MESSAGES_CELL_BTN_HIDE{return @"Скрыть";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"км";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"м";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"м";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"ф";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Ошибка загрузки изображения :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE{return @"Нажмите для загрузки изображения";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"Изображения доступны в полной версии";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Загрузка...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Ответить";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Разместить еще";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"Действия над диалогом";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Удалить";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Пожаловаться";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CANCEL{return @"Отмена";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLEAR{return @"Очистить";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_EDIT{return @"Изменить";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Подтверждение удаления";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Удалить этот диалог?";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_CANCEL{return @"Отмена";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_OK{return @"Да";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"Новое сообщение";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"Отправить";}
+(NSString*) LOC_COMPOSE_BTN_ATTACH_IMG{return @"Добавить фото";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"Источник:";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"Сделать фото";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"Выбрать из галереи";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CANCEL{return @"Отмена";}
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

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_BTN_OK{return @"ОК";}
+(NSString*) LOC_SETTINGS_POPUPEDIT_BTN_CANCEL{return @"Отмена";}
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Введите ваш ник";}

+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Текущий пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_NEW{return @"Новый пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Подтвердите новый пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Поменять";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"Новый пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"Пароль успешно изменен";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_BTN_OK{return @"OK";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Баланс";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"Ограниченная версия!";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"Полная версия!";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"Преимущества полной версии";}
+(NSString*) LOC_BALANCE_BTN_MAKEPRO{return @"Перейти на Pro";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"Восстановить покупку";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"Ваш баланс";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"почтовая марка";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"почтовых марки";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"почтовых марок";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"Пополнение баланса";}
+(NSString*) LOC_BALANCE_BUY_POSTSTAMPS{return @"почтовых марок";}

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

// error codes
+(NSString*) LOC_ERRORCODE_OK {return @"OK";}
+(NSString*) LOC_ERRORCODE_ERROR{return @"Ошибка";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"Некорректный email адрес";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"Такой пользователь уже существует";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"Пользователь не найден";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"Неправильный пароль";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"Не указан email";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"Ошибка сервиса";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"Пароль слишком короткий (мин 5 символов)";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"Не указан логин";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"Текст не может быть пустым";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"Недостаточно марок";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"Новый пароль не подтвержден";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"Не указан пароль";}

@end
