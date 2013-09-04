//
//  TKLabelButtonCell.m
//  CaseSearch
//
//  Created by rang on 13-8-3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKLabelButtonCell.h"

@implementation TKLabelButtonCell
@synthesize button=_button;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _button = [[UIButton alloc] initWithFrame:CGRectZero];
	_button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_button.backgroundColor = [UIColor clearColor];
    //_button.. = [UIFont boldSystemFontOfSize:16.0];
    _button.titleLabel.font=[UIFont boldSystemFontOfSize:16];

    [self.contentView addSubview:_button];
    
    
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
	_button.frame = r;
}
@end
