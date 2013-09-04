//
//  MachineSearch.h
//  ElandSearch
//
//  Created by rang on 13-8-31.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircularSearchArgs.h"
#import "VCircular.h"
#import "SearchBasicViewController.h"
@interface MachineSearch : SearchBasicViewController{
@private
    NSInteger _pageCount;
    NSInteger _curPage;
    BOOL   _isFirst;
    VCircularSearchArgs *args;
}
-(void)loadData;
-(void)viewCaseDetail:(VCircular*)entity;
@end
