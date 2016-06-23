//
//  RequestParams.m
//  Innovation
//
//  Created by Howell on 16/6/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParams.h"
#import "Utils.h"
#import "SignControl.h"
#import "NetConstants.h"

@implementation RequestParams  

+ (NSDictionary *)setCPSServiceParams:(NSDictionary *)request token:(NSString *)token  flagSign:(bool)flagSign
{
  NSDictionary *jsonObject = request;
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:jsonObject];


  [dic setObject:@"02" forKey:@"bisChannel"];
  [dic setObject:@"iOS" forKey:@"systemType"];
  [dic setObject:@"Apple" forKey:@"vender"];
  [dic setObject:ChannelCode forKey:@"channelCode"];

  
  [dic setObject:[Utils getIDFA] forKey:@"imei"];
  [dic setObject:[Utils getIDFA] forKey:@"imsi"];
  [dic setObject:[Utils getIDFA] forKey:@"aidentifier"];
  [dic setObject:[Utils getAPPVesion] forKey:@"clientVersion"];
  [dic setObject:[Utils getDeviceModel] forKey:@"model"];
  [dic setObject:[Utils getSystemVersion] forKey:@"systemVersion"];
  
  if(flagSign == true){
    [dic setObject:[SignControl getTheSignByParamters:dic andRequstType:@"sign1" andDesRand:@""] forKey:@"sign"];
  } else {
    [dic setObject:[SignControl getTheSignByParamters:dic andRequstType:@"sign1" andDesRand:@"0123456789abcde"] forKey:@"sign"];
  }
  
  jsonObject = [NSDictionary dictionaryWithDictionary:dic];
  return jsonObject;
}



@end