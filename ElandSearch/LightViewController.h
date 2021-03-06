//
//  LightViewController.h
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
-(void)buttonCircularTypeTap:(id)sender;
-(void)buttonCityTap:(id)sender;
-(void)buttonImageSelectTap;
//重写父类方法
-(void)deletePhotoScrollCell;
-(void)loadPhotos;
-(void)buttonSubmit;
@end
