//
//  ComposeVC.m
//  SapidChat
//
//  Created by Viktor Sydorenko on 9/1/12.
//  Copyright (c) 2012 Viktor Sydorenko. All rights reserved.
//

#import "ComposeVC.h"
#import "DataManager.h"
#import "MainNavController.h"
#import "UserSettings.h"
#import "Utils.h"
#import "LocalizationUtils.h"
#import "SettingsManager.h"
#import "Lang.h"

@interface ComposeVC (){
    bool isSending;
    bool isImageSet;
    bool dontDismiss;
    MainNavController* navCon;
    UIImagePickerController *imagePicker;
}

@end

@implementation ComposeVC
@synthesize textMessage;
@synthesize imageView;
@synthesize buttonLanguage;
@synthesize btnSend;
@synthesize btnAttachData;

@synthesize initialMsgGlobalTimstamp;
@synthesize collocutor;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utils createBackButtonWithSelectorBackPressedOnTarget:self];
    
    [Utils setBackgroundFromPatternForView:self.view];
    
	isSending = NO;
    isImageSet = NO;
    dontDismiss = NO;
    if (self.collocutor.length > 0){
        self.title = [DataManager loadUser:collocutor].nickname;
        self.buttonLanguage.hidden = YES;
    } else {
        self.title = [Lang LOC_COMPOSE_TITLE];
        [self updateLanguageText];
    }
    
    imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
    
    [LocalizationUtils setTitle:[Lang LOC_COMPOSE_BTN_SEND] forButton:self.btnSend];
    [LocalizationUtils setTitle:[Lang LOC_COMPOSE_BTN_ATTACH_IMG] forButton:self.btnAttachData];
}

-(void) viewWillAppear:(BOOL)animated{
    if ([UserSettings premiumUnlocked]){
        self.btnAttachData.enabled = YES;
        self.labelInfoText.hidden = YES;
        self.btnProInfo.hidden = YES;
    } else {
        self.btnAttachData.enabled = NO;
        self.labelInfoText.text = [Lang LOC_MESSAGES_CELL_IMAGES_ARE_IN_PRO_MODE];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidUnload
{
    [self setTextMessage:nil];
    [self setButtonLanguage:nil];
    [self setBtnSend:nil];
    [self setBtnAttachData:nil];
    [self setImageView:nil];
    [self setBtnProInfo:nil];
    navCon = nil;
    imagePicker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) updateLanguageText{
    [LocalizationUtils setTitle:[Utils getLanguageName:[UserSettings getNewMessagesLanguage] needSelfName:NO] forButton:self.buttonLanguage];
    [self.buttonLanguage sizeToFit];
}

- (IBAction)sendPressed:(id)sender {
    self.textMessage.text = [Utils trimWhitespaces:self.textMessage.text];
    if (self.textMessage.text.length > 0 || isImageSet){
        [self.textMessage resignFirstResponder];
        [self sendMessage];
    } else {
        [navCon showInfoBarWithNeutralMessage:[Lang LOC_COMPOSE_INFOMSG_MESSAGE_IS_EMPTY]];
    }
}

-(void) sendMessage{
    if (!isSending){
        isSending = YES;
        
        navCon.hud.delegate = self;
        [self.view addSubview:navCon.hud.view];
        
        [navCon.hud setCaption:[Lang LOC_COMPOSE_MSG_SENDING]];
        [navCon.hud setActivity:YES];
        [navCon.hud show];
            
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            Message* msg = [self prepareMessage];
            ErrorCodes msgSent = [DataManager sendMessage:msg];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (msgSent == OK){
                    dontDismiss = NO;
                    [self composeCompletedWithMessage:msg];
                } else{
                    dontDismiss = YES;
                    [self composeCompletedWithMessage:nil];
                }
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    }
}

-(void) composeCompletedWithMessage:(Message*)msg{
    if (msg){
        [self.composeHandler composeCompleted:msg];
    }
    
    [navCon.hud setActivity:NO];
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
        if (msg){
            [navCon.hud setCaption:[Lang LOC_COMPOSE_MSG_OPERATION_SUCCEEDED]];
            [navCon.hud setImage:[UIImage imageNamed:@"whiteCheckmark.png"]];
            [navCon.hud setHideSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
        } else {
            [navCon.hud setCaption:[Lang LOC_COMPOSE_MSG_OPERATION_FAILED]];
            //[navCon.hud setImage:[UIImage imageNamed:@"whiteErrorCross.png"]];
            //[navCon.hud setHideSound:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"wav"]];
        }
        [navCon.hud update];
        [navCon.hud hideAfter:0.4];
    } else {
        [self backPressed];
    }
}

- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hudDidDisappear:(ATMHud *)_hud{
    if (!dontDismiss){
        [self backPressed];
    }
}

- (IBAction)languagePressed:(id)sender {
    [SettingsManager callNewMessagesLanguageScreenOverViewController:self];
}

- (IBAction)attachDataPressed:(id)sender {
    [self.textMessage resignFirstResponder];
    NSString* title = [Lang LOC_COMPOSE_ACTSHEET_TITLE_PICKFROM];
    NSString* cancel = [Lang LOC_COMPOSE_ACTSHEET_CANCEL];
    NSString* takePhoto = [Lang LOC_COMPOSE_ACTSHEET_CAMERA];
    NSString* cameraRoll = [Lang LOC_COMPOSE_ACTSHEET_CAMERA_ROLL];
    UIActionSheet *pickImageActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:takePhoto, cameraRoll, nil];
    [pickImageActionSheet showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
        editingInfo:(NSDictionary *)editingInfo{
    
    //imageView.image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    isImageSet = YES;
    
    CGSize newSize = CGSizeMake(2*self.imageView.bounds.size.width, 2*self.imageView.bounds.size.height);
    UIImage *newImage = [Utils imageWithImage:image scaledToSizeWithSameAspectRatio:newSize];
    [self.imageView setImage:newImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    isImageSet = NO || isImageSet;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2){ // cancel button
        return;
    }
    
    bool sourceExists = NO;
	if(buttonIndex == 0) { // take photo
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            sourceExists = YES;
        }
	} else { // camera roll
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            sourceExists = YES;
        }
	}
    
    if (sourceExists){
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self showImageSourceNotAvailable];
    }
}

-(void)showImageSourceNotAvailable{
    [[[UIAlertView alloc] initWithTitle:@"" message:[Lang LOC_COMPOSE_ALERT_SOURCE_UNAVAILABLE] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

- (void)msgLangControllerToDismiss:(NewMsgLanguageVC *)msgLangController{
    [self updateLanguageText];
    [msgLangController dismissViewControllerAnimated:YES completion:nil];
}

// MainNavController is used for retrieving location coordinates
-(void)setNavigationController:(MainNavController*)controller{
    navCon = controller;
}

-(Message*) prepareMessage{
    Message* msg = [[Message alloc] init];
    msg.from = [UserSettings getEmail];
    msg.to = self.collocutor;
    msg.text = self.textMessage.text;
    msg.type = MSG_REGULAR;
    msg.when = [[NSDate date] timeIntervalSinceReferenceDate];
    
    msg.latitude = navCon.latitude;
    msg.longitude = navCon.longitude;
    
    if (isImageSet){
        msg.attachmentData = [Utils compressImage:self.imageView.image];
    }
    
    msg.initial_message_global_timestamp = initialMsgGlobalTimstamp;
    return msg;
}
@end
