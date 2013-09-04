//
//  CircularTypeOperate.h
//  CaseSearch
//
//  Created by rang on 13-8-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircularType.h"
@interface CircularTypeOperate : NSObject<NSCoding>
@property(nonatomic,retain) NSDictionary *circularTypes;
@property(nonatomic,retain) NSArray *circularTypeSource;
-(NSArray*)childCircularTypes:(NSString*)parent level:(NSString*)level;
-(void)CirularTypesArchiver;
+(CircularTypeOperate*)CirularTypesUnArchiver;
@end
