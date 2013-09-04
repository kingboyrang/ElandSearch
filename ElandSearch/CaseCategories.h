//
//  CaseCategories.h
//  CaseSearch
//
//  Created by rang on 13-8-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularType.h"
#import "ServiceHelper.h"
#import "XmlParseHelper.h"
@interface CaseCategories : UITableViewController
@property (nonatomic, retain) NSMutableArray *displayArray;
@property(nonatomic,copy) NSString *showType;
@property(nonatomic,assign) int showLevel;
@property(nonatomic,assign) id delegate;
@end
