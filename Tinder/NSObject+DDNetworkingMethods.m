//
//  NSObject+DDNetworkingMethods.m
//  Tinder
//
//  Created by 张德荣 on 16/7/15.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "NSObject+DDNetworkingMethods.h"

@implementation NSObject (DDNetworkingMethods)


- (id)DD_defaultValue:(id)defaultData {
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
          
    if ([self DD_isEmptyObject]) {
        return defaultData;
    }
    
    return self;
    
}

- (BOOL)DD_isEmptyObject {
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
    
}
@end
