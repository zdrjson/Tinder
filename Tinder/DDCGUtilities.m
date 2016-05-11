//
//  DDCGUtilities.m
//  Tinder
//
//  Created by 张德荣 on 16/5/11.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDCGUtilities.h"

CGFloat DDScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

CGSize DDScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}
