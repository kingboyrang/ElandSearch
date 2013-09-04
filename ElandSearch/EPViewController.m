//
//  EPViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "EPViewController.h"
#import "TKLabelTextViewCell.h"
#import "TKButtonCell.h"
@interface EPViewController ()
-(void)exitKeyboard;
@end

@implementation EPViewController
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
    //cell4.textView.delegate=self;
    cell4.textView.placeholder=@"editable memo";
    
    self.cells =[NSMutableArray arrayWithObjects:[self getCellCircular],cell2,[self getCellCity],cell4,[self getCellPWD],[self getCellPhotos], nil];

}
-(void)buttonCityTap:(id)sender{
    [self exitKeyboard];
    [self popoverVillage:sender];
}
-(void)buttonCircularTypeTap:(id)sender{
    [self exitKeyboard];
    [self popoverCircularType:sender type:@"C" level:3];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}
@end
