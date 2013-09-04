//
//  UserSetViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "UserSetViewController.h"
#import "TKLabelTextFieldCell.h"
#import "TKButtonCell.h"
#import "SecrecyViewController.h"
@interface UserSetViewController ()
-(void)buttonSave;
@end

@implementation UserSetViewController
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
    
    [self resetNavigationBarBack];
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"存檔" style:UIBarButtonItemStylePlain target:self action:@selector(buttonSave)];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];

    
    TKLabelTextFieldCell *cell1=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.label.componentsAndPlainText=[cell1 labelName:@"姓名" required:NO];
    cell1.field.placeholder=@"editable name";
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.componentsAndPlainText=[cell2 labelName:@"手機號碼" required:NO];
    cell2.field.placeholder=@"editable phone";
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.componentsAndPlainText=[cell3 labelName:@"Email" required:NO];
    cell3.field.placeholder=@"editable Email";
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.label.componentsAndPlainText=[cell4 labelName:@"暱稱" required:NO];
    cell4.field.placeholder=@"editable nick";
    
    
    self.cells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
	// Do any additional setup after loading the view.
}
//保存
-(void)buttonSave{
    TKLabelTextFieldCell *cell1=(TKLabelTextFieldCell*)[self.cells objectAtIndex:0];
    [cell1 shake];
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:1];
    [cell2 shake];
    TKLabelTextFieldCell *cell3=(TKLabelTextFieldCell*)[self.cells objectAtIndex:2];
    [cell3 shake];
    TKLabelTextFieldCell *cell4=(TKLabelTextFieldCell*)[self.cells objectAtIndex:3];
    [cell4 shake];
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
        cell.textLabel.text=@"隱私及資訊安全保護政策";
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==1&&indexPath.row==0){
        SecrecyViewController *controller=[[SecrecyViewController alloc] init];
        controller.title=@"隱私及資訊安全保護政策";
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}
@end
