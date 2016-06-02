//
//  DDApiProxy.h
//  Tinder
//
//  Created by 张德荣 on 16/6/2.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef void(^AXCallback) ()
@interface DDApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGetWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(
@end
