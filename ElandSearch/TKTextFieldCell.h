//
//  TKTextFieldCell.h
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKTextFieldCell : UITableViewCell<UITextFieldDelegate>
/** The text view. */
@property (nonatomic,strong) UITextField *field;
@end
