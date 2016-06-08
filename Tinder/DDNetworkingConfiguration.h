//
//  DDNetworkingConfiguration.h
//  Tinder
//
//  Created by 张德荣 on 16/6/2.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#ifndef DDNetworkingConfiguration_h
#define DDNetworkingConfiguration_h
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, DDAppType) {
    DDAppTypexxx,
};

typedef NS_ENUM(NSUInteger, DDURLResponseStatus) {
    DDURLResponseStatusSuccess,  //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的DDApiBaseManager来决定
    DDURLResponseStatusErrorTimeout,
    DDURLResponseStatusNoNetwork  //默认出了超时以外的错误都是无网络错误
};

static NSString *DDKeychainServiceName = @"xxxxx";
static NSString *DDUDIDName = @"xxxx";
static NSString *DDPasteboardType = @"xxxx";

static BOOL kCTShouldCache = YES;
static BOOL kCTServiceOnline = NO;

static NSTimeInterval kCTNetworkingTimeoutSeconds = 20.0f;
static NSTimeInterval KCTCacheOutdateTimeSeconds = 300;//5分钟的cache过期时间
static NSUInteger kCTCacheCountLimit = 1000; //最多1000条cache
//services
extern NSString *const kCTServiceGDMapV3;


#endif /* DDNetworkingConfiguration_h */
