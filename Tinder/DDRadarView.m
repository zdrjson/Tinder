//
//  DDRadarView.m
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDRadarView.h"


@interface DDRadarView ()

@property (nonatomic, strong) UIButton *avatarViewBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation DDRadarView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.avatarViewBtn];
        [self.avatarViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            (void)make.center;
            make.size.mas_equalTo(CGSizeMake( kavatarViewRadius * 2, kavatarViewRadius * 2));
        }];
       self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(click) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (UIButton *)avatarViewBtn
{
    if (!_avatarViewBtn) {
        _avatarViewBtn = [[UIButton alloc] init];
        _avatarViewBtn.userInteractionEnabled = NO;
        _avatarViewBtn.layer.cornerRadius = kavatarViewRadius ;
        _avatarViewBtn.layer.masksToBounds = YES;
//        [_avatarViewBtn addTarget:self action:@selector(avatarViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _avatarViewBtn.backgroundColor = [UIColor redColor];
        
    }
    return _avatarViewBtn;
}
- (void)avatarViewBtnAction
{
//    [self click];
}
//点击事件的动画
-(void)click {
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self clickAnimation];
}
- (void)clickAnimation {
    
    [self click];
    
    
    // 移除动画
    [self.avatarViewBtn.layer pop_removeAllAnimations];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    // 设置代理
    spring.delegate            = self;
    
    // 动画起始值 + 动画结束值
    spring.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    spring.toValue             = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    
    // 参数的设置
    //    spring.springSpeed         = 12;
    //    spring.springBounciness    = 11.164021492004395;
    //    spring.dynamicsMass        = 1;
    //    spring.dynamicsFriction    = 8.1296300888061523;
    //    spring.dynamicsTension     = 116.40476226806641;
    
    // 执行动画
    [self.avatarViewBtn.layer pop_addAnimation:spring forKey:nil];

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
  [self backAnimation];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self backAnimation];
}
- (void)backAnimation {
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    // 设置代理
    spring.delegate            = self;
    
    // 动画起始值 + 动画结束值
    spring.fromValue           = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    spring.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    spring.removedOnCompletion = YES;
    
    // 参数的设置
    spring.springSpeed         = 12;
    spring.springBounciness    = 11.164021492004395;
    spring.dynamicsMass        = 1;
    spring.dynamicsFriction    = 8.1296300888061523;
    spring.dynamicsTension     = 116.40476226806641;
    
    // 执行动画
    [self.avatarViewBtn.layer pop_addAnimation:spring forKey:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)starScan {
   [self.timer setFireDate:[NSDate distantPast]];
}

- (void)stopScan {
   [self.timer setFireDate:[NSDate distantFuture]];
}

@end
