//
//  TKTextViewCell.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKTextViewCell.h"

@implementation TKTextViewCell
@synthesize textView=_textView;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
	
	_textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
	_textView.font = [UIFont boldSystemFontOfSize:16.0];
	_textView.backgroundColor = [UIColor clearColor];
	[self.contentView addSubview:_textView];
	
	return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	return [self initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:reuseIdentifier];
}

- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect r = CGRectInset(self.contentView.bounds, 4, 8);
	_textView.frame = r;
}
@end
