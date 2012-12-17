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
    //NSString* currentMessageText;
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
@synthesize btnCancel;
@synthesize btnAttachData;

@synthesize initialMsgGlobalTimstamp;
@synthesize collocutor;

- (void)viewDidLoad
{
    [super viewDidLoad];
	isSending = NO;
    if (self.collocutor.length > 0){
        self.labelTitle.title = self.collocutor;
        self.buttonLanguage.hidden = YES;
    } else {
        self.labelTitle.title = [Lang LOC_COMPOSE_TITLE];
        [self updateLanguageText];
    }
    [LocalizationUtils setTitle:[Lang LOC_COMPOSE_BTN_SEND] forButton:self.btnSend];
    [LocalizationUtils setTitle:[Lang LOC_COMPOSE_BTN_CANCEL] forButton:self.btnCancel];
}

- (void)viewDidUnload
{
    [self setTextMessage:nil];
    [self setSpinner:nil];
    [self setButtonLanguage:nil];
    [self setLabelTitle:nil];
    [self setBtnSend:nil];
    [self setBtnCancel:nil];
    [self setBtnAttachData:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) updateLanguageText{
    [LocalizationUtils setTitle:[Utils getLanguageName:[UserSettings getNewMessagesLanguage] needSelfName:NO] forButton:self.buttonLanguage];
    [self.buttonLanguage sizeToFit];
}

- (IBAction)sendPressed:(id)sender {
    if ([UserSettings premiumUnlocked]
        && self.textMessage.text.length == 0
        && self.imageView.image){
        [self AskToSendOnlyImage];
    } else {
        [self sendMessage];
    }
}

-(void) sendMessage{
    if (!isSending){
        isSending = YES;
            
        [self.spinner startAnimating];
            
        dispatch_queue_t refreshQueue = dispatch_queue_create("compose Queue", NULL);
        dispatch_async(refreshQueue, ^{
            Message* msg = [self prepareMessage];
            ErrorCodes msgSent = [DataManager sendMessage:msg];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.spinner stopAnimating];
                if (msgSent == OK){
                        [self.composeHandler composeCompleted:msg];
                        [self dismissModalViewControllerAnimated:YES];
                } else{
                
                }
                isSending = NO;
            });
        });
        dispatch_release(refreshQueue);
    }
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)languagePressed:(id)sender {
    [SettingsManager callNewMessagesLanguageScreenOverViewController:self];
}

- (IBAction)attachDataPressed:(id)sender {
    NSString* title = @"New image";
    NSString* cancel = @"Cancel";
    NSString* takePhoto = @"Take a photo";
    NSString* cameraRoll = @"Camera roll";
    //NSString* claim = [Lang LOC_MESSAGES_DIALOG_ACTIONSHEET_CLAIM];
    UIActionSheet *pickImageActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:takePhoto, cameraRoll, nil];
    [pickImageActionSheet showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
        editingInfo:(NSDictionary *)editingInfo{
    
    //imageView.image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.imageView setImage:image];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	if(buttonIndex == 0) { // take photo
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	} else { // camera roll
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	}
    
	[self presentModalViewController:picker animated:YES];
}

-(void) AskToSendOnlyImage{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Send imahe w/o a text?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [self sendMessage];
    }
}

- (void)msgLangControllerToDismiss:(NewMsgLanguageVC *)msgLangController{
    [self updateLanguageText];
    [msgLangController dismissModalViewControllerAnimated:YES];
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
    
    if (self.imageView.image){
        msg.attachmentData = UIImagePNGRepresentation(self.imageView.image);
    }
    
    msg.initial_message_global_timestamp = initialMsgGlobalTimstamp;
    return msg;
}
@end
