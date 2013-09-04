//
//  VCircular.m
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "VCircular.h"
#import "ServiceResult.h"
#import "XmlNode.h"

@interface VCircular ()
+(NSString*)getHandlerXml:(NSString*)xml page:(NSString**)page;
@end

@implementation VCircular
@synthesize Category,GUID,Name,Nick,Mobile;
@synthesize Email,PWD,TypeGuid,TypeName,Created;
@synthesize ExecDate,ApprovalDate,ApprovalMemo,ApprovalStatus,AccountChangeNum;
@synthesize Account,Flag,Ctiy,Number;
@synthesize args;
//通报时间
-(NSString*)formatDataTw{
    NSString *date=[self formatPropertyString:self.Created];
    if ([date length]==0) {return @"";}
    date=[date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSRange range = [date  rangeOfString:@":" options:NSBackwardsSearch];
    if (range.location!=NSNotFound) {
        int pos=range.location;
        date=[date substringWithRange:NSMakeRange(0, pos)];
    }
    int y=[[date substringWithRange:NSMakeRange(0, 4)] intValue];
    return [NSString stringWithFormat:@"%d%@",y-1911,[date stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""]];
}
-(NSString*)formatPropertyString:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return @"";
    }
    return str;
}
/***
   获取类别名称
 ****/
-(NSString*)CategoryName{
    if ([self.Category isEqualToString:@"A"])return @"路平報修";
    if ([self.Category isEqualToString:@"B"])return @"路燈報修";
    if ([self.Category isEqualToString:@"C"])return @"環保查報";
    if ([self.Category isEqualToString:@"D"])return @"寵物協尋";
    if ([self.Category isEqualToString:@"E"])return @"稅務預約";
    if ([self.Category isEqualToString:@"F"])return @"戶政預約";
    return @"";
}
/***
    获取案件状态
 ***/
-(NSString*)ApprovalStatusText{
    if ([self.ApprovalStatus isEqualToString:@"1"]) return @"辦理中";
    return @"已處理";
}
//检查密码是否正确
-(NSString*)CheckPasswordByCircularSoap:(NSString*)type withGUID:(NSString*)guid withPassword:(NSString*)pwd{
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    [msg appendFormat:@"<categorty>%@</categorty>",type];
    [msg appendFormat:@"<guid>%@</guid>",guid];
    [msg appendFormat:@"<pwd>%@</pwd>",pwd];
    return msg;
    //return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"CheckPasswordByCircular"],msg];
}
+(NSString*)getHandlerXml:(NSString*)xml page:(NSString**)page{
    //获取最大页数
    NSString *searchStr=@",";
	NSRange r=[xml rangeOfString:searchStr];
	int recordCount=0;
    int pageCount=1;
	if(r.location!=NSNotFound){
		int pos=r.location;
        recordCount=[[xml substringWithRange:NSMakeRange(0, pos)] intValue];
        xml=[xml stringByReplacingCharactersInRange:NSMakeRange(0, pos+1) withString:@""];
	}
    if (recordCount==0) {
        pageCount=1;
    }else{
        if (recordCount%10==0) {
            pageCount=fabs(recordCount/10);
        }else
            pageCount=fabs(recordCount/10)+1;
    }
    *page=[NSString stringWithFormat:@"%d",pageCount];
    return xml;
}
+(NSArray*)xmlToVCircular:(ServiceResult*)result page:(NSString**)page{
    NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
    [result.xmlParse setDataSource:xml];
    XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//SearchCircularResult"];
    
    xml=[self getHandlerXml:node.Value page:page];
    
    xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"VCircular\"" withString:@""];
    [result.xmlParse setDataSource:xml];
    
    return [result.xmlParse selectNodes:@"//VCircular" className:@"VCircular"];
}
@end
