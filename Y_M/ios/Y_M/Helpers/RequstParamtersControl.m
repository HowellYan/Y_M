//
//  RequstParamtersControl.m
//  Innovation
//
//  Created by Howell on 16/6/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RequstParamtersControl.h"
#import "SignControl.h"
#import "NetConstants.h"
#import "Utils.h"

#define MESSAGE_HEAD(args...) [NSString stringWithFormat:@"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:impl=\"http://impl.websvc\">""<soapenv:Header/>""<soapenv:Body>""<impl:dispatchCommand soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">""<in0 xsi:type=\"soapenc:string\" xs:type=\"type:string\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xs=\"http://www.w3.org/2000/XMLSchema-instance\">%@</in0>""<in1 xsi:type=\"soapenc:string\" xs:type=\"type:string\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xs=\"http://www.w3.org/2000/XMLSchema-instance\"><![CDATA[%@]]></in1>""</impl:dispatchCommand>""</soapenv:Body>""</soapenv:Envelope>",##args]


@implementation RequstParamtersControl

+ (NSString *)keepWithTmnnum:(NSString *)tmnnum;
{
    NSString *keep = [NSString stringWithFormat:@"%@%@%@",tmnnum,[Utils getyyyyMMddHHmmssTimestamp],[Utils getFourDigitRand]];
    return keep;
}

//每个请求都需要的参数
+ (NSDictionary *)getBaseParamsWithChannelCode:(NSString *)channelCode
                                      andMerid:(NSString *)merid
                                     andTmnnum:(NSString *)tmnnum

{
    return @{@"channelCode":channelCode,
             @"merId":merid,
             @"tmnNum":tmnnum,
             @"keep":[self keepWithTmnnum:tmnnum],
             @"vender":@"Apple",
             @"imei":[Utils getIDFA],
             @"imsi":[Utils getIDFA],
             @"clientVersion":[Utils getAPPVesion],
             @"model":[Utils getDeviceModel],
             @"softwareType":[Utils getSystemVersion],
             @"bisChannel":@"02",
             @"aidentifier":[Utils getIDFA],
             @"bestpayId":@"849587348"
             };
}

+ (NSDictionary *)getTheRequsetParamtersByParamters:(NSDictionary *)paramters
                                     andChannelCode:(NSString *)channelCode
                                           andMerid:(NSString *)merid
                                          andTmnnum:(NSString *)tmnnum
                                      andRequstType:(NSString *)Type
                                         andDesRand:(NSString *)desRand ;

{
    //获取基本参数
    NSDictionary *baseDict = [self getBaseParamsWithChannelCode:channelCode
                                                       andMerid:merid
                                                      andTmnnum:tmnnum];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:baseDict];
    
    [dic addEntriesFromDictionary:paramters];
    
    if (![Type isEqualToString: @"sign0"]) {
        //加签情况
        [dic setObject:[SignControl getTheSignByParamters:dic
                                           andRequstType:Type
                                               andDesRand:desRand] forKey:@"sign"];
    }
    
    return dic;
}
//每个请求都需要的参数======
+ (NSDictionary *)getBaseParamsWithChannelCode:(NSString *)channelCode
                                      andMerid:(NSString *)merid
                                     AndTmnnum:(NSString *)tmnnum

{
    return @{@"channelCode":channelCode,
             @"merId":merid,
             @"tmnNum":tmnnum,
             @"keep":[self keepWithTmnnum:tmnnum],
             @"vender":@"Apple",
             @"imei":[Utils getIDFA],
             @"imsi":[Utils getIDFA],
             @"clientVersion":[Utils getAPPVesion],
//             @"model":[Utils getDeviceModel],
             @"softwareType":[Utils getSystemVersion],
             @"bisChannel":@"02",
             @"aidentifier":[Utils getIDFA],
             @"bestpayId":@"849587348"
             };
}
//======
+ (NSDictionary *)getRequsetParamtersByParamters:(NSDictionary *)paramters
                                     andChannelCode:(NSString *)channelCode
                                           andMerid:(NSString *)merid
                                          andTmnnum:(NSString *)tmnnum
                                      andRequstType:(NSString *)Type
                                         andDesRand:(NSString *)desRand ;

{
    NSDictionary *baseDict = [self getBaseParamsWithChannelCode:channelCode
                                                       andMerid:merid
                                                      AndTmnnum:tmnnum];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:baseDict];
    
    [dic addEntriesFromDictionary:paramters];
    
    if (![Type isEqualToString: @"sign0"]) {
        //加签情况
        [dic setObject:[SignControl getTheSignByParamters:dic
                                            andRequstType:Type
                                               andDesRand:desRand] forKey:@"sign"];
    }
    
    return dic;
}

+ (NSDictionary *)getNewRequsetParamtersByParamters:(NSDictionary *)paramters
                                     andChannelCode:(NSString *)channelCode
                                        andMerid:(NSString *)merid
                                       andTmnnum:(NSString *)tmnnum
                                   andRequstType:(NSString *)Type
                                      andDesRand:(NSString *)desRand    ;

{
    NSDictionary *baseDict = [self getBaseParamsWithChannelCode:channelCode
                                                       andMerid:merid
                                                      AndTmnnum:tmnnum];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:baseDict];
    
    [dic addEntriesFromDictionary:paramters];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict removeObjectForKey:@"vender"];
    [dict removeObjectForKey:@"softwareType"];
    [dict removeObjectForKey:@"keep"];
    [dict removeObjectForKey:@"clientVersion"];
    [dict removeObjectForKey:@"channelCode"];
    [dict removeObjectForKey:@"bisChannel"];
    [dict removeObjectForKey:@"imei"];
    [dict removeObjectForKey:@"imsi"];
    [dict removeObjectForKey:@"remark"];
    if (![Type isEqualToString: @"sign0"]) {
        //加签情况
        [dic setObject:[SignControl getTheSignByParamters:dict
                                            andRequstType:Type
                                               andDesRand:desRand] forKey:@"sign"];
    }
    
    return dic;
}



+(NSString *)getRandArg0WithServiceCode:(NSString *)serviceCode
{
    return [NSString stringWithFormat:@"%@|%@-APP001-001-%@-|%@|",serviceCode];
}



@end
