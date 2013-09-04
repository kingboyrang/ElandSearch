//
//  CaseImageSelect.m
//  ElandSearch
//
//  Created by rang on 13-8-11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseImageSelect.h"

@implementation CaseImageSelect
@synthesize actionSheet=_actionSheet;
@synthesize showInController;
@synthesize delegate;
@synthesize maxImageCount;
-(void)dealloc{
    [_actionSheet release];
    [super dealloc];
}
-(id)init{
    if (self=[super init]) {
        self.maxImageCount=3;
    }
    return self;
}
-(void)showSheet{
    if (!self.actionSheet) {
        self.actionSheet=[[UIActionSheet alloc]
                          initWithTitle:@"選者圖片"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"相冊",@"拍照", nil];
        self.actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        self.actionSheet.alpha=0.7;
    }
    if (self.showInController.tabBarController) {
        [self.actionSheet showFromTabBar:self.showInController.tabBarController.tabBar];
    }else{
        [self.actionSheet showInView:self.showInController.view];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//相册
        QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsMultipleSelection = YES;
        imagePickerController.limitsMaximumNumberOfSelection=YES;
        imagePickerController.maximumNumberOfSelection=self.maxImageCount;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
        [self.showInController presentViewController:navigationController animated:YES completion:NULL];
        [imagePickerController release];
        [navigationController release];
    }
    if (buttonIndex==1) {//拍照
        if (self.maxImageCount==0) {
            return;
        }
        if (!cameraImage) {
            cameraImage=[[CaseCameraImage alloc] init];
            cameraImage.imageSelectDelegate=self;
        }
        [cameraImage showCameraInController:self.showInController];
    }
}
-(void)cameraPhoto:(UIImage*)image{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishCameraPhoto:)]) {
        [self.delegate finishCameraPhoto:image];
    }
}
#pragma mark - QBImagePickerControllerDelegate
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    if(imagePickerController.allowsMultipleSelection) {
        NSArray *mediaInfoArray = (NSArray *)info;
        NSMutableArray *photos=[NSMutableArray array];
        for (NSDictionary *item in mediaInfoArray) {
            UIImage *image=(UIImage*)[item objectForKey:UIImagePickerControllerOriginalImage];
            [photos addObject:image];
        }
        if (self.delegate&&[self.delegate respondsToSelector:@selector(finishPhotos:)]) {
            [self.delegate finishPhotos:photos];
        }
    } else {
        NSDictionary *mediaInfo = (NSDictionary *)info;
        NSLog(@"Selected: %@", mediaInfo);
    }
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}
- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return [NSString stringWithFormat:@"%d張照片,最多選%d張", numberOfPhotos,self.maxImageCount];
}
@end
