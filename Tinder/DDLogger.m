//
//  DDLogger.m
//  Tinder
//
//  Created by 张德荣 on 16/6/15.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDLogger.h"

@interface DDLogger ()
@property (nonatomic, strong,readwrite)  DDLogerConfiguration*configParams;
@end

@implementation DDLogger
+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(DDService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod
{
#ifdef DEBUG
    BOOL isOnline = NO;
    if ([service respondsToSelector:@selector(isOnline)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[service methodSignatureForSelector:@selector(isOnline)]];
        invocation.target = service;
        invocation.selector = @selector(isOnline);
        [invocation invoke];
        [invocation getReturnValue:&isOnline];
        
    }
#endif
}


@end
