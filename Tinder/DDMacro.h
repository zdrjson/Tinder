//
//  DDMacro.h
//  Tinder
//
//  Created by 张德荣 on 16/4/27.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/time.h>
#import <pthread.h>

#ifndef DDMacro_h
#define DDMacro_h

#ifdef __cplusplus
#define DD_EXTERN_C_BEGIN extern "C" {
#define DD_EXTERN_C_END  }
#else
#define DD_EXTERN_C_BEGIN
#define DD_EXTERN_END
#endif

DD_EXTERN_C_BEGIN
/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue), block);
    }
}
DD_EXTERN_C_END
#endif /* DDMacro_h */
