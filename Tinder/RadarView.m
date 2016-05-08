//
//  RadarView.m
//  Tinder
//
//  Created by 张德荣 on 16/5/9.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "RadarView.h"
#define MySize [UIScreen mainScreen].bounds.size
@implementation RadarView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path0 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(MySize.width/2-50, MySize.height/2-50, 100,100) cornerRadius:50];
    [[UIColor redColor]setStroke];
    [[UIColor redColor]setFill];
    [path0 stroke];
    [path0 fill];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //画 1/4  圆
    //center 圆心
    //radius 半径
    //startAngle 起始弧度
    //endAngle 结束弧度
    //clockwise 是否顺时针
    [path addArcWithCenter:CGPointMake(MySize.width/2, MySize.height/2) radius:26 startAngle:M_PI*2 endAngle:M_PI*3 clockwise:YES];
    path.lineWidth = 8;
    [[UIColor yellowColor] setStroke];
    [path stroke];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(MySize.width/2-7, MySize.height/2-10, 14,14) cornerRadius:7];
    [[UIColor yellowColor]setStroke];
    [[UIColor yellowColor]setFill];
    [path1 stroke];
    [path1 fill];

}


@end
