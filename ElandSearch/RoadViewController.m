//
//  RoadViewController.m
//  CaseSearch
//
//  Created by rang on 13-8-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "RoadViewController.h"
#import "TKLabelTextFieldCell.h"
#import "TKButtonCell.h"
#import "TKLabelButtonCell.h"
#import "TKLabelTextViewCell.h"
#import "TKEmptyCell.h"
@interface RoadViewController ()
-(void)loadPhotos;
-(void)exitKeyboard;
@end

@implementation RoadViewController
@synthesize cells=_cells;
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
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
    
    CGRect rect=self.view.bounds;
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    

    
    
        
    TKLabelTextFieldCell *cell2= [[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	cell2.label.componentsAndPlainText = [self labelShowName:@"現在地址:" required:YES];
    UIImage *map=[UIImage imageNamed:@"map.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, map.size.width, map.size.height);
    [btn setImage:map forState:UIControlStateNormal];
    //[btn sizeToFit];
    cell2.field.rightView=btn;
    cell2.field.rightViewMode=UITextFieldViewModeAlways;
	cell2.field.placeholder = @"editable address";

    TKLabelTextViewCell *cell4=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.label.componentsAndPlainText=[self labelShowName:@"狀況描述:" required:NO];
    cell4.textView.font=[UIFont boldSystemFontOfSize:16.0];
    cell4.textView.delegate=self;
    cell4.textView.placeholder=@"editable memo";
    
    self.cells =[NSMutableArray arrayWithObjects:[self getCellCircular],cell2,[self getCellCity],cell4,[self getCellPWD],[self getCellPhotos], nil];

    
}
#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    TKLabelTextViewCell *cell=(TKLabelTextViewCell*)[self.cells objectAtIndex:3];
    CGRect frame=[self.view convertRect:cell.frame fromView:cell.superview];
    CGFloat top=frame.origin.y+frame.size.height+44;
    [self.tableView setContentOffset:CGPointMake(0, top) animated:NO];
   // NSLog(@"frame=%@\n",NSStringFromCGRect(frame));
    //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
-(void)buttonCityTap:(id)sender{
    [self exitKeyboard];
    [self popoverVillage:sender];
}
-(void)buttonCircularTypeTap:(id)sender{
    [self exitKeyboard];
    [self popoverCircularType:sender type:@"A" level:1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonImageSelectTap{
    [self exitKeyboard];
    [self chooseImagesTap];
}
//退出键盘操作
-(void)exitKeyboard{
    TKLabelTextFieldCell *address=(TKLabelTextFieldCell*)[self.cells objectAtIndex:1];
    [address.field resignFirstResponder];
    TKLabelTextViewCell *memo=(TKLabelTextViewCell*)[self.cells objectAtIndex:3];
    [memo.textView resignFirstResponder];
    TKLabelTextFieldCell *password=(TKLabelTextFieldCell*)[self.cells objectAtIndex:4];
    [password.field resignFirstResponder];
}

#pragma mark 重写父类方法
-(void)loadPhotos{
    if ([self.cells count]<7) {
        TKEmptyCell *cell6=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        [self.cells addObject:cell6];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:6 inSection:0];
        NSArray *arr=[NSArray arrayWithObjects:indexPath, nil];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        [self initPhotosScroll];
        [cell6.contentView addSubview:[self imagesScroll]];
    }
}
-(void)deletePhotoScrollCell{
    [self.cells removeObjectAtIndex:6];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:6 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}
#pragma mark UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.cells.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        UITableViewCell *tableCell=self.cells[indexPath.row];
        if (indexPath.row!=0||indexPath.row!=2) {
            tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return tableCell;
    }else{
        TKButtonCell *cell=[[TKButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"submit";
        return cell;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==3) {
        return 120;
    }
    if (indexPath.section==0&&indexPath.row==6) {
        return 300;
    }
	return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        [self buttonCircularTypeTap:newCell];
    }
    if (indexPath.section==0&&indexPath.row==2) {
         UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        [self buttonCityTap:newCell];
    }
    if (indexPath.section==0&&indexPath.row==5){
        [self buttonImageSelectTap];
    }
    if(indexPath.section==1&&indexPath.row==0){
        [self buttonSubmit];
    }
}
-(void)buttonSubmit{
    TKLabelTextFieldCell *cell1=(TKLabelTextFieldCell*)[self.cells objectAtIndex:0];
    if(!cell1.hasValue){
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44) animated:YES];
        [cell1 errorVerify];
        [cell1 shake];
        return;
    }
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:1];
    if(!cell2.hasValue){
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44) animated:YES];
        [cell2 errorVerify];
        [cell2 shake];
        return;
    }
    TKLabelTextFieldCell *cell3=(TKLabelTextFieldCell*)[self.cells objectAtIndex:2];
    if(!cell3.hasValue){
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44) animated:YES];
        [cell3 errorVerify];
        [cell3 shake];
        return;
    }
    TKLabelTextFieldCell *cell4=(TKLabelTextFieldCell*)[self.cells objectAtIndex:4];
    if(!cell4.hasValue){
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44*4+120) animated:YES];
        [cell4 errorVerify];
        [cell4 shake];
        return;
    }
    if (!self.hasNetwork) {
        [self showNoNetworkErrorView];
        return;
    }
    
    
}
@end
