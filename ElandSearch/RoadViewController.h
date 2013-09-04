//
//  RoadViewController.h
//  CaseSearch
//
//  Created by rang on 13-8-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RoadViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{

}
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
-(void)buttonCityTap:(id)sender;
-(void)buttonCircularTypeTap:(id)sender;
-(void)buttonImageSelectTap;
//重写父类方法
-(void)deletePhotoScrollCell;
-(void)loadPhotos;
@end
