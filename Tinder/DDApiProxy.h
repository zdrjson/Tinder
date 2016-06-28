//
//  DDApiProxy.h
//  Tinder
//
//  Created by 张德荣 on 16/6/2.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDURLResponse.h"
typedef void(^AXCallback) (DDURLResponse *response);
@interface DDApiProxy : NSObject

+ (instancetype)sharedInstance;
/**
 Get方法
 
 @param params           参数
 @param servieIdentifier 服务Id
 @param methodName       方法名
 @param success          成功回调回调
 @param fail             失败回调
 
 @return requestId
 */
- (NSInteger)callGetWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviedIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdetifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestList:(NSArray *)requestList;
@end
