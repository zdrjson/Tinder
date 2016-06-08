//
//  DDApiProxy.h
//  Tinder
//
//  Created by 张德荣 on 16/6/2.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDURLResponse.h"
typedef void(^AXCallback) (DDURLResponse *response);
@interface DDApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGetWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSDictionary *)params success:(AXCallback)success fail:(AXCallback)fail;

@end
