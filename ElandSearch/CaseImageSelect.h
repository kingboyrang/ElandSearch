//
//  CaseImageSelect.h
//  ElandSearch
//
//  Created by rang on 13-8-11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBImagePickerController.h"
#import "CaseCameraImage.h"

@protocol CaseImageSelectDelegate <NSObject>
@optional
-(void)finishPhotos:(NSArray*)photos;
-(void)finishCameraPhoto:(UIImage*)image;
@end


@interface CaseImageSelect : NSObject<UIActionSheetDelegate,QBImagePickerControllerDelegate>{
    CaseCameraImage *cameraImage;
}
@property(nonatomic,assign) id<CaseImageSelectDelegate> delegate;
@property(nonatomic,retain) UIActionSheet *actionSheet;
@property(nonatomic,assign) UIViewController *showInController;
@property(nonatomic,assign) int maxImageCount;
-(void)showSheet;
-(void)cameraPhoto:(UIImage*)image;
@end
