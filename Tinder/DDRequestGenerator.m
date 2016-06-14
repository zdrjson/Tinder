//
//  DDRequestGenerator.m
//  Tinder
//
//  Created by 张德荣 on 16/6/14.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>

@interface DDRequestGenerator ()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation DDRequestGenerator

+ (instancetype)sharedInstance
{
    static DDRequestGenerator* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DDRequestGenerator new];
    });

    return instance;
}

//- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
//                                            requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
//	
//}


@end
