//
//  BasicViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BasicViewController.h"
#import "CityViewController.h"
#import "CaseCategories.h"
#import "Photos.h"
#import "MKPhotoBrowser.h"
@interface BasicViewController ()
-(void)selectedTableRowVillage:(NSString*)city;
-(void)selectedTableRowCircularType:(NSString*)guid;
-(void)hidePopoverCity;
-(void)hidePopoverCircular;
@end

@implementation BasicViewController
@synthesize imagesScroll;
-(void)dealloc{
    [super dealloc];
    if (popoverCity) {
        [popoverCity release],popoverCity=nil;
    }
    if (popoverCircular) {
        [popoverCircular release],popoverCircular=nil;
    }
    if (cellCircular) {
        [cellCircular release],cellCircular=nil;
    }
    if (cellCity) {
        [cellCity release],cellCity=nil;
    }
    if (cellPhotos) {
        [cellPhotos release],cellPhotos=nil;
    }
    if (imageSelect) {
        [imageSelect release],imageSelect=nil;
    }
    if (photoScroll) {
        [photoScroll release],photoScroll=nil;
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor colorWithRed:243/255.0 green:239/255.0 blue:228/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)resetNavigationBarBack{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"back";
    self.navigationItem.backBarButtonItem = backItem;
    [backItem release];
}
-(TKLabelTextFieldCell*)getCellCircular{
    return [self getCellCircular:@"案件分類:"];
}
-(TKLabelTextFieldCell*)getCellCircular:(NSString*)title{
    if(!cellCircular){
        cellCircular=[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cellCircular.label.componentsAndPlainText=[self labelShowName:title required:YES];
        UIImage *img=[UIImage imageNamed:@"arrow_down.png"];
        UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
        cellCircular.field.enabled=NO;
        cellCircular.field.rightView=imageView;
        cellCircular.field.rightViewMode=UITextFieldViewModeAlways;
        cellCircular.field.placeholder=@"choose category";
    }
    return cellCircular;
}
-(TKLabelTextFieldCell*)getCellCity{
    if (!cellCity) {
        cellCity=[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cellCity.label.componentsAndPlainText=[self labelShowName:@"鄉鎮市別:" required:YES];
        UIImage *img1=[UIImage imageNamed:@"arrow_down.png"];
        UIImageView *imageView1=[[[UIImageView alloc] initWithImage:img1] autorelease];
        cellCity.field.enabled=NO;
        cellCity.field.rightView=imageView1;
        cellCity.field.rightViewMode=UITextFieldViewModeAlways;
        cellCity.field.placeholder=@"choose city";
    }
    return cellCity;
}
-(TKLabelTextFieldCell*)getCellPhotos{
    return [self getCellPhotos:@"案件圖片:"];
}
-(TKLabelTextFieldCell*)getCellPhotos:(NSString*)title{
    if (!cellPhotos) {
        cellPhotos=[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cellPhotos.label.componentsAndPlainText=[self labelShowName:title required:NO];
        UIImage *img2=[UIImage imageNamed:@"arrow_down.png"];
        UIImageView *imageView2=[[[UIImageView alloc] initWithImage:img2] autorelease];
        cellPhotos.field.enabled=NO;
        cellPhotos.field.placeholder=@"最多3張圖片";
        cellPhotos.field.rightView=imageView2;
        cellPhotos.field.rightViewMode=UITextFieldViewModeAlways;
    }
    return cellPhotos;
}
-(TKLabelTextFieldCell*)getCellPWD{
    TKLabelTextFieldCell *cell5= [[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	cell5.label.componentsAndPlainText = [self labelShowName:@"案件密碼:" required:YES];
    cell5.field.secureTextEntry=YES;
	cell5.field.placeholder = @"editable password";
    return cell5;
}
-(MKPhotoScroll*)imagesScroll{
    return photoScroll;
}
-(RTLabelComponentsStructure*)labelShowName:(NSString*)title required:(BOOL)required
{
    NSString *showTitle=[NSString stringWithFormat:@"<font size =16>%@</font>",title];
    NSString *requiredTitle=@"";
    if (required) {
        requiredTitle=@"<font size=16 color='#dd1100'>*</font>";
    }
    NSString *result=[NSString stringWithFormat:@"%@%@",showTitle,requiredTitle];
    RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:result];
    return componentsDS;
}
-(void)chooseImagesTap{
    if (!imageSelect) {
        imageSelect=[[CaseImageSelect alloc] init];
        imageSelect.delegate=self;
        imageSelect.showInController=self;
    }
    if (photoScroll) {
        imageSelect.maxImageCount=3-[photoScroll imageCount];
    }
    [imageSelect showSheet];
}
-(void)initPhotosScroll{
    if (photoScroll) {
        [photoScroll release];photoScroll=nil;
    }
    photoScroll=[[MKPhotoScroll alloc] initWithFrame:CGRectMake(2, 2,300-4, 300-4)];
    photoScroll.delegate=self;
    photoScroll.autoresizesSubviews=YES;
    photoScroll.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}
-(void)loadPhotos{
}
-(void)deletePhotoScrollCell{

}
-(void)scrollImageCount:(NSInteger)count{
    if (count==0) {
        [self deletePhotoScrollCell];
        if (photoScroll) {
            [photoScroll release],photoScroll=nil;
        }
    }
}
#pragma mark CaseImageSelectDelegate
-(void)finishPhotos:(NSArray*)photos{
    [self loadPhotos];
    [photoScroll addRangeImage:photos];
}
-(void)finishCameraPhoto:(UIImage*)image{
    [self loadPhotos];
    [photoScroll addImage:image];
}
#pragma mark MKPhotoScrollDelegate
-(void)imageViewClick:(UIImageView*)imageView imageIndex:(int)index{
    if (photoScroll) {
        NSArray *source=[photoScroll sourceImages];
        if (source) {
            Photos *photo=[[[Photos alloc] init] autorelease];
            [photo addImages:source];
            photo.photoScroll=photoScroll;
            photo.control=self;
            MKPhotoBrowser *browser=[[[MKPhotoBrowser alloc] initWithDataSource:photo andStartWithPhotoAtIndex:index] autorelease];
            UINavigationController *nav=[[[UINavigationController alloc] initWithRootViewController:browser] autorelease];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}
#pragma mark popover controller
-(void)popoverVillage:(id)sender{
    if (!popoverCity) {
        CityViewController *controller=[[[CityViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        popoverCity = [[FPPopoverController alloc] initWithViewController:controller];
        popoverCity.tint=FPPopoverLightGrayTint;
        popoverCity.contentSize = CGSizeMake(200, 300);
        popoverCity.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverCity presentPopoverFromView:sender];
}
-(void)hidePopoverCity{
    if (popoverCity) {
        [popoverCity dismissPopoverAnimated:YES];
    }
}
-(void)hidePopoverCircular{
    if(popoverCircular){
        [popoverCircular dismissPopoverAnimated:YES];
    }
}
-(void)popoverCircularType:(id)sender type:(NSString*)type level:(int)level{
    if (!popoverCircular) {
        CaseCategories *controller=[[[CaseCategories alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.showType=type;
        controller.showLevel=level;
        controller.delegate=self;
        popoverCircular = [[FPPopoverController alloc] initWithViewController:controller];
        popoverCircular.tint=FPPopoverLightGrayTint;
        popoverCircular.contentSize = CGSizeMake(320, 300);
        popoverCircular.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverCircular presentPopoverFromView:sender];
}
#pragma mark FPPopoverControllerDelegate
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];
}
#pragma  mark 私有方法
-(void)selectedTableRowVillage:(NSString*)city{
    if (cellCity) {
        cellCity.field.text=city;
    }
    [self hidePopoverCity];
}
-(void)selectedTableRowCircularType:(NSString*)guid{
    if (cellCircular) {
        cellCircular.field.text=guid;
    }
    [self hidePopoverCircular];
}
@end
