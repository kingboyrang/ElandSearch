//
//  SearchView.m
//  SearchDemo
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SearchView.h"
#import <QuartzCore/QuartzCore.h>
#import "CityViewController.h"
#import "TKButtonCell.h"
#import "RadioViewController.h"
#import "TKLabelCalendarCell.h"
@interface SearchView ()
-(void)loadDataSource;
-(TKLabelTextFieldCell*)getCellCircular;
-(TKLabelTextFieldCell*)getCellCity;
-(void)exitKeyboard;
@end

@implementation SearchView
@synthesize cells=_cells;
@synthesize tableView=_tableView;
@synthesize croller;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
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
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        searchViewFrame=frame;
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderWidth=2.0;
        self.layer.borderColor=[UIColor whiteColor].CGColor;
        self.layer.cornerRadius=8.0;
        //添加阴影
        self.layer.shadowColor =[UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius=8.0;
        
        CGRect rect=self.bounds;
        rect=CGRectInset(rect, 0, 15);
        _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundView=nil;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setAutoresizesSubviews:YES];
        [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self addSubview:_tableView];
        [self loadDataSource];
        
        //searchViewFrame=CGRectMake(frame.origin.x, -1*(frame.origin.y+frame.size.height), frame.size.width, frame.size.height);
    }
    return self;
}
-(void)loadDataSource{
    TKLabelTextFieldCell *cell1=[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.label.componentsAndPlainText=[cell1 labelName:@"案件編號:" required:NO];
    cell1.field.placeholder=@"editable number";
    cell1.field.clearButtonMode=UITextFieldViewModeAlways;
    
    
    TKLabelCalendarCell *cell4=[[TKLabelCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell4.label.componentsAndPlainText=[cell1 labelName:@"日期(起):" required:NO];
    cell4.calendar.popoverText.popoverTextField.placeholder=@"editable date";
    cell4.calendar.datePicker.maximumDate=[NSDate date];
    cell4.calendar.popoverView.popoverTitle=@"開始時間";
    
    TKLabelCalendarCell *cell5=[[TKLabelCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell5.label.componentsAndPlainText=[cell1 labelName:@"日期(束):" required:NO];
    cell5.calendar.popoverText.popoverTextField.placeholder=@"editable date";
    cell5.calendar.datePicker.maximumDate=[NSDate date];
    cell5.calendar.popoverView.popoverTitle=@"結束時間";
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,[self getCellCircular],[self getCellCity],cell4,cell5, nil];
    [cell1 release];
    [cell4 release];
    [cell5 release];
}
-(void)selectedTableRowVillage:(NSString*)city{
    if (cellCity) {
        cellCity.field.text=city;
    }
    [popoverCity dismissPopoverAnimated:YES];
}
-(void)selectedCategory:(NSDictionary*)userinfo{
    if (cellCircular) {
        cellCircular.field.text=[userinfo objectForKey:@"key"];
    }
    [popoverCircular dismissPopoverAnimated:YES];
}
-(void)show{
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    if (!coverView) {
        coverView=[[UIView alloc] initWithFrame:screenRect];
        coverView.backgroundColor=[UIColor darkGrayColor];
        coverView.alpha=0.85;
        coverView.autoresizesSubviews=YES;
        coverView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    [window addSubview:coverView];
    CGRect frame=searchViewFrame;
    frame.origin.y=-1*(searchViewFrame.origin.y+searchViewFrame.size.height);
    self.frame=frame;
    self.autoresizesSubviews=YES;
    self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [window addSubview:self];
    [UIView animateWithDuration:0.5f animations:^(){
        CGRect newframe=self.frame;
        newframe.origin.y=5;
        self.frame=newframe;
    }];

    
}
-(void)hide:(void (^)(void))completed{
    CGRect frame=searchViewFrame;
    frame.origin.y=-1*(searchViewFrame.origin.y+searchViewFrame.size.height);
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [coverView removeFromSuperview];
            [self removeFromSuperview];
            if (completed) {
                completed();
            }
        }
    }];
}
-(NSDictionary*)caseSearchArgs{
    /***
     args.Category=[self.ddlCategory value];
     args.Ctiy=[self.ddlCity value];
     args.SDate=self.bdate.popoverText.popoverTextField.text;
     args.EDate=self.edate.popoverText.popoverTextField.text;
     args.Number=[self.txtCaseNO.text Trim];
     **/
    TKLabelTextFieldCell *cell1=(TKLabelTextFieldCell*)[self.cells objectAtIndex:0];
    TKLabelCalendarCell *cell4=(TKLabelCalendarCell*)[self.cells objectAtIndex:3];
    TKLabelCalendarCell *cell5=(TKLabelCalendarCell*)[self.cells objectAtIndex:4];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:cell1.field.text forKey:@"Numbe"];
    [dic setValue:cell5.calendar.popoverText.popoverTextField.text forKey:@"EDate"];
    [dic setValue:cell4.calendar.popoverText.popoverTextField.text forKey:@"SDate"];
    [dic setValue:cellCity.field.text forKey:@"Ctiy"];
    [dic setValue:cellCircular.field.text forKey:@"Category"];
    return dic;
}
#pragma mark popover controller
-(void)exitKeyboard{
    TKLabelTextFieldCell *cell1=(TKLabelTextFieldCell*)[self.cells objectAtIndex:0];
    [cell1 resignFirstResponder];
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:3];
    [cell2 resignFirstResponder];
    TKLabelTextFieldCell *cell3=(TKLabelTextFieldCell*)[self.cells objectAtIndex:4];
    [cell3 resignFirstResponder];
}
-(void)buttonCityTap:(id)sender{
    [self exitKeyboard];
    if (!popoverCity) {
        CityViewController *controller=[[[CityViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        popoverCity = [[FPPopoverController alloc] initWithViewController:controller];
        popoverCity.tint=FPPopoverLightGrayTint;
        popoverCity.contentSize = CGSizeMake(200, 300);
        popoverCity.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverCity presentPopoverFromView:sender containerView:self];
}
-(void)buttonCircularTypeTap:(id)sender{
    [self exitKeyboard];
    if (!popoverCircular) {
        RadioViewController *controller=[[[RadioViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        popoverCircular = [[FPPopoverController alloc] initWithViewController:controller];
        popoverCircular.tint=FPPopoverLightGrayTint;
        popoverCircular.contentSize = CGSizeMake(200, 300);
        popoverCircular.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverCircular presentPopoverFromView:sender containerView:self];
}


#pragma mark UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.cells.count;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        UITableViewCell *tableCell=self.cells[indexPath.row];
        tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return tableCell;
    }else{
        TKButtonCell *cell=[[TKButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=indexPath.row==0?@"search":@"cancel";
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&(indexPath.row==1||indexPath.row==2)) {
        UITableViewCell *cell=(UITableViewCell*)[self.cells objectAtIndex:indexPath.row];
        if (indexPath.row==1) {
            [self buttonCircularTypeTap:cell];
        }
        if (indexPath.row==2) {
            [self buttonCityTap:cell];
        }
    }
    if (indexPath.section==1&&indexPath.row==1) {
        [self hide:nil];
    }
    //查询
    if (indexPath.section==1&&indexPath.row==0) {
        [self hide:nil];
        if (self.croller&&[self.croller respondsToSelector:@selector(startSearch)]){            
            SEL addMethod = NSSelectorFromString(@"startSearch");
            [self.croller performSelector:addMethod withObject:nil];
        }
    }
}
#pragma mark FPPopoverControllerDelegate
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];
}
#pragma mark 私有方法
-(TKLabelTextFieldCell*)getCellCircular{
    if(!cellCircular){
        cellCircular=[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cellCircular.label.componentsAndPlainText=[cellCircular labelName:@"案件類別:" required:YES];
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
        cellCity.label.componentsAndPlainText=[cellCity labelName:@"鄉鎮市別:" required:YES];
        UIImage *img1=[UIImage imageNamed:@"arrow_down.png"];
        UIImageView *imageView1=[[[UIImageView alloc] initWithImage:img1] autorelease];
        cellCity.field.enabled=NO;
        cellCity.field.rightView=imageView1;
        cellCity.field.rightViewMode=UITextFieldViewModeAlways;
        cellCity.field.placeholder=@"choose city";
    }
    return cellCity;
}
@end
