//
//  DDNavigationBarItem.m
//  Tinder
//
//  Created by 张德荣 on 16/4/28.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDNavigationBarItem.h"

@interface DDNavigationBarItem ()

@property (nonatomic, strong) UIView *coloredView;

@end

@implementation DDNavigationBarItem
- (UIView *)coloredView
{
    if (!_coloredView) {
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = YES;
        
        self.coloredView = [[UIView alloc] initWithFrame:self.bounds];
        self.coloredView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_coloredView];
    }
    return _coloredView;
}
- (void)updateViewWithRatio:(CGFloat)ratio
{
    self.coloredView.alpha = ratio;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
