//
//  NSURLRequest+DDNetworkingMethods.m
//  Tinder
//
//  Created by 张德荣 on 16/6/3.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "NSURLRequest+DDNetworkingMethods.h"
#import <objc/runtime.h>
static void *DDNetworkingRequestParams;
@implementation NSURLRequest (DDNetworkingMethods)
- (void)setRequestParams:(NSDictionary *)requestParams{
    objc_setAssociatedObject(self, &DDNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}
- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &DDNetworkingRequestParams);
}
@end
