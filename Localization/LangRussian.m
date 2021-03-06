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
+(NSString*) LOC_UNI_CANCEL{return @"Отмена";}
+(NSString*) LOC_UNI_OK{return @"OK";}
+(NSString*) LOC_UNI_EMAIL{return @"Эл. почта";}
+(NSString*) LOC_UNI_YES{return @"Да";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Расстояние до собеседника";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"Вы можете только догадываться о том, где осядет ваше сообщение после того как вы его отправите, но вы сможете видеть расстояние до вашего собеседника! Кто знает как он далеко от вас... может, на расстоянии тысячи %@, а может и всего несокльких метров.", [Utils getIfMetricMeasurementSystem] ? @"километров" : @"миль"];
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"Расстояние отображается если определение местоположения разрешено для Sapid Chat как на вашем устройстве так и на устройстве вашего собесденика.";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"Изображения в сообщениях";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"Сегодня, конечно, никого не удивить пересылкой изображений, но все равно, легче отправить картинку прямо из чата в два клика чем спрашивать у собеседника адрес email и отправлять письмо.";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Виктор Сидоренко";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Skirtos";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Разработка и оформление";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Рисунки";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Локализация";}
+(NSString*) LOC_ABOUT_ALSO{return @"А также";}
+(NSString*) LOC_ABOUT_ICONS{return @"Иконки";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Язык приложения";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Далее";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Добро пожаловать в SapidChat!\rЗдесь вы найдете интересное общение и интригу! Это очень просто!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"Вы создаете сообщение и оно помещается в общую очередь сообщений.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Кто-то случайным образом выбирает ваше сообщение и отвечает на него!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"Завязывается общение!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Регистрация";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Далее";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Создать аккаунт!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Готово!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Назад";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Пароль";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Ник";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"Поскольку общение здесь анонимное, то было бы хорошо придумать себе ник чтобы было возможно различать собеседников";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Выберите языки, на которых вы можете общаться";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Не указан ник";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"Вы не можете использовать данный ник";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"Не выбрано ни одного языка";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"Завершена успешно!";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"В качестве логина в Sapid Chat используется email по следующим причинам:\r\
    - для восстановления пароля (будет выслан по указанному адресу в случае, если вы его забудете).\r\
    - для опции \"Интрига\" (если кто-нибудь захочет вас заинтриговать и пригласить анонимно пообщаться в Sapid Chat, зная адрес вашей электронной почты). Об опции \"Интрига\" вы можете прочитать на сайте приложения sapidchat.com или в соответствующем разделе программы после регистрации.\r\r\
    Sapid Chat не рассылает спам и не передает ваши данные третьим лицам!";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Вход";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Регистрация";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Забыли пароль?";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Пароль";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"Об Интриге";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"С помощью данной опции вы можете анонимно пригласить кого-то пообщаться. Все, что вам нужно знать - адрес электронной почты интересующего вас человека. Введите этот адрес в соответствующее поле и нажмите кнопку \"Заинтриговать\". После этого по указанному адресу будет отправлено письмо, которое сообщит человеку, что кто-то им заинтересован и анонимно приглашает к переписке в Sapid Chat. По желанию вы также можете добавить к приглашению свое личное сообщение.\r\rВ настоящее время Sapid Chat существует только на платформе iOS, поэтому, приглашая кого-то пообщаться в Sapid Chat, убедитесь в том, что у него есть iPhone или iPad и поэтому будет возможность ответить на ваше анонимное сообщние.";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"Почтовые марки - это внутрення валюта Sapid Chat. Для отправки одного интригующего письма необходима одна почтовая марка. Сразу же после регистрации пользователь бесплатно получает на свой внутренний счет 10 марок. Посмотреть состояние баланса и пополнить его можно в разделе \"Кабинет\".";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Сообщения";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"Hовых сообщений: %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"Новых сообщений нет";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Интрига";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Кабинет";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Выйти";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Восстановление пароля";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Введите email, указанный при регистрации:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Выслать пароль";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"Пароль отправлен по указанному адресу";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Закрыть";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"Здравствуйте, %@!\rВы запросили напоминание вашего пароля и мы с радостью высылаем его вам.\rВаш пароль: %@\rSapid Chat желает вам хорошего настроения и интересного общения!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue sell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Введите e-mail того, кого хотите заинтриговать, анонимно пригласив пообщаться:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Отправка: %d %@; У вас: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Заинтриговать!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Отправлено";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"Отправлено на ваш email";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"Дополнительное сообщение (не обязательно)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Привет! \rЭто я отправил тебе то интригующее сообщение на почту ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"Кто-то хочет заинтриговать вас в Sapid Chat";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"Хотите заинтриговать сами себя? Ну что ж, в таком случае мы вам расскажем, что именно происходит при отправке интригующего письма.\
    <ul type=\"Circle\">\
    <li>\
    <p>Ваш адресат получит письмо следующего содержания:</p>\
    %@\
    <br/>\
    </li>\
    <li>Когда человек после прочтения вашего письма откроет Sapid Chat, то он увидит следующее сообщение, отправленное от имени вашей учетной записи:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    После отправки нужно будет подождать пока человек проверит почту и надеяться, что это затронет его интерес и он зайдет в Sapid Chat ответить вам.\
    <p>Интересного вам общения!\
    <br/>Sapid Chat</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"А также еще одно, которое вы указали в качестве дополнительного:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>Здравствуйте!</h4>\
    <p>Кто-то, кто знает адрес вашей электронной почты, хочет вам что-то сказать и анонимно приглашает пообщаться в Sapid Chat!</p>\
    <p>Sapid Chat - это приложение для интересного общения. В нем есть опция, с помощью которой можно анонимно пригласить знакомого человека пообщаться, зная адрес его электронной почты.\
    <br/><font color=\"red\"><strong>Это письмо - не спам!</strong></font> Кто-то вручную ввел адрес вашей электронной почты чтобы заинтриговать и позвать пообщаться в Sapid Chat.</p>\
    %@\
    <p><font color=\"green\"><strong>Если вам интересно узнать кто вас так интригует</strong></font>, то вы можете зайти в Sapid Chat и узнать, кто же из знакомых отправил вам это приглашение. А может, наоборот, кто-то хочет познакомиться и узнал ваш email чтобы заинтриговать вас таким вот образом ;)</p>\
    <p><strong>Важно!</strong> Для того чтобы увидеть отправленное вам сообщение в программе, вам нужно при регистрации указать именно этот ваш адрес электронной почты.</p>\
    <p>Sapid Chat желает вам хорошего настроения и интересного общения!\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    Что еще вы можете сделать:\
    <br/>\
    <ul>\
    <li>если вам не интересно узнать кто вас приглашает к общению, вы можете, конечно, просто проигнорировать это письмо. Жаль, конечно, что в таком случае кто-то так и не дождется от вас никакого ответа.\
    </li>\
    <li>если вы все же хотите сообщить приглашающему, что вам это не интересно, то ответьте на это письмо, указав в теме \"NO\" и мы сообщим этому человеку, что вы не хотите как-либо реагировать.\
    </li>\
    <li>если вы больше никогда не хотите получать подобные письма от Sapid Chat в будущем, ответьте на это письмо указав в теме письма \"NEVER\". В таком случае мы заблокируем отправку приглашений на ваш адрес и если кто-либо захочет в будущем вас заинтриговать - сделать это уже не получится.\
    </li>\
    %@\
    </ul>\
    Примечание: обработка вашего ответного письма может занять некоторое время.\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>Этот человек также добавил к этому приглашению следующее сообщение:</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>если вам кажется, что дополнительное сообщение, которое было добавлено к этому приглашению носит непристойный характер, призывает к насилию либо несет иной непристойный смысл, то, пожалуйста, ответьте на это письмо, указав в теме \"CENSORED\". Мы рассмотрим этот текст и заблокируем пользователя. В таком случае, приносим извинения за подобное сообщение.\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Разместить";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Вытянуть";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"В ожидании ответа...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"Пока что нет сообщений";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"Сообщение с изображением";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"Сейчас нету новых сообщений на вашем языке для выборки";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"км";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"м";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"м";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"ф";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Ошибка загрузки :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE{return @"Нажмите для загрузки изображения";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"Изображения доступны в полной версии";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Загрузка...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Ответить";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Разместить еще";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"Действия над диалогом";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Удалить";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Пожаловаться";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Подтверждение удаления";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Удалить этот диалог?";}
+(NSString*) LOC_MESSAGES_REPORT_PICKED_UP{return @"%@ вытянул ваше сообщение!";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"Новое сообщение";}
+(NSString*) LOC_COMPOSE_MSG_SENDING{return @"Отправляем...";}
+(NSString*) LOC_COMPOSE_DLG_DELETING{return @"Удаляем...";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_SUCCEEDED{return @"Готово!";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_FAILED{return @"Ошибка!";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"Отправить";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"Источник:";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"Сделать фото";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"Выбрать из галереи";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"Очистить фото";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"К сожалению, данный источник изображений не доступен на этом устройстве.";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"Нечего отправлять. Ни текст ни фото не выбраны.";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS {return @"Настройки";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Дата и Время";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Формат времени";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Формат даты";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Учетная запись";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Ник";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Пароль";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Языки";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Общение";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"Новые сообщения";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Приложение";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"Дополнительно";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_TOUR{return @"Посмотреть вступление";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"О приложении";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Оцениете Sapid Chat";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Введите ваш ник";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Текущий пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Подтвердите новый пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Поменять";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"Новый пароль";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"Пароль успешно изменен";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Кабинет";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"Ограниченная версия!";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"Полная версия!";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"Преимущества полной версии";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"Восстановить";}
+(NSString*) LOC_BALANCE_HEADER_APP{return @"Приложение";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"Ваш баланс";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"почтовая марка";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"почтовых марки";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"почтовых марок";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"Пополнение баланса";}
+(NSString*) LOC_BALANCE_RESULT_TOPPED_UP{return @"Баланс пополнен!";}
+(NSString*) LOC_BALANCE_RESULT_ERROR{return @"Ошибка";}
+(NSString*) LOC_BALANCE_RESULT_NOTAUTHORIZED{return @"Платежы отключены";}
+(NSString*) LOC_BALANCE_RESULT_FULL_ACTIVATED{return @"Успешно обновлено!";}
+(NSString*) LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE{return @"В данный момент действие невозможно";}

// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"Русский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"Арабский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"Китайский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_DANISH{ return @"Датский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"Английский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"Французский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"Немецкий";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Итальянский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Японский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Корейский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Португальский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Русский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Испанский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"Венгерский";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"Румынский";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"К языкам, что я знаю...";}

// error codes
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
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"Данный email недоступен для Интриги";}

@end
