//
//  DDApiProxy.m
//  Tinder
//
//  Created by 张德荣 on 16/6/2.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDApiProxy.h"
#import <AFNetworking/AFNetworking.h>

@interface DDApiProxy ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation DDApiProxy
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail {
    NSLog(@"%@",request.URL);
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @(dataTask.taskIdentifier);
        
    }];
    return @0;
}
@end
