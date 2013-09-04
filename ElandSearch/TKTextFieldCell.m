//
//  TKTextFieldCell.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKTextFieldCell.h"

@implementation TKTextFieldCell
@synthesize field=_field;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
	
	_field = [[UITextField alloc] initWithFrame:CGRectZero];
	_field.font = [UIFont boldSystemFontOfSize:16.0];
    _field.delegate=self;
	_field.backgroundColor = [UIColor clearColor];
	[self.contentView addSubview:_field];
	
	return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	return [self initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:reuseIdentifier];
}

- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect r = CGRectInset(self.contentView.bounds, 4, 8);
	_field.frame = r;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	[_field resignFirstResponder];
	return NO;
}
@end
