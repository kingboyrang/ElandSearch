//
//  TKLabelCell.m
//  Created by Devin Ross on 7/1/09.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKLabelCell.h"
#define defaultLabelWith 100.0
@implementation TKLabelCell
@synthesize labelLeftWith;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;

    self.labelLeftWith=defaultLabelWith;
    _label = [[RCLabel alloc] initWithFrame:CGRectMake(0, 0, self.labelLeftWith, 44)];
	_label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentRight;
    _label.textColor = [UIColor grayColor];
    _label.font = [UIFont boldSystemFontOfSize:12.0];
	[self.contentView addSubview:_label];

    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
/***
-(void)setLabelLeftWith:(CGFloat)width{
    self.labelLeftWith=width;
    CGRect frame = [self.label frame];
    frame.size.width=self.labelLeftWith;
    [self.label setFrame:frame];
}
 ***/
- (void) layoutSubviews {
    [super layoutSubviews];
	
    CGSize optimumSize = [self.label optimumSize];
	CGRect frame = [self.label frame];
	frame.size.height = (int)optimumSize.height + 5;
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
	[self.label setFrame:frame];

}
-(RTLabelComponentsStructure*)labelName:(NSString*)title required:(BOOL)required{
    NSString *showTitle=[NSString stringWithFormat:@"<font size =16>%@</font>",title];
    NSString *requiredTitle=@"";
    if (required) {
        requiredTitle=@"<font size=16 color='#dd1100'>*</font>";
    }
    NSString *result=[NSString stringWithFormat:@"%@%@",showTitle,requiredTitle];
    RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:result];
    return componentsDS;
}
@end
