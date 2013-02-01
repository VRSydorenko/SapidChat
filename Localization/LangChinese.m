//
//  LangEnglish.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/24/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "LangChinese.h"

@implementation LangChinese

// universal
+(NSString*) LOC_UNI_APP_NAME {return @"Sapid Chat";}
+(NSString*) LOC_UNI_CANCEL{return @"取消";}
+(NSString*) LOC_UNI_OK{return @"好";}
+(NSString*) LOC_UNI_EMAIL{return @"邮箱";}
+(NSString*) LOC_UNI_YES{return @"是";}
// info
+(NSString*) LOC_INFO_FEATURE_TITLE_DISTANCE{ return @"和你朋友的距离";}
+(NSString*) LOC_INFO_FEATURE_DESCR_DISTANCE{
    return @"你只可以猜测你的信息被发送到了星球的哪里，但是如果有人回复你的话你就可以看到你们之间的距离，可能是几千（千米或者英里）或者只有几米或者几步。";
}
+(NSString*) LOC_INFO_FEATURE_NOTE_DISTANCE{ return @"距离只有在你和你的伙伴都有定位服务的情况下才可以看到。";}
+(NSString*) LOC_INFO_FEATURE_TITLE_IMAGE{ return @"在信息中插入图片";}
+(NSString*) LOC_INFO_FEATURE_DESCR_IMAGE{ return @"如今发送图片已经不是新的发明了，但是比起要他们的电子邮箱发送图片，更简单的是直接在聊天框里点击两下图片";}
// about screen
+(NSString*) LOC_ABOUT_VIKTOR_SYDORENKO{ return @"Viktor Sydorenko";}
+(NSString*) LOC_ABOUT_DESIGNER{ return @"Dmitriy Pohodyaev";}
+(NSString*) LOC_ABOUT_IDEA_AND_DEVELOPMENT{return @"发展和主题";}
+(NSString*) LOC_ABOUT_DESIGN{return @"图画";}
+(NSString*) LOC_ABOUT_LOCALIZATION{return @"定位";}
+(NSString*) LOC_ABOUT_ALSO{return @"而且";}
+(NSString*) LOC_ABOUT_ICONS{return @"图标";}
// first launch
+(NSString*) LOC_FIRSTLAUNCH_APPLANGUAGE{ return @"应用语言";}
+(NSString*) LOC_FIRSTLAUNCH_BTN_NEXT{ return @"下一步";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_WELCOME{ return @"欢迎来到Sapid Chat!在这里你可以很简单的找到交流的乐趣！这是十分方便的！";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMPOSE{ return @"你新建一条信息然后把它放在信息发送队里";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_PICKITUP{ return @"有人随机选择了你的信息然后回复";}
+(NSString*) LOC_FIRSTLAUNCH_LABEL_COMMUNICATE{ return @"开始对话！";}
// registration screen
+(NSString*) LOC_REGISTATOR_TITLE{return @"注册";}
+(NSString*) LOC_REGISTATOR_BTN_NEXT { return @"下一步";}
+(NSString*) LOC_REGISTATOR_BTN_REGISTER { return @"创建账户！";}
+(NSString*) LOC_REGISTATOR_BTN_CLOSE { return @"完成！";}
+(NSString*) LOC_REGISTATOR_BTN_BACK { return @"退回";}
+(NSString*) LOC_REGISTATOR_FIELD_PASSWORD { return @"密码";}
+(NSString*) LOC_REGISTATOR_FIELD_NICK { return @"昵称";}
+(NSString*) LOC_REGISTATOR_TEXT_SPECIFYNICK { return @"因为沟通是随机的，制定的昵称会帮助你区分谈话的伙伴";}
+(NSString*) LOC_REGISTATOR_LABEL_SELECT_LANGS { return @"选择你可以写的语言";}
+(NSString*) LOC_REGISTATOR_ERR_EMPTYNICK{return @"昵称不可用";}
+(NSString*) LOC_REGISTATOR_ERR_INVALIDNICK{return @"这个昵称不可用";}
+(NSString*) LOC_REGISTATOR_ERR_NOLANGS_SELECTED{return @"没有符合的语言";}
+(NSString*) LOC_REGISTATOR_SUCCESS{return @"成功完成";}
+(NSString*) LOC_REGISTATOR_WHY_EMAIL{return @"为什么要用邮箱登录Ｓａｐｉｄｃｈａｔ\r\
    - 重新设定密码\r\
    - 关于神秘的特性\r\r\
    Ｓａｐｉｄｃｈａｔ不会发送垃圾邮件也不会透露用户信息";}
// login screen
+(NSString*) LOC_LOGIN_BTN_LOGIN    {return @"登录";}
+(NSString*) LOC_LOGIN_BTN_REGISTRATION {return @"注册";}
+(NSString*) LOC_LOGIN_BTN_FORGOTPASSWORD {return @"忘记密码？";}
+(NSString*) LOC_LOGIN_TXT_PASSWORD_PLACEHOLDER {return @"密码";}
// info screen
+(NSString*) LOC_INFO_SCREEN_TITLE_ABOUT_INTRIGUE{return @"关于神秘";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE{return @"你可以随机邀请人来对话，你只需要知道你感兴趣的邮箱。你只需要输入邮箱地址然后点击神秘邮件按钮，然后邮件会自动发送到你感兴趣的人的邮箱里，你也可以选择在邀请里增加附加信息。\r\r\
    目前Ｓａｐｉｄｃｈａｔ只支持ＩＳＯ系统，所以请确定你的朋友有ｉｐｈｏｎｅ或者ｉｐａｄ,这样才可以确保他们可以通过Ｓａｐｉｄｃｈａｔ回复你";}
+(NSString*) LOC_INFO_SCREEN_TEXT_ABOUT_INTRIGUE_CONDITIONS{return @"邮票是在Ｓａｐｉｄｃｈａｔ里面的货币，每发送一个神秘邮件就需要一长邮票，每个注册的新用户可以免费得到１０张邮票，你可以在余额选项里查看。";}
// main screen
+(NSString*) LOC_MAIN_CELL_MESSAGES {return @"信息";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_T_NEWMESSAGES {return @"新信息： %d";}
+(NSString*) LOC_MAIN_CELL_MESSAGES_NO_NEWMESSAGES {return @"没有新信息";}
+(NSString*) LOC_MAIN_CELL_INTRIGUE {return @"神秘";}
+(NSString*) LOC_MAIN_CELL_BALANCE {return @"购物夹";}
+(NSString*) LOC_MAIN_BUTTON_LOGOUT{return @"登出";}
// restore pass screen
+(NSString*) LOC_RESTORE_SCREEN_TITLE{return @"重新设定密码";}
+(NSString*) LOC_RESTORE_LABEL_INSTRUCTION{return @"请输入注册的邮箱：";}
+(NSString*) LOC_RESTORE_BTN_GO{return @"发送密码";}
+(NSString*) LOC_RESTORE_ALERT_STATE{return @"密码已经发送到邮箱";}
+(NSString*) LOC_RESTORE_ALERT_BTN_OK{return @"关闭";}
+(NSString*) LOC_RESTORE_EMAIL_TEMPL{return @"你好， %@!\r您向更改密码，我们稍候发给您\r您的密码：%@\r希望您可以享受Ｓａｐｉｄｃｈａｔ!\rhttp://sapidchat.com/\rinfo@sapidchat.com";}
// intrigue cell screen
+(NSString*) LOC_INTRIGUE_LABEL_ENTERMAIL{return @"输入你想用神秘邮件邀请来聊天的人的邮箱地址：";}
+(NSString*) LOC_INTRIGUE_LABEL_CONDITIONS{return @"发送：%d %@; 余额: %d";}
+(NSString*) LOC_INTRIGUE_BTN_SEND{return @"神秘邮件！";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_OK{return @"发送";}
+(NSString*) LOC_INTRIGUE_SERVICEMSG_SENDING_YOURSELF_OK{return @"发送到你的邮箱地址";}
+(NSString*) LOC_INTRIGUE_EDIT_PLACEHOLDER_MSG{return @"其他信息（选填）";}
+(NSString*) LOC_INTRIGUE_COLLOCUTOR_MESSAGE{return @"嗨！\r我给你发了神秘邮件 ;)";}
+(NSString*) LOC_INTRIGUE_MAIL_SUBJECT{return @"从Ｓａｐｉｄｃｈａｔ来的神秘邀请";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM_YOURSELF{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL], @"%@", [self LOC_INTRIGUE_COLLOCUTOR_MESSAGE], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_YOURSELF_TEMPL{return @"你想变的神秘吗？ 当你发送神秘邮件的时候将会实现\
    <ul type=\"Circle\">\
    <li>\
    <p>你的伙伴将会收到一封邮件伴随着的内容：</p>\
    %@\
    <br/>\
    </li>\
    <li>当你打开Ｓａｐｉｄｃｈａｔ读完邮件以后你会看到你的介绍:\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>\
    %@\
    </li>\
    </ul>\
    寄完神秘信件以后，需要等到那个人查看邮件，看到神秘信件以后打开Ｓａｐｉｄｃｈａｔ回复你\
    <p>希望你有一段有趣的谈话！\
    <br/>Ｓａｐｉｄｃｈａｔ！</p><hr></br>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMYOURSELF_TEMPL{return @"而且你的介绍信息：\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_DEFAULT{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], @"", @""];}
+(NSString*) LOC_INTRIGUE_MAIL_CONTENT_CUSTOM{return [NSString stringWithFormat:[self internal_INTRIGUE_MAIL_CONTENT_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL], [self internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE]];}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_TEMPL{return @"<div style=\"padding:10px;border: solid 1px gray;font-family:Verdana;\">\
    <font style=\"font-size:10pt;\">\
    <h4>嗨！</h4>\
    <p>在Ｓａｐｉｄｃａｈｔ里一些人知道你的邮箱地址，会告诉你然后邀请你一起对话！</p>\
    <p>Ｓａｐｉｄｃｈａｔ是一个程序可以让你随机邀请人们一起讨论聊天。（如果你知道他们的邮箱地址）\
    <br/><font color=\"red\"><strong>这个邮件不是垃圾邮件</strong></font> 一些人人工打入你的邮箱然后邀请你一起在Ｓａｐｉｄｃｈａｔ里聊天</p>\
    %@\
    <p><font color=\"green\"><strong>如果你对神秘邀请你的人有兴趣的话，</strong></font>, 你可以打开Ｓａｐｉｄｃｈａｔ看哪个朋友发了邀请给你，或者还有一种方法，一些人想要知道你的话会找到你的邮箱地址</p>\
    <p><strong>注意！</strong> 为了可以看到信息你需要使用你的邮箱地址注册</p>\
    <p>Ｓａｐｉｄｃｈａｔ希望你有一段有趣的谈话\
    <br/><a href=\"http://sapidchat.com/\">sapidchat.com</a>\
    <br/><a href=\"mailto:intrigue@sapidchat.com\">intrigue@sapidchat.com</a></p>\
    </font>\
    <hr/>\
    <font style=\"font-size:9pt;\">\
    其他的事情：\
    <br/>\
    <ul>\
    <li>如果你对邀请你的人不感兴趣的话，很简单你可以忽略邮件，别人将收不到邮件回复\
    </li>\
    <li>如果你想通知一些你不感兴趣的人的话，只要回复邮件在主题上打\"ＮＯ\"，我们将会通知那个人你不想回应他的邀请\
    </li>\
    <li>如果你不想收到Ｓａｐｉｄｃｈａｔ的邮件的话，只要回复这封邮件在主题上写\"NEVER\"，我们将会屏蔽掉所有神秘的信息，未来您也会收不到。\
    </li>\
    %@\
    </ul>\
    注解：回复可能会需要一些时间\
    </font>\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTOMMSG_TEMPL{return @"<p>那个人同时在邀请里面加了另外的信息</p>\
    <div style=\"background:#FFFAF0;padding:10px;border: solid 1px gray;font-size:11pt;\">\
    %@\
    </div>";}
+(NSString*) internal_INTRIGUE_MAIL_CONTENT_CUSTMMSG_CARE{return @"<li>如果你认为有些信息邀请是不好的，请打电话或者是放到垃圾邮件里，然后回复这个ｅｍａｉｌ在主题里写\"CENSORED\"这个单词,我们会去检查是那个用户发给了您邮件，关于这种事情我们郑重的道歉。\
    </li>";}
// messages screen
+(NSString*) LOC_MESSAGES_TITLE {return [self LOC_MAIN_CELL_MESSAGES];}
+(NSString*) LOC_MESSAGES_BTN_COMPOSE {return @"写信";}
+(NSString*) LOC_MESSAGES_BTN_PICKNEW {return @"选择新的信息";}
+(NSString*) LOC_MESSAGES_CELL_WAIT_FOR_REPLY {return @"等待恢复...";}
+(NSString*) LOC_MESSAGES_CELL_NO_RECORDS{return @"还没有信息";}
+(NSString*) LOC_MESSAGES_CELL_MSG_WITH_ATTACHMENT{return @"图片信息";}
+(NSString*) LOC_MESSAGES_CELL_NO_MSG_TOPICKUP{return @"目前在你选择的语言里面没有信息";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_KILOMETERS{return @"千米";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_METERS{return @"米";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_MILES{return @"英里";}
+(NSString*) LOC_MESSAGES_CELL_DISTANCE_FEETS{return @"脚";}
+(NSString*) LOC_MESSAGES_CELL_ERROR_LOADING_IMAGE{return @"加载错误：（";}
+(NSString*) LOC_MESSAGES_CELL_TAPTOLOAD_IMAGE;{return @"点击加载图片";}
+(NSString*) LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE{return @"完整版中可以图片可用";}
+(NSString*) LOC_MESSAGES_CELL_LOADING{return @"加载中...";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_REPLY {return @"回复";}
+(NSString*) LOC_MESSAGES_MESSAGES_BTN_COMPOSE_ONE_MORE {return @"再写多一个";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_TITLE{return @"更多功能";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_DELETE{return @"删除";}
+(NSString*) LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM{return @"要求";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_TITLE{return @"确认删除";}
+(NSString*) LOC_MESSAGES_ALERT_DELETION_QUESTION{return @"删除？";}
+(NSString*) LOC_MESSAGES_REPORT_PICKED_UP{return @"%@ 选择信息！";}
// compose screen
+(NSString*) LOC_COMPOSE_TITLE{return @"新信息";}
+(NSString*) LOC_COMPOSE_MSG_SENDING{return @"发送中...";}
+(NSString*) LOC_COMPOSE_DLG_DELETING{return @"删除中...";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_SUCCEEDED{return @"完成！";}
+(NSString*) LOC_COMPOSE_MSG_OPERATION_FAILED{return @"错误！";}
+(NSString*) LOC_COMPOSE_BTN_SEND{return @"发送";}
+(NSString*) LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM{return @"资源";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA{return @"拍照";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CAMERA_ROLL{return @"摄像头";}
+(NSString*) LOC_COMPOSE_ACTSHEET_CLEAR_PIC{return @"删除图片";}
+(NSString*) LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE{return @"不幸的是图片在这个设备上不可用";}
+(NSString*) LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY{return @"请输入文字或图片发送";}
// settings
+(NSString*) LOC_SETTINGS_WINDOWTITLE_SETTINGS{return @"设置";}
// section date & time
+(NSString*) LOC_SETTINGS_SECTIONHEADER_DATEnTIME {return @"日期&时间";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_TIMEFORMAT {return @"时间格式";}
+(NSString*) LOC_SETTINGS_SECTION_DATEnTIME_DATEFORMAT {return @"日期格式";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_ACCOUNT {return @"账户";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_NICKNAME {return @"昵称";}
+(NSString*) LOC_SETTINGS_SECTION_ACCOUNT_PASSWORD {return @"密码";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_LANGUAGES {return @"语言";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_CONVERSATION {return @"对话";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_NEWMESSAGES {return @"新信息";}
+(NSString*) LOC_SETTINGS_SECTION_LANGUAGES_APPLICATION {return @"应用程序";}
+(NSString*) LOC_SETTINGS_SECTIONHEADER_MORE{return @"更多";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_ABOUT{return @"关于ａｐｐ";}
+(NSString*) LOC_SETTINGS_SECTION_MORE_RATE{return @"Ｓａｐｉｄ　Ｃｈａｔ　评价";}

// section account
+(NSString*) LOC_SETTINGS_POPUPEDIT_NICK_PLACEHOLDER_ENTERHERE{return @"请输入昵称";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CURRENT{return @"当前密码";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_PLACEHLDR_CONFIRM{return @"确认新密码";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_BTN_OK{return @"修改";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_SCREEN_TITLE{return @"新密码";}
+(NSString*) LOC_SETTINGS_CHANGEPASS_RESULT_MSG{return @"密码修改成功";}

// screen balance
+(NSString*) LOC_BALANCE_SCREEN_TITLE{return @"余额";}
+(NSString*) LOC_BALANCE_PRO_NO{return @"限量版！";}
+(NSString*) LOC_BALANCE_PRO_YES{return @"完整版！";}
+(NSString*) LOC_BALANCE_WHAT_IN_PRO{return @"完整版的好处";}
+(NSString*) LOC_BALANCE_BTN_RESTORE{return @"重新启动";}
+(NSString*) LOC_BALANCE_HEADER_APP{return @"应用程序";}
+(NSString*) LOC_BALANCE_HEADER_YOUR_BALANCE{return @"你的余额";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_1{return @"邮票";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_3{return @"邮票";}
+(NSString*) LOC_BALANCE_POSTSTAMPS_5{return @"邮票";}
+(NSString*) LOC_BALANCE_HEADER_TOPUP{return @"请充值";}
+(NSString*) LOC_BALANCE_RESULT_TOPPED_UP{return @"起来";}
+(NSString*) LOC_BALANCE_RESULT_ERROR{return @"发生错误";}
+(NSString*) LOC_BALANCE_RESULT_NOTAUTHORIZED{return @"无法购买";}
+(NSString*) LOC_BALANCE_RESULT_FULL_ACTIVATED{return @"更新成功";}
+(NSString*) LOC_BALANCE_RESULT_ACTION_IMPOSSIBLE{return @"此功能暂时不能用";}

// settings - languages
+(NSString*) LOC_SYS_LANGUAGE_SELFNAME{ return @"中文";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ARABIC{ return @"阿拉伯语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_CHINESE{ return @"中文";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ENGLISH{ return @"英语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_FRENCH{ return @"法语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_GERMAN{ return @"德语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HINDI{ return @"北印度语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ITALIAN{ return @"意大利语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_JAPANESE{ return @"日语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_KOREAN{ return @"韩语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_PORTUGESE{ return @"葡萄牙语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_RUSSIAN{ return @"俄语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_SPANISH{ return @"西班牙语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_HUNGARIAN{ return @"匈牙利语";}
+(NSString*) LOC_SETTINGS_LANGUAGES_ROMANIAN{ return @"罗马尼亚语";}

// separate settings
+(NSString*) LOC_SEPSETTINGS_NEWMSGLANG_BTN_TO_LANGS_YOU_KNOW{ return @"我知道的语言";}

// error codes
+(NSString*) LOC_ERRORCODE_ERROR{return @"发生错误";}
+(NSString*) LOC_ERRORCODE_INVALID_EMAIL{return @"邮箱地址无效";}
+(NSString*) LOC_ERRORCODE_USER_EXISTS{return @"用户已存在";}
+(NSString*) LOC_ERRORCODE_NO_SUCH_USER{return @"用户不存在";}
+(NSString*) LOC_ERRORCODE_WRONG_PASSWORD{return @"密码错误";}
+(NSString*) LOC_ERRORCODE_EMAIL_NOT_SPECIFIED{return @"邮箱不能为空";}
+(NSString*) LOC_ERRORCODE_AMAZON_SERVICE_ERROR{return @"服务器故障";}
+(NSString*) LOC_ERRORCODE_PASSWORD_TOO_SHORT{return @"密码太短（最少５个字）";}
+(NSString*) LOC_ERRORCODE_LOGIN_NOT_SPECIFIED{return @"用户名不能为空";}
+(NSString*) LOC_ERRORCODE_TEXT_NOT_SPECIFIED{return @"文本不能为空";}
+(NSString*) LOC_ERRORCODE_POSTSTAMPS_NOT_ENOUGH{return @"余额不足";}
+(NSString*) LOC_ERRORCODE_PASSWORDS_NOT_MATCH{return @"密码不一致";}
+(NSString*) LOC_ERRORCODE_PASSWORD_NOT_SPECIFIED{return @"密码不符合规定";}
+(NSString*) LOC_ERRORCODE_EMAIL_BLOCKED_FOR_INTRIGUE{return @"发送的邮箱没有神秘功能";}

@end
