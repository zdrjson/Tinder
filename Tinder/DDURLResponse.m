//
//  DDURLResponse.m
//  Tinder
//
//  Created by 张德荣 on 16/5/31.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDURLResponse.h"

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
@end
