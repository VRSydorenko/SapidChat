//
//  LangEnglish.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangHungarian.h"

@implementation LangHungarian

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
+(NSString*) LOC_UNI_CANCEL{return @"Mégse";}
+(NSString*) LOC_UNI_OK{return @"OK";}
+(NSString*) LOC_UNI_EMAIL{return @"Email";}
+(NSString*) LOC_UNI_YES{return @"Igen";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Távolság a partnertől";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"Nem tudhatod, hogy az üzeneted, amit küldtél a világ melyik pontján fog megérkezni, de megtudhatod, hogy milyen távol van tőled az, aki válaszolt neked! Ki tudja milyen messze lehet tőled: lehet ezer %@, de lehet, hogy csak pár %@.", [Utils getIfMetricMeasurementSystem] ? @"kilométerre" : @"mérföldre", [Utils getIfMetricMeasurementSystem] ? @"méterre" : @"láb"];
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"A távolságot csak akkor láthatod, ha ez a lehetőség elérhető a te és partnered SapidChat alkalmazásában.";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"Képek az üzenetben";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"Képküldés nem egy új találmány manapság, de könnyebb elküldeni két érintéssel a chatben, mint megtudni az e-mail címet és egy új üzenetet írni.";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Viktor Sydorenko";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Skirtos";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Fejlesztés és témák";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Képek";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Fordítás";}
+(NSString*) LOC_ABOUT_ALSO{return @"Továbbá";}
+(NSString*) LOC_ABOUT_ICONS{return @"Ikonok";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Alkalmazás nyelve";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Következő";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Üdvözlünk a Sapid Chat!\rItt a lehetőség, hogy másokat megkörnyékezz! És nem is nehéz!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"Írsz egy üzenetet és beteszed egy tetszőleges várólistába.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Valaki véletlenszerűen elolvassa az üzenetedet és válaszolni fog rá!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"A beszélgetés indul!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Regisztráció";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Következő";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Fiók létrehozása!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Kész!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Vissza";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Jelszó";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Álnév";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"Mivel itt a beszélgetés anonim, ezért az álnevek segítenek megkülönböztetni a beszélgetőpartnereket";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Válassz nyelvet amin tudsz írni";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Nincs álnév";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"Nem használhatod ezt a nevet";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"Nem választottál nyelvet";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"Sikeresen elkészült!";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"Hogy miért email címmel kell regisztrálni:\r\
    - jelszóhelyreállítás miatt (ha elfelejted, erre a címre fogjuk elküldeni).\r\
    - a \"Megkörnyékezés\" funkció (ha valaki tudja az email címedet és fel akarja kelteni az érdeklődésedet). Ha többet szeretnél erről a lehetőségről tudni, elolvashatod a www.sapidchat.com weboldalon, vagy az alkalmazás \"Megkörnyéjezés\" résznél a regisztrációt követően.\r\r\
    A Sapid Chat nem küld spamet és az adatokat bizalmasan kezeli.";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Belépés";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Regisztráció";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Elfelejtetted a jelszót?";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Jelszó";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"A Megkörnyékezésről";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"Ezzel a funkcióval név nélkül invitálhatsz másokat beszélgetni. Ehhez csak a kiválasztott személy e-mail címére van szükséged. Írd be ezt a címet a megfelelő helyre és nyomd meg a \"Megkörnyékezés\" gombot. Ezután küldünk egy levelet ennek a személynek arról, hogy valaki érdeklődik iránta, és név nélkül szeretne társalogni vele a Sapid Chat-en keresztül.\
    Jelenleg a SapidChat-et csak iOS-re adtuk ki, tehát ha ezzel a lehetőséggel szeretnél valakit megkörnyékezni, kérjük bizonyosodjon meg róla, hogy a partnere rendelkezik iPhonnal vagy iPaddel, és ezek alkalmasak a Sapid Chat futtatására, hogy válaszolhassanak neked.";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"A Bélyegek a Sapid Chat belső fizetőeszköze. Ha mag akarsz valakit környékezni, akkor ehhez egy bélyegre lesz szükséged. Regisztráció után a felhasználó kap 10 bélyeget ingyen. A bélyegek aktuális egyenlegét megnézni vagy vásárolni az Egyenleg résznél lehet.";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Üzenetek";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"Új üzenet: %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"Nincs új üzenet";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Megkörnyékezés";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Egyenleg";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Kijelentkezés";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Új jelszó";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Kérlek add meg az e-mail címed a regisztrációhoz:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Küldd el a jelszót";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"A jelszót elküldtük a megadott e-mail címre";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Bezárás";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"Sziá, %@!\rMivel új jelszót kértél, ezt elküldtük neked a megadott e-mail címedre.\rÚj jelszavad: %@\rSok érdekes csevegést kívánunk a Sapid Chat!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue cell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Add meg a személy e-mail címét, akit meg szeretnél környékezni:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Elküldve: %d %@; Egyenleged: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Megkörnyékező e-mail!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Küldés";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"Elküldve az e-mail címedre";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"További üzenet (opcionális)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Sziá!\rKüldtem neked egy megkörnyékező levelet ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"Egy megkörnyékezés a Sapid Chatről.";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"Szeretnéd ezt a megkörnyékezést? Következő fog történni:\
    <ul type=\"Circle\">\
    <li>\
    <p>A partnered kapni fog egy levelet a következő tartalommal:</p>\
    %@\
    <br/>\
    </li>\
    <li>Ha megnyitják a SapidChatet miután elolvasták ezt a levelet, egy meghívót fognak tőled látni:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    Ha valakinek küldtél egy megkörnyékező levelet, meg kell várnod, hogy elolvassa a levelet és válaszoljon neked a Sapid Chat keresztül.\
    <p>Kellemes társalgást!\
    <br/>Sapid Chat</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"Továbbá a bemutatkozó üzeneted:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>Sziá!</h4>\
    <p>Valaki ismeri az e-mail címed. és meghív név nélkül beszélgetni a SapidChat-en!</p>\
    <p>Sapid Chat egy alkalmazás, ami az érintkezés egy érdekes módja, mivel itt név nélkül hívhatsz meg beszélgetni embereket (ha tudod az e-mail címüket).\
    <br/><font color=\"red\"><strong>Ez e-mail hem spam!</strong></font> Valaki megadta az email címedet, hogy beszélgetni invitáljon a Sapid Chat.</p>\
    %@\
    <p><font color=\"green\"><strong>Ha érdekel ki akar veled beszélgetni veled ezen a módon</strong></font>, nyisd meg a SapidChat-et és nézd meg melyik barátod küldte ezt a meghívót. Vagy talán ép másképp - valaki meg akar ismerkedni veled, és valahogy megszerezte az e-mail címedet, hogy így megismerhessen ;)</p>\
    <p><strong>Fontos!</strong> Ha szeretnéd látni a megkapott üzenetedet, ezzel az e-mail címmel kell regisztrálnod.</p>\
    <p>Sapid Chat kellemes társalgást kíván neked!\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    További lehetőségeid vannak:\
    <br/>\
    <ul>\
    <li>Ha nem érdekel, ki akar veled beszélgetni, akkor természetesen figyelmen kívül hagyhatod ezt az e-mailt. Kár, hogy valaki vár majd, és nem fog választ kapni tőled.\
    </li>\
    <li>Ha értesíteni akarod ezt a személyt arról, hogy nem érdekel a meghívása, csupán válaszolnod kell erre a levélre, \"NO\" -t írva a tárgyhoz, és mi közölni fogjuk vele, hogy nem fogsz neki válaszolni.\
    </li>\
    <li>Ha a jövőben egyáltalán nem szeretnél SapidChatről levelet kapni, válaszolj erre a levélre \"NEVER\" -t írva a tárgyhoz. Ebben az esetben blokkolni fogunk minden érdeklődést és többet senki nem tud majd erre a címedre meghívót küldeni.\
    </li>\
    %@\
    </ul>\
    Figyelem: a válasz feldolgozása időt vehet igénybe.\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>Ez a személy további üzenetet csatolt a meghívóhoz:</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>Ha úgy gondolod, hogy a meghívóhoz csatolt üzenet obszcén, vagy erőszakra bújt vagy spam-et tartalmaz, akkor kérlek válaszolj erre a levélre és a tárgyhoz írd be a \"CENSORED\" szót. Ellenőrizni fogjuk a szöveget és blokkolni fogjuk azt a felhasználót, aki ezt küldte neked. Ebben az esetben elnézést kérünk ezért a levélért.\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Levélírás";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Kiveszek egy új üzenetet";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"Válaszra várás...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"Még nincs üzenet";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"Kép üzenet";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"Még pillanatnyilag nincs a te nyelveden elérhető üzenet";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"km";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"m";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"mi";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"ft";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Hiba a betöltés közben :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE;{return @"Érintsd meg a kép betöltéséhez";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"A képek csak ateljes verzióval érhetőek el";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Töltés...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Válasz";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Még egy üzenet írása";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"További műveletek";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Törlés";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Reklamáció";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Törlés megerősítése";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Töröljük?";}
+(NSString*) LOC_MESSAGES_REPORT_PICKED_UP{return @"%@ kapta meg az üzenetet!";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"Új üzenet";}
+(NSString*) LOC_COMPOSE_MSG_SENDING{return @"Küldés...";}
+(NSString*) LOC_COMPOSE_DLG_DELETING{return @"Törlés...";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_SUCCEEDED{return @"Kész!";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_FAILED{return @"Hiba!";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"Küld";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"Forrás:";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"Fotó készítés";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"Kamera Forgatása";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"Kép eltávolítása";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"A kép nem található";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"Kérlek adj meg valamilyen szöveget vagy képet a küldendő üzenetben";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"Beállítások";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Dátum és Idő";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Idő formátum";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Dátum formátum";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Fiók";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Felhasználónév";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Jelszó";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Nyelvek";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Társalgások";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"Új üzenet";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Alkalmazás";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"Továbbiak";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_TOUR{return @"Bevezetés";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"Alkalmazás névjegye";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Sapid Chat értékelése";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Add meg a felszhasználó nevedet";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Jelenlegi jelszó";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Új jelszó megerősítése";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Változtat";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"Új jelszó";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"A jelszó megváltoztatva";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Egyenleg";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"Limitált verzió!";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"Teljes verzió!";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"A teljes verzió eéőnyei";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"Visszavonás";}
+(NSString*) LOC_BALANCE_HEADER_APP{return @"Alkalmazás";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"Egyenleged";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"bélyeg";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"bélyeg";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"bélyeg";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"Egyenleg feltöltés";}
+(NSString*) LOC_BALANCE_RESULT_TOPPED_UP{return @"Egyenleged feltöltve!";}
+(NSString*) LOC_BALANCE_RESULT_ERROR{return @"Hiba történt!";}
+(NSString*) LOC_BALANCE_RESULT_NOTAUTHORIZED{return @"Vásárlás nem lehetséges";}
+(NSString*) LOC_BALANCE_RESULT_FULL_ACTIVATED{return @"Sikeres frissítés!";}
+(NSString*) LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE{return @"Jelenleg ez a művelet nem hajtható végre";}

// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"Magyar";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"Arab";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"Kínai";}
+(NSString*) LOC_SETTINGS_LANGUAGES_DANISH{ return @"Danish";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"Angol";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"Francia";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"Német";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Olasz";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Jabán";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Kóreai";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Portugál";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Orosz";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Spanyol";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"Magyar";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"Román";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"Ezek a nyelveket ismerem";}

// error codes
+(NSString*) LOC_ERRORCODE_ERROR{return @"Hiba történt";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"Az e-mail cím érvénytelen";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"Ez a felhasználó már létezik";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"Felhasználó nem található";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"Helytelen jelszó";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"Az e-mail hem lehet üres";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"Szolgáltatói hiba";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"Túl rövid jelszó (min 5 karakter)";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"A felhasználónév nem lehet üres";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"A nem lehet üres szöveg";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"Nincs több kredit";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"A jelszavak nem egyeznek";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"Nem adtál meg jelszót";}
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"Ezt a címet nem lehet Megkörnyékezni";}

@end
