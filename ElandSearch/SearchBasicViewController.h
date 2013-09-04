//
//  SearchBasicViewController.h
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
#import "PullingRefreshTableView.h"
@interface SearchBasicViewController : UIViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) BOOL refreshing;
@property(nonatomic,retain) PullingRefreshTableView *tableView;
@property(nonatomic,retain) NSMutableArray *sourceData;
//子类重写
-(void)viewCaseDetail:(VCircular*)entity;
-(void)loadData;

//重设返回按钮
-(void)resetNavigationBarBack;
-(void)showAlterViewPassword:(VCircular*)entity success:(void (^)(void))completed;
@end
