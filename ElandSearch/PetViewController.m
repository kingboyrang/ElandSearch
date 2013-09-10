//
//  PetViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "PetViewController.h"
#import "TKEmptyCell.h"
#import "TKLabelSegmentedCell.h"
#import "TKButtonCell.h"
#import "AgeViewController.h"
@interface PetViewController ()
-(void)exitKeyboard;
@end

@implementation PetViewController
@synthesize cells=_cells;
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
    if (popoverAge) {
        [popoverAge release],popoverAge=nil;
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
    CGRect rect=self.view.bounds;
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    
    NSMutableString *memo=[NSMutableString stringWithString:@"若已尋獲寵物或有疑問"];
    [memo appendString:@"請洽宜蘭縣動植物防疫所\n"];
    [memo appendString:@"TEL:(03)960-2350\n"];
    [memo appendString:@"FAX:(03)960-2307\n"];
    [memo appendString:@"E-mail:animal@mail.e-land.gov.tw\n"];
    [memo appendString:@"Mon-Fri:08:00~17:00"];
    TKEmptyCell *cell1=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell1.textLabel.numberOfLines=0;
    cell1.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell1.textLabel.text=memo;
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.componentsAndPlainText=[self labelShowName:@"寵物名:" required:YES];
    cell2.field.placeholder=@"editable petname";
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.componentsAndPlainText=[self labelShowName:@"品    種:" required:YES];
    cell3.field.placeholder=@"editable petname";
    
  TKLabelTextFieldCell  *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.label.componentsAndPlainText=[self labelShowName:@"年    齡:" required:YES];
    UIImage *img1=[UIImage imageNamed:@"arrow_down.png"];
    UIImageView *imageView1=[[[UIImageView alloc] initWithImage:img1] autorelease];
    cell4.field.enabled=NO;
    cell4.field.rightView=imageView1;
    cell4.field.rightViewMode=UITextFieldViewModeAlways;
    cell4.field.placeholder=@"choose age";
    
    TKLabelSegmentedCell *cell5=[[[TKLabelSegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.label.componentsAndPlainText=[self labelShowName:@"性    別:" required:YES];
    [cell5.segmentedControl insertSegmentWithTitle:@"公" atIndex:0 animated:NO];
    [cell5.segmentedControl insertSegmentWithTitle:@"母" atIndex:1 animated:NO];
    [cell5.segmentedControl setSelectedSegmentIndex:0];
    
    TKLabelSegmentedCell *cell6=[[[TKLabelSegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell6.label.componentsAndPlainText=[self labelShowName:@"絕    育:" required:YES];
    [cell6.segmentedControl insertSegmentWithTitle:@"是" atIndex:0 animated:NO];
    [cell6.segmentedControl insertSegmentWithTitle:@"否" atIndex:1 animated:NO];
    [cell6.segmentedControl setSelectedSegmentIndex:1];
    
    TKLabelTextFieldCell *cell7=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell7.label.componentsAndPlainText=[self labelShowName:@"特    徵:" required:YES];
    cell7.field.placeholder=@"editable feature";
    
    TKLabelSegmentedCell *cell8=[[[TKLabelSegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell8.label.componentsAndPlainText=[self labelShowName:@"晶    片:" required:YES];
    [cell8.segmentedControl insertSegmentWithTitle:@"有" atIndex:0 animated:NO];
    [cell8.segmentedControl insertSegmentWithTitle:@"无" atIndex:1 animated:NO];
    [cell8.segmentedControl setSelectedSegmentIndex:0];
    
    
    TKLabelTextFieldCell *cell9=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell9.label.componentsAndPlainText=[self labelShowName:@"走失地點:" required:YES];
    cell9.field.placeholder=@"editable address";
    
    TKLabelTextFieldCell *cell10=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell10.label.componentsAndPlainText=[self labelShowName:@"走失時間:" required:YES];
    cell10.field.placeholder=@"editable date";
    cell10.field.enabled=NO;
    
    TKLabelTextFieldCell *cell11=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell11.label.componentsAndPlainText=[self labelShowName:@"主人的話:" required:YES];
    cell11.field.placeholder=@"editable sepak";
    
    TKLabelTextFieldCell *cell12=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell12.label.componentsAndPlainText=[self labelShowName:@"聯絡方式:" required:NO];
    cell12.field.placeholder=@"editable contact";
    
    self.cells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10,
                 cell11,cell12,[self getCellPWD],[self getCellPhotos:@"寵物照片:"],nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonAgeTap:(id)sender{
    [self exitKeyboard];
    if (!popoverAge) {
        AgeViewController *controller=[[[AgeViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        popoverAge = [[FPPopoverController alloc] initWithViewController:controller];
        popoverAge.tint=FPPopoverLightGrayTint;
        popoverAge.contentSize = CGSizeMake(200, 300);
        popoverAge.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverAge presentPopoverFromView:sender];
}
-(void)selectedTableRowAge:(NSString*)age{
    TKLabelTextFieldCell *cell=(TKLabelTextFieldCell*)[self.cells objectAtIndex:3];
    cell.field.text=age;
    if (popoverAge) {
        [popoverAge dismissPopoverAnimated:YES];
    }
}
-(void)buttonImageSelectTap{
    [self exitKeyboard];
    [self chooseImagesTap];
}
//退出键盘操作
-(void)exitKeyboard{
    TKLabelTextFieldCell *cell1=(TKLabelTextFieldCell*)[self.cells objectAtIndex:1];
    [cell1.field resignFirstResponder];
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:2];
    [cell2.field resignFirstResponder];
    TKLabelTextFieldCell *cell3=(TKLabelTextFieldCell*)[self.cells objectAtIndex:6];
    [cell3.field resignFirstResponder];
    TKLabelTextFieldCell *cell4=(TKLabelTextFieldCell*)[self.cells objectAtIndex:8];
    [cell4.field resignFirstResponder];
    TKLabelTextFieldCell *cell5=(TKLabelTextFieldCell*)[self.cells objectAtIndex:9];
    [cell5.field resignFirstResponder];
    TKLabelTextFieldCell *cell6=(TKLabelTextFieldCell*)[self.cells objectAtIndex:10];
    [cell6.field resignFirstResponder];
    TKLabelTextFieldCell *cell7=(TKLabelTextFieldCell*)[self.cells objectAtIndex:11];
    [cell7.field resignFirstResponder];
    TKLabelTextFieldCell *cell8=(TKLabelTextFieldCell*)[self.cells objectAtIndex:12];
    [cell8.field resignFirstResponder];
}

#pragma mark 重写父类方法
-(void)loadPhotos{
    if ([self.cells count]<15) {
        TKEmptyCell *cell6=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        [self.cells addObject:cell6];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:14 inSection:0];
        NSArray *arr=[NSArray arrayWithObjects:indexPath, nil];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        [self initPhotosScroll];
        [cell6.contentView addSubview:[self imagesScroll]];
    }
}
-(void)deletePhotoScrollCell{
    [self.cells removeObjectAtIndex:14];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:14 inSection:0];
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
        tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return tableCell;
    }else{
        TKButtonCell *cell=[[TKButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"submit";
        return cell;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 135;
    }
    if (indexPath.section==0&&indexPath.row==14) {
        return 300;
    }
	return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==3){
        UITableViewCell *cell=(UITableViewCell*)[self.cells objectAtIndex:3];
        [self buttonAgeTap:cell];
    }

    if (indexPath.section==0&&indexPath.row==13){
        [self buttonImageSelectTap];
    }
    if (indexPath.section==1&&indexPath.row==0){
        [self buttonSubmit];
    }
}
-(void)buttonSubmit{
    TKLabelTextFieldCell *cell1=[self.cells objectAtIndex:1];
    if (!cell1.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135) animated:YES];
        [cell1 errorVerify];
        [cell1 shake];
        return;
    }
    TKLabelTextFieldCell *cell2=[self.cells objectAtIndex:2];
    if (!cell2.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44) animated:YES];
        [cell2 errorVerify];
        [cell2 shake];
        return;
    }
    TKLabelTextFieldCell *cell3=[self.cells objectAtIndex:3];
    if (!cell3.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44*2) animated:YES];
        [cell3 errorVerify];
        [cell3 shake];
        return;
    }
    TKLabelTextFieldCell *cell4=[self.cells objectAtIndex:6];
    if (!cell4.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44*5) animated:YES];
        [cell4 errorVerify];
        [cell4 shake];
        return;
    }
    TKLabelTextFieldCell *cell5=[self.cells objectAtIndex:8];
    if (!cell5.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44*7) animated:YES];
        [cell5 errorVerify];
        [cell5 shake];
        return;
    }
    TKLabelTextFieldCell *cell6=[self.cells objectAtIndex:9];
    if (!cell6.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44*8) animated:YES];
        [cell6 errorVerify];
        [cell6 shake];
        return;
    }
    TKLabelTextFieldCell *cell7=[self.cells objectAtIndex:10];
    if (!cell7.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44*9) animated:YES];
        [cell7 errorVerify];
        [cell7 shake];
        return;
    }
    TKLabelTextFieldCell *cell8=[self.cells objectAtIndex:12];
    if (!cell8.hasValue) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 135+44*11) animated:YES];
        [cell8 errorVerify];
        [cell8 shake];
        return;
    }
    if (!self.hasNetwork) {
        [self showNoNetworkErrorView];
        return;
    }

}
@end
