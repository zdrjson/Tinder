//
//  DDRadarView.m
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDRadarView.h"
#import <Masonry/Masonry.h>

@interface DDRadarView ()

@property (nonatomic, strong) UIButton *avatarViewBtn;

@end

@implementation DDRadarView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.avatarViewBtn];
        [self.avatarViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            (void)make.center;
            make.size.mas_equalTo(CGSizeMake( kavatarViewRadius * 2, kavatarViewRadius * 2));
        }];
        
    }
    return self;
}

- (UIButton *)avatarViewBtn
{
    if (!_avatarViewBtn) {
        _avatarViewBtn = [[UIButton alloc] init];
        _avatarViewBtn.layer.cornerRadius = kavatarViewRadius ;
        _avatarViewBtn.layer.masksToBounds = YES;
        [_avatarViewBtn addTarget:self action:@selector(avatarViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _avatarViewBtn.backgroundColor = [UIColor redColor];
        
    }
    return _avatarViewBtn;
}
- (void)avatarViewBtnAction
{
    [self click];
}
//点击事件的动画
-(void)click{
    
    CGFloat width = 4;
    CGRect pathFrame = CGRectMake(0, 0, 4, 4);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:width/2];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.avatarViewBtn.center;
    shapeLayer.bounds = path.bounds;
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:1.00f green:0.71f blue:0.71f alpha:1.00f] CGColor];
    shapeLayer.fillColor = [UIColor colorWithRed:1.00f green:0.82f blue:0.82f alpha:1.00f].CGColor;
    shapeLayer.lineWidth = 0.05;
    [self.layer insertSublayer:shapeLayer atIndex:0];
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(60, 60, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,alphaAnimation];
    animation.duration = 2.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    animation.repeatCount = HUGE_VALF;
//    animation.removedOnCompletion = YES;
//     animation.delegate = self;
    
    [shapeLayer addAnimation:animation forKey:nil];
   
    [self performSelector:@selector(removeLayer:) withObject:shapeLayer afterDelay:2];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
//      NSLog(@"%@",self.layer.sublayers);
//    [self.layer.sublayers.firstObject removeFromSuperlayer];
//    [layer removeFromSuperlayer];
//    [layer removeAnimationForKey:@"groupAnnimation"];
    
}
- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
    [layer removeAnimationForKey:@"groupAnnimation"];
  
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
