//
//  RequestParams.h
//  Innovation
//
//  Created by Howell on 16/6/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestParams : NSObject

//request params
+ (NSDictionary *)setCPSServiceParams:(NSDictionary *)request token:(NSString *)token flagSign:(bool)flagSign;

@end
