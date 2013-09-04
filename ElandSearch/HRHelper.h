
//
//  HRHelper.h
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTextFieldCell.h"
#import "FPPopoverController.h"
@interface HRHelper : NSObject<FPPopoverControllerDelegate>{
@private
    FPPopoverController *popoverItem;
    FPPopoverController *popoverRelative;
    FPPopoverController *popoverTings;
    FPPopoverController *popoverDieRelative;
}
@property(nonatomic,copy) NSString* itemName;
@property(nonatomic,readonly) NSInteger startIndex;
@property(nonatomic,readonly) NSInteger endIndex;
@property(nonatomic,readonly) NSMutableArray *cellHeights;
@property(nonatomic,readonly) NSMutableArray *dataSource;

-(void)buttonDieRelativeTap;

-(void)buttonChangeItem;
-(void)selectedTableRowItem:(NSString*)item;

-(void)removeDataSourceItem;
-(void)insertDataSourceItem:(NSString*)name;

-(void)buttonTingsTap;
-(void)buttonRelativeTap;
-(void)finishItemSelected:(FPPopoverController*)sender value:(NSString*)name;

-(TKLabelTextFieldCell*)applyItemCell;
-(NSDictionary*)HRBirth;
-(NSDictionary*)HRDie;
-(NSDictionary*)HRMarry;
-(NSDictionary*)HRContact;
@end
