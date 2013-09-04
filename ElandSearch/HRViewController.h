//
//  HRViewController.h
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRHelper.h"
@interface HRViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>{
@private HRHelper *hrHelper;
}
@property(nonatomic,retain) UITableView *tableView;
@end
