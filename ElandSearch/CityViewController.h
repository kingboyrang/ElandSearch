//
//  CityViewController.h
//  CaseSearch
//
//  Created by rang on 13-8-4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CityViewController : UITableViewController{
    //int newRow;
    int currentIndex;
}
@property(nonatomic,retain) NSArray *listData;
@property(nonatomic,assign) id delegate;
@end
