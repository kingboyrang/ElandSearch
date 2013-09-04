//
//  CircularTypeOperate.m
//  CaseSearch
//
//  Created by rang on 13-8-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CircularTypeOperate.h"
#define cacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDataKey @"CircularTypes.archiver"
@interface CircularTypeOperate()
-(NSString*)getFilePath;//CircularTypes.archiver
@end

@implementation CircularTypeOperate
@synthesize circularTypes,circularTypeSource;
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.circularTypes forKey:@"circularTypes"];
    [encoder encodeObject:self.circularTypeSource forKey:@"circularTypeSource"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.circularTypes=[aDecoder decodeObjectForKey:@"circularTypes"];
        self.circularTypeSource=[aDecoder decodeObjectForKey:@"circularTypeSource"];
    }
    return self;
}
-(NSArray*)childCircularTypes:(NSString*)parent level:(NSString*)level{
    if (self.circularTypeSource) {
        NSString *match1=@"";
        if (parent) {
            match1=[NSString stringWithFormat:@"SELF.Parent =='%@'",parent];
        }
        NSString *match2=@"";
        if (level) {
            match2=[NSString stringWithFormat:@"SELF.Level =='%@'",level];
        }
        NSString *search=match1;
        if ([match2 length]>0) {
            search=[NSString stringWithFormat:@"%@ AND %@",match1,match2];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:search];
        NSArray *results = [self.circularTypeSource filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            NSSortDescriptor *_sorter  = [[NSSortDescriptor alloc] initWithKey:@"Sort" ascending:YES];
            NSArray *sortArr=[results sortedArrayUsingDescriptors:[NSArray arrayWithObjects:_sorter, nil]];
            return sortArr;
        }
    }
    return nil;
}
-(void)CirularTypesArchiver{
    
     NSString *cachePath=[NSString stringWithFormat:@"%@/cacheType/%@",cacheDir,kDataKey];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:cachePath atomically:YES];
    [data release];
    [archiver release];

}
+(CircularTypeOperate*)CirularTypesUnArchiver{
    NSString *cachePath=[NSString stringWithFormat:@"%@/cacheType/%@",cacheDir,kDataKey];
    NSData *data = [[NSData alloc] initWithContentsOfFile:cachePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解档出数据模型Student
    CircularTypeOperate *mStudent = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
    return mStudent;

}
#pragma mark 私有方法
-(NSString*)getFilePath{
    NSString *cachePath=[NSString stringWithFormat:@"%@/cacheType/",cacheDir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return cachePath;
}
@end
