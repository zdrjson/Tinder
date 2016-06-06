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
    CFRelease((CFTypeRef)value);
}

static inline void DDAutoreleasePoolPush() {
    NSMutableDictionary *dic = [NSThread currentThread].threadDictionary;
    NSMutableArray *poolStack = dic[DDNSThreadAutoleasePoolStackKey];
    
    if (!poolStack) {
        /*
         do not retain pool on push,
         but release on pop to avoid memory analyze warning
         */
        CFArrayCallBacks callbacks = {0};
        callbacks.retain = PoolStackRetainCallBack;
        callbacks.release = PoolStackReleaseCallBack;
        poolStack = (id)CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
        dic[DDNSThreadAutoleasePoolStackKey] = poolStack;
        CFRelease(poolStack);
    }
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; //< create
    [poolStack addObject:pool]; // push
}

static inline void DDAutoreleasePoolPop() {
    NSMutableDictionary *dic = [NSThread currentThread].threadDictionary;
    NSMutableArray *poolStack = dic[DDNSThreadAutoleasePoolStackKey];
    [poolStack removeLastObject]; //pop
}

static void DDRunLoopAutoreleasePoolObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry: {
            DDAutoreleasePoolPush();
            break;
        }
        case kCFRunLoopBeforeTimers: {
            
            break;
        }
        case kCFRunLoopBeforeSources: {
            
            break;
        }
        case kCFRunLoopBeforeWaiting: {
            DDAutoreleasePoolPop();
            DDAutoreleasePoolPush();
            break;
        }
        case kCFRunLoopAfterWaiting: {
            
            break;
        }
        case kCFRunLoopExit: {
            DDAutoreleasePoolPop();
            break;
        }
        case kCFRunLoopAllActivities: {
            
            break;
        }
    }
}

static void DDRunloopAutoreleasePoolSetup() {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    CFRunLoopObserverRef pushObserver;
    pushObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopEntry,
                                           true,       // repeat
                                           -0x7FFFFFF, // before other observers
                                           DDRunLoopAutoreleasePoolObserverCallBack, NULL);
    CFRunLoopAddObserver(runloop, pushObserver, kCFRunLoopCommonModes);
    CFRelease(pushObserver);
    
    CFRunLoopObserverRef popObserver;
    popObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting | kCFRunLoopExit,
                                          true,       // repeat
                                          0x7FFFFFF,  // after other observers
                                          DDRunLoopAutoreleasePoolObserverCallBack, NULL);
    CFRunLoopAddObserver(runloop, popObserver, kCFRunLoopCommonModes);
    CFRelease(popObserver);
    
}

@implementation NSThread (DDAdd)
+ (void)addAutoreleasePoolToCurrentRunloop {
    if ([NSThread isMainThread])  return; // The main thread already has autorelease pool.
    NSThread *thread = [self currentThread];
    if (!thread)  return;
    if (thread.threadDictionary[DDNSThreadAutoleasePoolKey])  return; // already added
    DDRunloopAutoreleasePoolSetup();
    thread.threadDictionary[DDNSThreadAutoleasePoolKey] = DDNSThreadAutoleasePoolKey; // mark the state
}
@end
