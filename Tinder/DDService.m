//
//  DDService.m
//  Tinder
//
//  Created by 张德荣 on 16/6/14.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDService.h"

@implementation DDService
@synthesize publicKey = _publicKey;
@synthesize apiVersion = _apiVersion;
@synthesize privateKey = _privateKey;
@synthesize apiBaseUrl = _apiBaseUrl;

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(DDServiceProtocal)]) {
            self.child = (id<DDServiceProtocal>)self;
        }
    }
    return self;
}
#pragma mark - getter and setters

- (NSString *)privateKey
{
    return self.child.isOnline? self.child.onlinePrivateKey:self.child.offlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.isOnline? self.child.onlinePublicKey:self.child.offlinePublicKey;
}
- (NSString *)apiBaseUrl
{
    return self.child.isOnline? self.child.onlineApiBaseUrl:self.child.offlineApiBaseUrl;
}
- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}





@end
