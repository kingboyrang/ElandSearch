//
//  LightViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "LightViewController.h"
#import "TKButtonCell.h"
#import "TKEmptyCell.h"
#import "TKLabelTextViewCell.h"
#import "SwitchLightNumber.h"
@interface LightViewController (){
    SwitchLightNumber *_switchLightNumber;
}
-(void)exitKeyboard;
@end

@implementation LightViewController
@synthesize cells=_cells;
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
    [_switchLightNumber release],_switchLightNumber=nil;
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

    TKEmptyCell *cell2=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.textLabel.text=@"路燈編號和地址請擇一填寫:";
    cell2.textLabel.textColor=[UIColor redColor];
    cell2.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    
    TKEmptyCell *cellSwitch=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    _switchLightNumber=[[SwitchLightNumber alloc] initWithFrame:CGRectMake(15,0, 300, 44)];
    _switchLightNumber.autoresizesSubviews=YES;
    _switchLightNumber.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    _switchLightNumber.backgroundColor=[UIColor clearColor];
    [cellSwitch.contentView addSubview:_switchLightNumber];
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.componentsAndPlainText=[self labelShowName:@"路燈編號:" required:YES];
    cell3.field.placeholder=@"editable lightnumber";
    
    TKLabelTextFieldCell *cell4= [[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	cell4.label.componentsAndPlainText = [self labelShowName:@"現在地址:" required:YES];
    UIImage *map=[UIImage imageNamed:@"map.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, map.size.width, map.size.height);
    [btn setImage:map forState:UIControlStateNormal];
    //[btn sizeToFit];
    cell4.field.rightView=btn;
    cell4.field.rightViewMode=UITextFieldViewModeAlways;
	cell4.field.placeholder = @"editable address";
    
    
    TKLabelTextViewCell *cell5=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.label.componentsAndPlainText=[self labelShowName:@"狀況描述:" required:NO];
    cell5.textView.font=[UIFont boldSystemFontOfSize:16.0];
    //cell5.textView.delegate=self;
    cell5.textView.placeholder=@"editable memo";
    
    TKLabelTextViewCell *cell6=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell6.label.componentsAndPlainText=[self labelShowName:@"通報人住址:" required:NO];
    cell6.textView.font=[UIFont boldSystemFontOfSize:16.0];
    //cell5.textView.delegate=self;
    cell6.textView.placeholder=@"editable address";
    
    self.cells =[NSMutableArray arrayWithObjects:[self getCellCircular],cell2,cellSwitch,cell3,cell4,[self getCellCity],cell5,cell6,[self getCellPWD],[self getCellPhotos], nil];
	// Do any additional setup after loading the view.
}
-(void)buttonCircularTypeTap:(id)sender{
    [self exitKeyboard];
    [self popoverCircularType:sender type:@"B" level:3];
}
-(void)buttonCityTap:(id)sender{
    [self exitKeyboard];
    [self popoverVillage:sender];
}
-(void)buttonImageSelectTap{
    [self exitKeyboard];
    [self chooseImagesTap];
}
-(void)exitKeyboard{
    TKLabelTextFieldCell *cell3=(TKLabelTextFieldCell*)[self.cells objectAtIndex:3];
    [cell3.field resignFirstResponder];
    TKLabelTextFieldCell *cell4=(TKLabelTextFieldCell*)[self.cells objectAtIndex:4];
    [cell4.field resignFirstResponder];
    
    TKLabelTextViewCell *cell5=(TKLabelTextViewCell*)[self.cells objectAtIndex:6];
    [cell5.textView resignFirstResponder];
    
    TKLabelTextViewCell *cell6=(TKLabelTextViewCell*)[self.cells objectAtIndex:7];
    [cell6.textView resignFirstResponder];
    
    TKLabelTextFieldCell *cell7=(TKLabelTextFieldCell*)[self.cells objectAtIndex:8];
    [cell7.field resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 重写父类方法
-(void)loadPhotos{
    if ([self.cells count]<11) {
        NSLog(@"aa\n");
        TKEmptyCell *cell6=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        [self.cells addObject:cell6];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:10 inSection:0];
        NSArray *arr=[NSArray arrayWithObjects:indexPath, nil];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        [self initPhotosScroll];
        [cell6.contentView addSubview:[self imagesScroll]];
    }
}
-(void)deletePhotoScrollCell{
    [self.cells removeObjectAtIndex:10];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:10 inSection:0];
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

    if (indexPath.section==0&&(indexPath.row==6||indexPath.row==7)) {
        return 120;
    }
    if (indexPath.section==0&&indexPath.row==10) {
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
    if (indexPath.section==0&&indexPath.row==5) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        [self buttonCityTap:newCell];
    }
    if (indexPath.section==0&&indexPath.row==9) {
        [self buttonImageSelectTap];
    }
    if (indexPath.section==1&&indexPath.row==0) {
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
    if (_switchLightNumber.currentIndex==1) {
        TKLabelTextFieldCell *cell3=[self.cells objectAtIndex:3];
        if (!cell3.hasValue) {
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44) animated:YES];
            [cell3 errorVerify];
            [cell3 shake];
        }
    }else{
        TKLabelTextFieldCell *cell4=[self.cells objectAtIndex:4];
        if (!cell4.hasValue) {
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44) animated:YES];
            [cell4 errorVerify];
            [cell4 shake];
        }
    }
    TKLabelTextFieldCell *cell5=[self.cells objectAtIndex:5];
    if (!cell5.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44*5) animated:YES];
        [cell5 errorVerify];
        [cell5 shake];
    }
    TKLabelTextFieldCell *cell6=[self.cells objectAtIndex:8];
    if (!cell6.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 44*6+120*2) animated:YES];
        [cell6 errorVerify];
        [cell6 shake];
    }

    if (!self.hasNetwork) {
        [self showNoNetworkErrorView];
        return;
    }
}
@end
