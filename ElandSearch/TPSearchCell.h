//
//  TPSearchCell.h
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
@interface TPSearchCell : UITableViewCell
-(void)setDataSource:(VCircular*)entity;
-(void)selectedCellAnimal:(void (^)(void))completed;
@end
