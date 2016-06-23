//
//  NetConstants.h
//  Innovation
//
//  Created by Howell on 16/6/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#ifndef NetConstants_h
#define NetConstants_h


#endif /* NetConstants_h */

// 切换环境变量
#define variable this


//--------------------------------------------------------------------- this环境  ----------------------------------------------------------------------
#if (variable == this)
#define URL            @"http://localhost:8081/"


//--------------------------------------------------------------------- dev环境  ----------------------------------------------------------------------
#elif (variable == dev)
#define URL            @"http://172.26.13.104:8081/"

#endif

#define ChannelCode  @"20"