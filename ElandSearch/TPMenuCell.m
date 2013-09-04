//
//  TPMenuCell.m
//  CaseSearch
//
//  Created by rang on 13-7-31.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TPMenuCell.h"

@implementation TPMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view=[[[UIView alloc] initWithFrame:self.bounds] autorelease];
        [view setAutoresizesSubviews:YES];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        view.backgroundColor=[UIColor clearColor];
        
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.bounds.size.width, self.bounds.size.height)];
        //[imageView setContentMode:UIViewContentModeScaleToFill];
        UIImage *defaultImage=[UIImage imageNamed:@"cell_default_bg.png"];
        UIEdgeInsets insets = UIEdgeInsetsMake(4, 4, 4, 4);
        defaultImage = [defaultImage resizableImageWithCapInsets:insets];
        [imageView setImage:defaultImage];
        [imageView setAutoresizesSubviews:YES];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [view addSubview:imageView];
        [imageView release];
        self.backgroundView=view;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *selectBgView=[[[UIView alloc] initWithFrame:self.bounds] autorelease];
        [selectBgView setAutoresizesSubviews:YES];
        [selectBgView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        UIImageView *selectImageView=[[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        [selectImageView setImage:[UIImage imageNamed:@"cell_sel_bg.png"]];
        [selectImageView setAutoresizesSubviews:YES];
        [selectImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [selectImageView setContentMode:UIViewContentModeScaleToFill];
        [selectBgView addSubview:selectImageView];
        self.selectedBackgroundView=selectBgView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/***
// 自绘分割线
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:227/255.0 green:220/255.0 blue:201/255.0 alpha:1].CGColor);
    float lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context,0, rect.size.height);
    CGContextAddLineToPoint(context,rect.size.width,1);
    CGContextStrokePath(context);
    CGContextClosePath(context);
     
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，227,220,201
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}
***/
@end
