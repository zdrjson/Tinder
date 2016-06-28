//
//  DDCache.h
//  Tinder
//
//  Created by 张德荣 on 16/6/28.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCache : NSObject

+ (instancetype)sharedInstance;

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                         requestParams:(NSDictionary *)requestParams;

- (NSData *)fetchCacheDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                     methodName:(NSString *)methodName
                                  requestParams:(NSDictionary *)requestParams;
- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;
- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                              methodName:(NSString *)methodName
                           requestParams:(NSDictionary *)requesetParams;
@end
