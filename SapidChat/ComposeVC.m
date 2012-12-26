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
    MainNavController* navCon;
}

@end

@implementation ComposeVC
@synthesize textMessage;
@synthesize spinner;
@synthesize imageView;
@synthesize buttonLanguage;
@synthesize labelTitle;
@synthesize btnSend;
@synthesize btnAttachData;

@synthesize initialMsgGlobalTimstamp;
@synthesize collocutor;

- (void)viewDidLoad
{
    [super viewDidLoad];
	isSending = NO;
    isImageSet = NO;
    if (self.collocutor.length > 0){
        self.labelTitle.text = [DataManager loadUser:collocutor].nickname;
        self.buttonLanguage.hidden = YES;
    } else {
        self.labelTitle.text = [Lang LOC_COMPOSE_TITLE];
        [self updateLanguageText];
    }
    
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
    [self setSpinner:nil];
    [self setButtonLanguage:nil];
    [self setLabelTitle:nil];
    [self setBtnSend:nil];
    [self setBtnAttachData:nil];
    [self setImageView:nil];
    [self setBtnProInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) updateLanguageText{
    [LocalizationUtils setTitle:[Utils getLanguageName:[UserSettings getNewMessagesLanguage] needSelfName:NO] forButton:self.buttonLanguage];
    [self.buttonLanguage sizeToFit];
}

- (IBAction)sendPressed:(id)sender {
    if (self.textMessage.text.length > 0 || isImageSet){
        [self sendMessage];
    }
}

-(void) sendMessage{
    if (!isSending){
        isSending = YES;
            
        [self.spinner startAnimating];
        self.labelInfoText.text = [Lang LOC_INTRIGUE_SERVICEMSG_SENDING_INPROGRESS];
            
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            Message* msg = [self prepareMessage];
            ErrorCodes msgSent = [DataManager sendMessage:msg];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.labelInfoText.text = [Utils getErrorDescription:msgSent];
                [self.spinner stopAnimating];
                if (msgSent == OK){
                        [self.composeHandler composeCompleted:msg];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else{
                
                }
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    }
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [self.imageView setImage:image];
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
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
    bool sourceExists = NO;
	if(buttonIndex == 0) { // take photo
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            sourceExists = YES;
        }
	} else { // camera roll
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            sourceExists = YES;
        }
	}
    
    if (sourceExists){
        [self presentViewController:picker animated:YES completion:nil];
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
