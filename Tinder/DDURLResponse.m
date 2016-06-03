//
//  DDURLResponse.m
//  Tinder
//
//  Created by 张德荣 on 16/5/31.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDURLResponse.h"
#import "NSURLRequest+DDNetworkingMethods.h"
@interface DDURLResponse ()
@property (nonatomic, assign, readwrite) DDURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, assign,readwrite) NSInteger requestId;
@property (nonatomic, assign, readwrite) NSURLRequest *request;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;
@end

@implementation DDURLResponse
#pragma mark - liftcycle
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(DDURLResponseStatus)status {
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.isCache = NO;
        
    }
    return self;
}
- (instancetype)initWithResonseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}
#pragma mark - private methods
- (DDURLResponseStatus)responseStatusWithError:(NSError *)error {
    if (error) {
        DDURLResponseStatus result = DDURLResponseStatusErrorTimeout;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = DDURLResponseStatusNoNetwork;
        }
        return result;
    } else {
        return DDURLResponseStatusSuccess;
    }
}
@end
