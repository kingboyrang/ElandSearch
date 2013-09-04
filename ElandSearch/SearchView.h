//
//  SearchView.h
//  SearchDemo
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "TKLabelTextFieldCell.h"
@interface SearchView : UIView<FPPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
@private
    FPPopoverController *popoverCity;
    FPPopoverController *popoverCircular;
    TKLabelTextFieldCell *cellCircular;
    TKLabelTextFieldCell *cellCity;
    UIView *coverView;
    CGRect searchViewFrame;
}
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
@property(nonatomic,assign) id croller;

-(void)buttonCityTap:(id)sender;
-(void)buttonCircularTypeTap:(id)sender;
-(void)selectedTableRowVillage:(NSString*)city;
-(void)selectedCategory:(NSDictionary*)userinfo;

-(void)show;
-(void)hide:(void (^)(void))completed;

-(NSDictionary*)caseSearchArgs;
@end
