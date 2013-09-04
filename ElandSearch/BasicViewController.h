//
//  BasicViewController.h
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
#import "FPPopoverController.h"
#import "TKLabelTextFieldCell.h"
#import "CaseImageSelect.h"
#import "MKPhotoScroll.h"
#import "TKEmptyCell.h"
@interface BasicViewController : UIViewController<FPPopoverControllerDelegate,CaseImageSelectDelegate,MKPhotoScrollDelegate>{
@private
    FPPopoverController *popoverCity;
    FPPopoverController *popoverCircular;
    TKLabelTextFieldCell *cellCircular;
    TKLabelTextFieldCell *cellCity;
    TKLabelTextFieldCell *cellPhotos;
    CaseImageSelect *imageSelect;
    MKPhotoScroll *photoScroll;
}
@property(nonatomic,readonly) MKPhotoScroll *imagesScroll;

-(RTLabelComponentsStructure*)labelShowName:(NSString*)title required:(BOOL)required;
-(void)popoverVillage:(id)sender;
-(void)popoverCircularType:(id)sender type:(NSString*)type level:(int)level;
-(void)chooseImagesTap;
-(void)scrollImageCount:(NSInteger)count;

-(void)initPhotosScroll;
//子类方法重写
-(void)loadPhotos;
-(void)deletePhotoScrollCell;

//重设返回按钮
-(void)resetNavigationBarBack;

-(TKLabelTextFieldCell*)getCellCircular;
-(TKLabelTextFieldCell*)getCellCircular:(NSString*)title;
-(TKLabelTextFieldCell*)getCellCity;
-(TKLabelTextFieldCell*)getCellPhotos;
-(TKLabelTextFieldCell*)getCellPhotos:(NSString*)title;
-(TKLabelTextFieldCell*)getCellPWD;
@end
