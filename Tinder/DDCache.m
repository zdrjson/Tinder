//
//  DDCache.m
//  Tinder
//
//  Created by 张德荣 on 16/6/28.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDCache.h"
#import "DDNetworkingConfiguration.h"
#import "DDCacheObject.h"

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
#pragma mark - public method
- (NSData *)fetchCacheDataWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams
{
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}
- (void)saveCacheWithData:(NSData *)cachedData serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams
{
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}
- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requesetParams{
    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requesetParams]];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key
{
    DDCacheObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    } else {
        return cachedObject.content;
    }
}
- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key
{
    DDCacheObject *cacheObject = [self.cache objectForKey:key];
    if (cacheObject == nil) {
        cacheObject = [[DDCacheObject alloc] init];
    }
    [cacheObject updateContent:cachedData];
    [self.cache setObject:cacheObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key{
    [self.cache removeObjectForKey:key];
}

-(void)clean {
    [self.cache removeAllObjects];
}
//- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams{
//    return [NSString stringWithFormat:@"%@%@%@",serviceIdentifier,methodName,[requestParams ]]
//}
@end
