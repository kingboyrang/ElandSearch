//
//  HRPopoverViewController.h
//  ElandSearch
//
//  Created by rang on 13-8-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FPPopoverController;
@interface HRPopoverViewController : UITableViewController{
    //int newRow;
    int currentIndex;
}
@property(nonatomic,retain) NSArray *listData;
@property(nonatomic,assign) id delegate;
@property(nonatomic,assign) FPPopoverController *popover;

@end
