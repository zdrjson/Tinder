//
//  DDCGUtilities.h
//  Tinder
//
//  Created by 张德荣 on 16/5/11.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>


/// Get main screen's scale
CGFloat DDScreenScale();
/// Get main screen's size. Height is always larger than width.
CGSize DDScreenSize();

/// Convert degrees to radians.
static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}
/// Convert radians to degrees.
static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}