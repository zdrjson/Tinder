//
//  NSThread+DDAdd.m
//  Tinder
//
//  Created by 张德荣 on 16/6/6.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "NSThread+DDAdd.h"
#import <CoreFoundation/CoreFoundation.h>

@interface NSThread_DDAdd : NSObject @end

@implementation NSThread_DDAdd @end

#if __has_feature(objc_arc)
#error This file must be compiled without ARC. Specify the -fno-objc-arc flag to this file.
#endif

static NSString *const DDNSThreadAutoleasePoolKey = @"DDNSThreadAutoleasePoolKey";
static NSString *const DDNSThreadAutoleasePoolStackKey = @"DDNSThreadAutoleasePoolStackKey";

static const void *PoolStackRetainCallBack(CFAllocatorRef allocator, const void *value) {
    return value;
}

static void PoolStackReleaseCallBack(CFAllocatorRef allocator, const void *value) {
    
}
@implementation NSThread (DDAdd)

@end
