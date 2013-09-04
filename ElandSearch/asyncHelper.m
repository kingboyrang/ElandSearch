//
//  asyncHelper.m
//  ElandSearch
//
//  Created by rang on 13-8-10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "asyncHelper.h"

#define circularTypeNameSpace [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.w3.org/2001/XMLSchema",@"xsd",@"http://www.w3.org/2001/XMLSchema-instance",@"xsi",nil]

@interface asyncHelper()
+(NSArray*)circularTypesParams;
+(ServiceArgs*)circularTypeArgs:(NSString*)category;
@end


@implementation asyncHelper

+(void)asyncCircularTypes{
    ServiceHelper *_helper=[ServiceHelper sharedInstance];
    NSArray *params=[self circularTypesParams];
    for (NSDictionary *item in params) {
        ASIHTTPRequest *request=[_helper commonSharedRequest:[item objectForKey:@"param"]];
        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[item objectForKey:@"name"],[item objectForKey:@"type"], nil]];
        [_helper addQueue:request];
    }
    __block NSMutableDictionary *resultTypes=[[NSMutableDictionary alloc] init];
    [_helper startQueue:^(ServiceResult *result) {
        NSString *key=[[result.userInfo allKeys] objectAtIndex:0];
        NSString *value=[result.userInfo objectForKey:key];
        NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"xmlns=\"%@\"",result.nameSpace] withString:@""];
        XmlParseHelper *parseHelper=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
        result.xmlValue=[parseHelper soapMessageResultXml:result.methodName];
        [parseHelper setDataSource:[result.xmlValue stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"xmlns=\"%@\"",value] withString:@""]];
        NSArray *arr=[parseHelper selectNodes:[NSString stringWithFormat:@"//%@",value] nameSpaces:circularTypeNameSpace className:@"CircularType"];
        if (arr&&[arr count]>0) {
            [resultTypes setValue:arr forKey:key];
        }
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    } complete:^{
        if (resultTypes&&[resultTypes count]>0) {
            CircularTypeOperate *entity=[[[CircularTypeOperate alloc] init] autorelease];
            entity.circularTypes=resultTypes;
            [entity CirularTypesArchiver];
        }
    }];
}
+(NSArray*)circularTypesParams{
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self circularTypeArgs:@"A"],@"param",@"A",@"type",@"CircularRoadType",@"name", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self circularTypeArgs:@"B"],@"param",@"B",@"type",@"CircularLightType",@"name", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self circularTypeArgs:@"C"],@"param",@"C",@"type",@"CircularEPType",@"name", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self circularTypeArgs:@"E"],@"param",@"E",@"type",@"CircularTaxType",@"name", nil]];
    return arr;
}
+(ServiceArgs*)circularTypeArgs:(NSString*)category{
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:category,@"categorty", nil]];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GetCategoryByCircular";
    args.soapParams=arr;
    return args;
}
@end
