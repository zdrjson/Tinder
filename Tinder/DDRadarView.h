//
//  DDRadarView.h
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat const kavatarViewRadius = 40.0f;
@interface DDRadarView : UIView

- (void)starScan;

- (void)stopScan;

- (void)backAnimation;

@end
