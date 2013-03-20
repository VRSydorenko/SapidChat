//
//  LangEnglish.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangItalian.h"

@implementation LangItalian

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
+(NSString*) LOC_UNI_CANCEL{return @"Elimina";}
+(NSString*) LOC_UNI_OK{return @"OK";}
+(NSString*) LOC_UNI_EMAIL{return @"Email";}
+(NSString*) LOC_UNI_YES{return @"Si";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"Distanza dal partner";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return [NSString stringWithFormat:@"Puoi solo indovinare dove il tuo messaggio  arrivera' nel mondo soltanto dopo averlo inviato, ma potrai vedere da quale distanza ti scrive colui che lo ha ricevuto!  Chi lo sa da quanto lontano ti risponde : potrebbe essere da centinaia di %@ di distanza o da soli pochi %@.", [Utils getIfMetricMeasurementSystem] ? @"chilomentri" : @"miglia", [Utils getIfMetricMeasurementSystem] ? @"metri" : @"piedini"];
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"La distanza viene mostrata quando e' disponibile l'opzione localizzazione per Sapid Chat sul tuo apparecchio e quello del tuo partner di comunicazione.";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"Immagini nel messaggio";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"Mandare delle immagini non e' certamente una nuova invenzione al giorno d'oggi, ma e' piu' semplice spedirle con pochi click usando la chat che tramite una normalissima email.";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Viktor Sydorenko";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Skirtos";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"Sviluppo e temi";}
+(NSString*) LOC_ABOUT_DESIGN{return @"Immagini";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"Localizzazione";}
+(NSString*) LOC_ABOUT_ALSO{return @"In piu'";}
+(NSString*) LOC_ABOUT_ICONS{return @"Icone";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"Appicazione lingua";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"Successivo";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"Benvenuto su SapidChat!\nQui troverai l'intrigante comunicazione di sapid. E' semplicissimo!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"Componi il messaggio e postalo nello spazio dei messaggi in comune.";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"A Qualcuno arriva il tuo messaggio e ti risponde!";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"Inizia la conversazione!";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"Registrati";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"Successivo";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"Crea un nuovo profilo!";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"Fatto!";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"Indietro";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"Password";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"Nome utente";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"Dato che le conversazioni sono anonime, ti aiuta a specificare un nome utente per aiutarti a distinguerlo dai vari partner di comunicazione";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"Scegli la ligua di scrittura";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"Nome utente non specificato";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"Non puoi usare questo nome utente";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"Nessuna lingua selezionata";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"riuscita con successo!";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"Ragioni per le  quali e' richiesto l'indirizzo email per accedere alla Sapid Chat:\r\
    - ripristinare la password (in caso ti sia dimenticato la password questa verra' mandata al tuo indirizzo email).\r\
    - Per le funzionalita' 'Intriga' (in caso qualcuno conosca la tua email e vuole parlare con te). Altr informazioni al riguardo di 'Intriga' si possono trovare nell'apposito website www.sapidchat.com, o nella sezione apllicazione' 'Intriga' dopo la registrazione.\r\r\
    Sapid Chat non manda spam e non divulga le tue informazioni ad altre persone.";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"Accedi";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"Registrati";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"Dimenticato la password?";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"Password";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"Al riguardo di 'Intriga'";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"Tramite questa funzione puoi anonimamente invitare qualcuno a conversare con te. Tutto quello di cui hai bisogno e' la email della persona con cui sei interessato a parlare. Inserisci la email nello spazio corrispondente e clicca sul bottone 'Intriga'. Successivamente, verra' spedita una email all'indirizzo di posta elettronica inserito che avvertira' la persona che qualcuno e' interessato a contattarlo tramite Sapid Chat. Se vuoi , puoi avere la possibilita' di aggiungere un tuo messaggio privato all'invito.";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"Poststamps rappresenta la valuta interna di Sapid Chat. Per mandare una email'interessa', e' richiesto un poststamp. Dopo la registrazione ogni utente riceve 10 poststamp nel proprio account gratuitamente. Puoi controllare l'attuale stato del bilancio del poststamp o  ricaricare il conto nella sezione 'Bilancio'.";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"Messaggi";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"Nuovi messaggi: %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"Nessun nuovo messaggio";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"Intriga";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"Bilancio";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"Esci";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"Resetta la password";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"Per favore digita la tua email di registrazione:";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"Invia la password";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"La password e' stata mandata al tuo indirizzo email.";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"Chiudi";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"Ciao, %@!\rHai chiesto di riprestinare la tua password, e noi la spediremo al tuo indirizzo.\rLa tua password: %@\rSperiamo che tu possa avere interessanti conversazioni da Sapid Chat!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue cell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"Inserisci la email della persona a cui vuoi' intrigare' invitandola a chattare:";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"Spedizione: %d %@; Bilancio: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"Email Intrigo!";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"Inviato";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"Invia al tuo indirizzo email";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"Messaggi aggiuntivi (opzione)";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"Ciao!\rTi ho mandato il messaggio intrigo tramite email ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"Un invito intrigo da Sapid Chat";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"Vuoi essere intrigato? Questo e' quello che succede quando invii un messaggio intrigo.\
    <ul type=\"Circle\">\
    <li>\
    <p>Il tuo partner ricevera' una email con il seguente contenuto:</p>\
    %@\
    <br/>\
    </li>\
    <li>Quando qualcuno apre Sapid Chat dopo aver letto questa email, ricevera' un messaggio di presentazione da te:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    Dopo aver spedito un messaggio intrigo e' necessario aspettare che la persona controlli la sua posta elettronica.\
    <p>Buona conversazione con Sapid Chat!\
    <br/>Sapid Chat</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"Il tuo messaggio d'introduzione:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>Ciao!</h4>\
    <p>Qualcuno che conosce il tuo indirizzo email vuole dirti qualcosa e ti ha anonimamente invitato a conversare su SapidChat!</p>\
    <p>Sapid Chat e' un'applicazione per fare interessanti comunicazione che ha la capacita' di invitare anonimamente le persone a conversare (se conosci il loro indirizzo email).\
    <br/><font color=\"red\"><strong>Questa email non e' uno spam!</strong></font> Qualcuno manualmente ha inserito il tuo indirizzo email per farti intrigare e vuole invitarti ad una conversazione su Sapid Chat.</p>\
    %@\
    <p><font color=\"green\"><strong>Se sei interessato a capire chi ti sta' invitando</strong></font> puoi aprere Sapid Chat e vedere quali dei tuoi amici ha inviato a conversare. Forse e' il contrario, qualcuno vuole conoscerti e in qualche modo ha trovato la tua email per intrigarti ;)</p>\
    <p><strong>Importante!</strong> Per vedere il messaggio che hai ricevuto nell'applicazione devi inserire questo indirizzo email quando ti registri.</p>\
    <p>Sapid Chat ti augura un'interessante conversazione!\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    Altre cose che puoi fare:\
    <br/>\
    <ul>\
    <li>Se non sei interessata a chi ti sta invitando a conversare, puoi semplicemente ingnorare l'email. E'un peccato che qualcuno voglia stia aspettando senza ricevere risposta.\
    </li>\
    <li>Se vuoi dire alla persona che non sei interessato a conversare, rispondi semplicemente a questa email inserendo 'NO' nel soggetto  e noi diremo a questa persona che tu non vuoi rispondere al suo invito.\
    </li>\
    <li>Se non vuoi ricevere queste tipo di email da Sapid Chat in futuro, rispondi a questa email inserendo 'MAI' nel soggetto. In questo caso bloccheremo la tua email a questi messaggi intriganti e nessuno sara' in grado di spedirtele in futuro.\
    </li>\
    %@\
    </ul>\
    Nota: L'eleborazione della tua risposta potrebbe richedere del tempo.\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>Questa persona ha inserito un messaggio extra all'invito:</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>Se pensi che il contenuto del messaggio aggiunto all'invito sia osceno, richiami violenza o contenga spam, per favore rispondi a questa email mettendo' CENSURA' nel soggetto. Noi visioneremo il messaggio e bloccheremo l'utente che ti ha invitato il messaggio. In questo caso ci scusiamo per tale comportamento.\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"Componi";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"Scegli";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"Attendere la risposta...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"Nessun messaggio";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"Messaggi immagine";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"Al momento non ci sono nuovi messaggi nella tua lingua(e) da scegliere";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"Km";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"m";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"Miglia";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"Piedi";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"Errore nel caricamento :(";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE;{return @"Blocco nel caricamento immagine";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"Le immagini sono disponibili nella versione completa";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"Caricamento...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"Rispondi";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"Componi un'altro messaggio";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"Altre azioni";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"Cancella";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"Reclama";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"Conferma la cancellazione";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"Cancellare?";}
+(NSString*) LOC_MESSAGES_REPORT_PICKED_UP{return @"%@ ha raccolto il tuo messaggio!";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"Nuovo messaggio";}
+(NSString*) LOC_COMPOSE_MSG_SENDING{return @"Spedizione...";}
+(NSString*) LOC_COMPOSE_DLG_DELETING{return @"Cancellazione...";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_SUCCEEDED{return @"Fatto!";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_FAILED{return @"Errore!";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"Spedito";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"Fonte:";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"Scatta una foto";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"Ruotamento camera";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"Rimuovi la foto";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"La fonte delle immagini non e'sfortunatamente disponibile su questo dispositivo";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"Per favore immettere testo o immagine da spedire";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"Impostazioni";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"Data e ora";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"Formato ora";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"Formato data";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"Account";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"Nome utente";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"Password";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"Lingue";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"Conversazioni";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"Nuovi messaggi";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"Applicazione";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"In piu'";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_TOUR{return @"Introduzione";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"Info applicazione";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Valutazione";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"Per favore immettere nome utente";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"Password corrente";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"Conferma la nuova password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"Cambia";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"Nuova password";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"La password e' stata cambiata";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"Bilancio";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"Versione limitata!";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"Versione completa!";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"Vantaggi della versione completa";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"Ripristinare";}
+(NSString*) LOC_BALANCE_HEADER_APP{return @"Applicazione";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"Il tuo bilancio";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"francobollo";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"francobolli";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"francobolli";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"Ricarica il tuo bilancio";}
+(NSString*) LOC_BALANCE_RESULT_TOPPED_UP{return @"Ricarica effettuata!";}
+(NSString*) LOC_BALANCE_RESULT_ERROR{return @"Si e' verificato un errore";}
+(NSString*) LOC_BALANCE_RESULT_NOTAUTHORIZED{return @"Modalita' di acquisto disabilitata";}
+(NSString*) LOC_BALANCE_RESULT_FULL_ACTIVATED{return @"Aggiornamento riuscito!";}
+(NSString*) LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE{return @"L'azione non e' al momento disponible";}

// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"Italiano";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"Arabo";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"Cinese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_DANISH{ return @"Danese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"Inglese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"Francese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"Tedesco";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"Italiano";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"Giapponese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"Koreano";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"Portoghese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"Russo";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"Spagnolo";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"Ungarese";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"Rumeno";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"Lingue che conosco";}

// error codes
+(NSString*) LOC_ERRORCODE_ERROR{return @"Si e' verificato un errore";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"Email non valida";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"Nome utente gia' esistente";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"Nome utente non trovato";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"Password sbagliata";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"L'email non puo' essere svuotata";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"Si e' verificato un errore nel server";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"Passoword troppo corta (min 5 caratteri)";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"Il nome utente non puo' rimanere vuoto";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"Il testo non puo' rimanere vuoto";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"Credito terminato";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"Le password non corrispondono";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"Password non specificata";}
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"L'email data non e' disponibile per intrigo";}

@end
