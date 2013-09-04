//
//  RadioViewController.h
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioViewController : UITableViewController{
    int currentIndex;
}
@property(nonatomic,retain) NSArray *listData;
@property(nonatomic,assign) id delegate;


@end
