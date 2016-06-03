//
//  DDURLResponse.h
//  Tinder
//
//  Created by 张德荣 on 16/5/31.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetworkingConfiguration.h"

@interface DDURLResponse : NSObject
@property (nonatomic, assign, readonly) DDURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign,readonly) NSInteger requestId;
@property (nonatomic, assign, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy) NSDictionary *requestParams;

@property (nonatomic, assign, readonly) BOOL isCache;
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(DDURLResponseStatus)status;
- (instancetype)initWithResonseString:(NSString *)responseString
                            requestId:(NSNumber *)requestId
                              request:(NSURLRequest *)request
                         responseData:(NSData *)responseData
                                error:(NSError *)error;
//使用initWithData的response,它的isCache是YES,上面两个函数生成的resposne的isCache是NO
- (instancetype)initWithData:(NSData *)data;
@end
