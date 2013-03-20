//
//  LangEnglish.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangRomanian.h"

@implementation LangRomanian

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
+(NSString*) LOC_UNI_CANCEL{return @"Anuleaza";}
+(NSString*) LOC_UNI_OK{return @"OK";}
+(NSString*) LOC_UNI_EMAIL{return @"Email";}
+(NSString*) LOC_UNI_YES{return @"DA";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Distanta fata de partener";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"Puteti doar sa ghiciti in ce loc de pe Glob o sa ajunga mesajul dumneavoastra dupa ce l-ai trimis, dar o sa vedeti distanta la care se afla cel care va raspunde! Cine stie cat de departe este de dumneavoastra: ar putea fi o mie de %@, sau doar cativa %@.", [Utils getIfMetricMeasurementSystem] ? @"kilometri" : @"mile", [Utils getIfMetricMeasurementSystem] ? @"metri" : @"picioare"];
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"Distanta va fi afisata numai cand optiunile de locatie sunt valabile pentru SapidChat atat pentru dispozitivul dumneavoastra, cat si pentru cel al partenerului";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"Imagini in mesaje";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"Expedierea imaginilor nu e o inventie noua, dar e mai usor sa trimiti o imagine prin doua apasari pe chat, decat prin email.";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Viktor Sydorenko";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Skirtos";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Dezvoltare si teme";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Imagini";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Localizare";}
+(NSString*) LOC_ABOUT_ALSO{return @"De asemenea";}
+(NSString*) LOC_ABOUT_ICONS{return @"pictograme";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Limba aplicatiei";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Urmatorul";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Bine ati venit pe SapidChat!\rAici puteti descoperi savurosul mod de comunicare prin intermediul intrigilor! E atat de usor!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"Scrieti un mesaj nou, si il puneti in lista comuna.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"Cineva alege in mod aleatoriu mesajul dumneavoastra si raspunde!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"Conversatia incepe!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Inregistrare";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Urmatorul";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Creaza contul!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Gata!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Inapoi";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Parola";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Nickname";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"De vreme ce comunicarea se face in anonimat, e de folos sa va alegeti un nickname, pentru a putea face diferenta intre partenerii de conversatie";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Alege limbile pe care le cunoasteti";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Nickname nespecificat";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"Nu puteti folosi acest nickname";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"Nu a fost aleasa nici o limba";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"Inregistrarea a fost realizata cu succes!";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"Motivele pentru care accesul pe Sapid Chat se face prin email:\r\
    - pentru recuperarea parolei (parola va fi trimisa pe adresa de email in cazul in care ati uitat-o).\r\
    - pentru modul \"Intriga\" (in cazul in care cineva va cunoaste adresa de email si vrea sa va faca sa fiti intrigat). Mai multe informatii despre modul \"Intriga\" pot fii gasite pe website-ul aplicatiei, www.sapidchat.com, sau la sectiunea \"Intriga\" a aplicatiei, dupa inregistrare.\r\r\
    Sapid Chat nu trimite mesaje spam, si nu va face informatiile dumneavoastra publice.";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Login";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Inregistrare";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Ati uitat parola?";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Parola";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"Despre Intriga";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"Folosind aceasta optiune puteti invita in mod anonim pe cineva sa ia parte la o conversatie. Aveti nevoie numai de emailul persoanei respective. Introduceti emailul in campul corespunzator si apasati pe butonul \"Trimite email\". Dupa aceea, persoana vizata va primi un email cu o invitatie de a participa la conversatiile SapidChat, de la o persoana anonima. Optional, puteti adauga invitatiei si un mesaj scris.\r\r\
    In momentul de fata, Sapid Chat este dispopnibil numai pentru iOS, asa ca, inainte de a invita pe cineva, asigurati-va ca persoana respectiva duspune de un iPhone sau iPad, pentru a putea rula aplicatia Sapid Chat.";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"Poststamp-urile (timbrele postale) reprezinta moneda SapidCHat. Pentru a trimite un email \"Intriga\", aveti nevoie de un poststamp. Dupa inregistrate, utilizatorul primeste 10 poststamp-uri gratuire. Puteti verifica numarul de poststamp-uri, sau puteti adauga la numarul lor in sectiunea \"Portofel\".";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Mesaje";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"Mesaje noi: %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"Nu exista mesaje noi";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Intriga";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Portofel";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Logout";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Schimba-ti parola";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Va rugam sa introduceti emailul:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Trimiteti parola";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"Parola a fost trimisa la adresa de email";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Inchide";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"Buna, %@!\rIn urma cererii dumneavoastra, parola contului a fost resetata.\rNoua parola este: %@\rVa dorim conversatie placuta! Sapid Chat!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue cell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Introduceti emailul persoanei pe care doriti sa o invitati pe chat:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Trimitere: %d %@; Portofel: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Trimite email!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Trimis";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"Emailul a fost trimis la adresa dumneavoastara de email.";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"Adauga mesaj (optional)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Buna!\rTi-am trimis mesajul de intriga prin email ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"Invitatie intriganta de la Sapid Chat";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"Doriti sa fiti intrigat? Lucrul acesta se intampla cand trimiteti o scrisoare intriganta.\
    <ul type=\"Circle\">\
    <li>\
    <p>Partenerul dumneavoastra va primi un email cu urmatorul continut:</p>\
    %@\
    <br/>\
    </li>\
    <li>Cand vor deschide SapidChat, dupa citirea acestui email, ei vor vedea o introducere de la dumneavoastra:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    Dupa trimiterea scrisorii intrigante, va fi nevoie sa asteptati pana ce persoana respectiva isi verifica emailul, apoi deschide Sapid Chat pentru a va raspunde.\
    <p>Va dorim conversatie placuta!\
    <br/>Sapid Chat!</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"Si de asemenea, mesajul dumneavoastra introductiv:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>Buna!</h4>\
    <p>Cineva care va cunoaste adresa de email doreste sa va spuna ceva, si v-a invitat in mod anonim intr-o conversatie pe Sapid Chat!</p>\
    <p>Sapid Chat este o aplicatie pentru comunicare online, care va ofera optiunea de a va invita in mod anonim, prietenii intr-o conversatie (daca le cunoasteti adresa de email).\
    <br/><font color=\"red\"><strong>Acest email nu este spam!</strong></font> Cineva a introdus adresa dumneavoastra pentru a va intriga si a va invita intr-o conversatie pe Sapid Chat.</p>\
    %@\
    <p><font color=\"green\"><strong>Daca sunteti interesat sa aflati cine este cel care v-a intrigat</strong></font>, puteti deschide Sapid Chat pentru a vedea care dintre prietenii dumneavoastra v-a trimis aceasta invitatie. Sau, poate ca cineva doreste sa va cunoasca, si se foloseste de aceasta aplicatie ;)</p>\
    <p><strong>Important!</strong> Pentru a citi mesajul primit, trebuie sa va inregistrati folosind aceasta adresa de email.</p>\
    <p>Sapid chat va doreste conversatie placuta!\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    Alte lucruri pe care le puteti face:\
    <br/>\
    <ul>\
    <li>Daca nu sunteti interesat de aceasta invitatie, puteti ignora acest email. E pacat ca cineva care asteapta, nu va primi niciun raspuns de la dumneavoastra.\
    </li>\
    <li>Daca doriti ca persoana respectiva sa afle ca nu sunteti interesat, raspundeti la acest email punand \"NO\" in subiect, iar noi o sa-i transmitem acesteia ca nu dorit sa raspundeti invitatiei.\
    </li>\
    <li>Daca nu doriti sa mai primiti astfel de mesaje de la Sapid Chat in viitor, raspundeti la acest email punand \"NEVER\" la subiect. In cazul acesta, vom bloca adresa dumneavoastra de la a primi astfel de scrisori intrigante, si nimeni nu va mai putea contacta in acest mod.\
    </li>\
    %@\
    </ul>\
    Nota: procesarea raspunsului dumneavoastra, poate dura mai mult timp.\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>Aceasta persoana a adaugat si un mesaj aditional invitatiei:</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>Daca considerati ca mesajul adaugat invitatiei este obscen, incita la violenta sau contine spam, va rugam raspundeti la acest email punand \"CENSORED\" in subiect. Noi vom verifica textul, si vom bloca userul care vi l-a trimis. In cazul acesta, ne cerem scuze pentru un astfel de mesaj.\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Compune";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Alege mesaj nou";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"Raspuns in asteptare...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"Inca nu aveti mesaje";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"Mesaj cu imagine";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"Nu exista mesajele in limba/limbile dumneavoastra";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"km";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"m";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"mi";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"ft";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Eroare la incarcare :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE;{return @"Apasati pentru a incarca imaginea";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"Imaginile sunt valabile in versiunea full";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Se incarca...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Raspundeti";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Compune inca un mesaj";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"Mai multe";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Stergeti";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Revendica";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Confirma stergerea";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Doriti a sterge?";}
+(NSString*) LOC_MESSAGES_REPORT_PICKED_UP{return @"%@ picked up your message!";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"Mesaj nou";}
+(NSString*) LOC_COMPOSE_MSG_SENDING{return @"Se trimite...";}
+(NSString*) LOC_COMPOSE_DLG_DELETING{return @"Se sterge...";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_SUCCEEDED{return @"Terminat!";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_FAILED{return @"Eroare!";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"Trimite";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"Sursa:";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"Faceti o fotografie";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"Rasuciti camera";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"Eliminati imaginea";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"Din pacate, sursa imaginiii este indisponibila pentru acest dispozitiv";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"Va rugam introduceti un text sau o imagine ";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"Setari";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Data si ora";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Formatul orei";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Formatul datei";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Cont";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Screenname";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Parola";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Limbi";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Conversatii";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"Mesaje noi";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Aplicatie";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"Mai multe";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_TOUR{return @"Prezentare";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"Despre aplicatie";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Da o nota Sapid Chat";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Va rugam introduceti nickname-ul";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Parola actuala";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Confirmati noua parola";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Schimbati";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"Parola noua";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"Parola a fost schimbata";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Portofel";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"Versiune limitata!";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"Versiune Full!";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"Avantajele versiunii full";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"Restaureaza";}
+(NSString*) LOC_BALANCE_HEADER_APP{return @"Aplicatie";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"Balanta dumneavoastra";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"poststamp";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"poststamp-uri";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"poststamp-uri";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"Adaugati la balanta dumneavoastra";}
+(NSString*) LOC_BALANCE_RESULT_TOPPED_UP{return @"Adaugare reusita!";}
+(NSString*) LOC_BALANCE_RESULT_ERROR{return @"A aparut o eroare";}
+(NSString*) LOC_BALANCE_RESULT_NOTAUTHORIZED{return @"Optiunea de cumparare este dezactivata";}
+(NSString*) LOC_BALANCE_RESULT_FULL_ACTIVATED{return @"Actualizare reusita!";}
+(NSString*) LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE{return @"Actiunea nu este posibila momentan";}

// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"Romana";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"Araba";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"Chineza";}
+(NSString*) LOC_SETTINGS_LANGUAGES_DANISH{return @"Danish";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"Engleza";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"Franceza";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"Germana";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Italiana";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Japanese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Coreana";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Portugheza";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Rusa";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Spaniola";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"Maghiara";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"Romana";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"Limbile pe care le cunosc";}

// error codes
+(NSString*) LOC_ERRORCODE_ERROR{return @"A aparut o eroare";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"Acest email nu este valid";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"Userul exista deja";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"Userul nu a fost gasit";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"Parola gresita";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"Emailul nu poate fi gol";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"Eroare a serviciului!";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"Parola este prea scurta (minimum 5 caractere)";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"Username-ul nu poate fi gol";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"Textul no poate fi gol";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"Nu aveti suficient credit";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"Parolele nu se potrivesc";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"Nu ati specificat parola";}
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"Emailul introdus nu este valabil pentru Intriga";}

@end
