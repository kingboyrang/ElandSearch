//
//  TKLabelCalendarCell.m
//  ElandSearch
//
//  Created by rang on 13-9-3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKLabelCalendarCell.h"

@implementation TKLabelCalendarCell
@synthesize calendar=_calendar;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _calendar = [[CVUICalendar alloc] initWithFrame:CGRectZero];
	_calendar.popoverText.popoverTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _calendar.popoverText.popoverTextField.backgroundColor=[UIColor clearColor];
	_calendar.backgroundColor = [UIColor clearColor];
    //_button.. = [UIFont boldSystemFontOfSize:16.0];
    _calendar.popoverText.popoverTextField.font=[UIFont boldSystemFontOfSize:16];
    
    [self.contentView addSubview:_calendar];
    
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
	
	CGRect r = CGRectInset(self.contentView.bounds, 8, 8);
	r.origin.x += self.label.frame.size.width + 6;
	r.size.width -= self.label.frame.size.width + 6;
	_calendar.frame = r;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
