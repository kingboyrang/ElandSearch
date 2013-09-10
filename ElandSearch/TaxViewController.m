//
//  TaxViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TaxViewController.h"
#import "TKLabelTextViewCell.h"
#import "TKButtonCell.h"
@interface TaxViewController ()
-(void)exitKeyboard;
@end

@implementation TaxViewController
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
    
    TKEmptyCell *cell2=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell2.textLabel.numberOfLines=0;
    cell2.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell2.textLabel.text=@"申辦事項說明:若選擇局長與民有約項目,不需要填寫地點";
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.componentsAndPlainText=[self labelShowName:@"地       點:" required:NO];
    cell3.field.placeholder=@"editable address";
    
    TKLabelTextViewCell *cell4=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.label.componentsAndPlainText=[self labelShowName:@"狀況描述:" required:NO];
    cell4.textView.font=[UIFont boldSystemFontOfSize:16.0];
    //cell4.textView.delegate=self;
    cell4.textView.placeholder=@"editable memo";

    
    self.cells =[NSMutableArray arrayWithObjects:[self getCellCircular:@"申辦項目:"],cell2,cell3,cell4,[self getCellPWD],nil];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonCircularTypeTap:(id)sender{
    [self exitKeyboard];
    [self popoverCircularType:sender type:@"E" level:3];
}
-(void)exitKeyboard{
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:2];
    [cell2.field resignFirstResponder];
    TKLabelTextViewCell *cell3=(TKLabelTextViewCell*)[self.cells objectAtIndex:3];
    [cell3.textView resignFirstResponder];
    TKLabelTextFieldCell *cell4=(TKLabelTextFieldCell*)[self.cells objectAtIndex:4];
    [cell4.field resignFirstResponder];
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
    if (indexPath.section==0&&indexPath.row==1) {
        return 60;
    }
    if (indexPath.section==0&&indexPath.row==3) {
        return 120;
    }
	return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        [self buttonCircularTypeTap:newCell];
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
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:4];
    if(!cell2.hasValue){
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 180+44*2) animated:YES];
        [cell2 errorVerify];
        [cell2 shake];
        return;
    }
    if (!self.hasNetwork) {
        [self showNoNetworkErrorView];
        return;
    }
}
@end
