//
//  TPSearchCell.m
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TPSearchCell.h"
#import "CircularDetail.h"
@implementation TPSearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CircularDetail *detail=[[CircularDetail alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 119)];
        detail.autoresizesSubviews=YES;
        detail.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        detail.tag=100;
        [self.contentView addSubview:detail];
        [detail release];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];

    }
    return self;
}
-(void)setDataSource:(VCircular*)entity{
    CircularDetail *view=(CircularDetail*)[self viewWithTag:100];
    [view setDataSource:entity];
}
-(void)selectedCellAnimal:(void (^)(void))completed{
    CircularDetail *detail=(CircularDetail*)[self viewWithTag:100];
    [UIView animateWithDuration:0.5f animations:^{
        [detail selectedBgColorAnimal:YES];
    } completion:^(BOOL finished) {
        if (finished) {
            [detail selectedBgColorAnimal:NO];
            if (completed) {
                completed();
            }
        }
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
