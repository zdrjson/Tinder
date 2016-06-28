//
//  DDCache.m
//  Tinder
//
//  Created by 张德荣 on 16/6/28.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDCache.h"
#import "DDNetworkingConfiguration.h"

@interface DDCache ()
@property (nonatomic, strong) NSCache *cache;
@end

@implementation DDCache
- (NSCache *)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kCTCacheCountLimit;
    }
    return _cache;
}
+ (instancetype)sharedInstance
{
    static DDCache* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DDCache new];
    });

    return instance;
}

@end
