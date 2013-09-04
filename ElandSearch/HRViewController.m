//
//  HRViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRViewController.h"
#import "TKButtonCell.h"
#import "HRHelper.h"
@interface HRViewController ()

@end

@implementation HRViewController
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [hrHelper removeObserver:self forKeyPath:@"itemName"];
    [hrHelper release];
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
    
        
    hrHelper=[[HRHelper alloc] init];
    [hrHelper addObserver:self forKeyPath:@"itemName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
	// Do any additional setup after loading the view.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"itemName"])
    {
        if (![[change objectForKey:@"new"] isEqualToString:[change objectForKey:@"old"]]) {
            //删除
            [hrHelper removeDataSourceItem];
            NSMutableArray *arr=[NSMutableArray array];
            for (int i=hrHelper.startIndex; i<=hrHelper.endIndex; i++) {
                [arr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            //再插入
            [hrHelper insertDataSourceItem:[change objectForKey:@"new"]];
            NSMutableArray *insertPaths=[NSMutableArray array];
            for (int i=hrHelper.startIndex; i<=hrHelper.endIndex; i++) {
                [insertPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:insertPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            
        }
        
    }
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
        return [hrHelper.dataSource count];
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        UITableViewCell *tableCell=hrHelper.dataSource[indexPath.row];
        tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return tableCell;
    }else{
        TKButtonCell *cell=[[TKButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"submit";
        return cell;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSNumber  *number=[hrHelper.cellHeights objectAtIndex:indexPath.row];
        return [number floatValue];
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0){
        [hrHelper buttonChangeItem];
    }    
    if ([hrHelper.itemName isEqualToString:@"出生登記"]) {
        if (indexPath.section==0&&indexPath.row==3){
            [hrHelper buttonRelativeTap];
        }
        if (indexPath.section==0&&indexPath.row==5){
            [hrHelper buttonTingsTap];
        }
    }
    if ([hrHelper.itemName isEqualToString:@"死亡登記"]) {
        if (indexPath.section==0&&indexPath.row==3){
            [hrHelper buttonDieRelativeTap];
        }
        if (indexPath.section==0&&indexPath.row==9){
            [hrHelper buttonTingsTap];
        }
    }
    if ([hrHelper.itemName isEqualToString:@"結婚登記"]) {
        if (indexPath.section==0&&indexPath.row==3){
            [hrHelper buttonTingsTap];
        }
    }

    
}

@end
