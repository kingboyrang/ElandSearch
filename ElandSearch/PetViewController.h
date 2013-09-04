//
//  PetViewController.h
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
@interface PetViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,FPPopoverControllerDelegate>{
@private
    FPPopoverController *popoverAge;
}
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;

-(void)buttonAgeTap:(id)sender;
-(void)selectedTableRowAge:(NSString*)age;

-(void)buttonImageSelectTap;
//重写父类方法
-(void)deletePhotoScrollCell;
-(void)loadPhotos;
@end
