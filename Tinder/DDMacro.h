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
#ifndef DD_CLAMP // return the clamped value
#define DD_CLAMP(_x_, _low_, _high_) (((_x_) > (_high)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

#ifndef DD_SWAP // swap two value
#define DD_SWAP(_a, _b) do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_;} while (0)
#endif
/**
 Whether in main queue/thread.
 */
static inline bool dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}
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
