//
//  CircularRoadType.m
//  CaseSearch
//
//  Created by rang on 13-8-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CircularType.h"

@implementation CircularType
@synthesize Author,Created,Editor,GUID,Hour;
@synthesize ID,Level,Memo,Modified,Name,Parent;
@synthesize Sort,Status;
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.Author forKey:@"Author"];
    [encoder encodeObject:self.Created forKey:@"Created"];
    [encoder encodeObject:self.Editor forKey:@"Editor"];
    [encoder encodeObject:self.GUID forKey:@"GUID"];
    [encoder encodeObject:self.Hour forKey:@"Hour"];
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.Level forKey:@"Level"];
    [encoder encodeObject:self.Memo forKey:@"Memo"];
    [encoder encodeObject:self.Modified forKey:@"Modified"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Parent forKey:@"Parent"];
    [encoder encodeObject:self.Sort forKey:@"Sort"];
    [encoder encodeObject:self.Status forKey:@"Status"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.Author=[aDecoder decodeObjectForKey:@"Author"];
        self.Created=[aDecoder decodeObjectForKey:@"Created"];
        self.Editor=[aDecoder decodeObjectForKey:@"Editor"];
        self.GUID=[aDecoder decodeObjectForKey:@"GUID"];
        self.Hour=[aDecoder decodeObjectForKey:@"Hour"];
        self.ID=[aDecoder decodeObjectForKey:@"ID"];
        self.Level=[aDecoder decodeObjectForKey:@"Level"];
        self.Memo=[aDecoder decodeObjectForKey:@"Memo"];
        self.Modified=[aDecoder decodeObjectForKey:@"Modified"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.Parent=[aDecoder decodeObjectForKey:@"Parent"];
        self.Sort=[aDecoder decodeObjectForKey:@"Sort"];
        self.Status=[aDecoder decodeObjectForKey:@"Status"];
    }
    return self;
}
@end
