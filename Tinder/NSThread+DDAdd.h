//
//  NSThread+DDAdd.h
//  Tinder
//
//  Created by 张德荣 on 16/6/6.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (DDAdd)
/**
 Add an autorelease pool to current runloop for current thread.
 
 @discussion If you create your own thread (NSThread/pthread), and you use
 runloop to message your task, you may use this mehtod to add an autorelease pool
 to the runloop. Its behavior is the same as the main thread's autorelease pool.
 */
+ (void)addAutoreleasePoolToCurrentRunloop;
@end
