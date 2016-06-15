//
//  DDLogger.h
//  Tinder
//
//  Created by 张德荣 on 16/6/15.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDURLResponse.h"
#import "DDLogerConfiguration.h"
#import "DDService.h"

@interface DDLogger : NSObject
@property (nonatomic, strong)  DDLogerConfiguration*configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(DDService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;
+ (void)logDebugInfoWithCachedResponse:(DDURLResponse *)response methodName:(NSString *)methodName serviceIdentifier:(DDService *)service;



@end
