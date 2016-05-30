//
//  DDMiddleVc.m
//  Tinder
//
//  Created by 张德荣 on 16/5/27.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDMiddleVc.h"
static CGFloat const kavatarViewRadius = 40.0f;
@interface DDMiddleVc ()

@property (nonatomic, strong) UIButton *avatarViewBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation DDMiddleVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.avatarViewBtn];
    
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(click) userInfo:nil repeats:YES];
}


//点击事件的动画
-(void)click{
    
    CGFloat width = 4;
    CGRect pathFrame = CGRectMake(0, 0, 4, 4);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:width/2];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.view.center;
    shapeLayer.bounds = path.bounds;
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:1.00f green:0.71f blue:0.71f alpha:1.00f] CGColor];
    shapeLayer.fillColor = [UIColor colorWithRed:1.00f green:0.82f blue:0.82f alpha:1.00f].CGColor;
    shapeLayer.lineWidth = 0.05;
    [self.view.layer insertSublayer:shapeLayer atIndex:0];
    
    
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
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [shapeLayer addAnimation:animation forKey:@"groupAnnimation"];
    
    [self performSelector:@selector(removeLayer:) withObject:shapeLayer afterDelay:2];

}


- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
    [layer removeAnimationForKey:@"groupAnnimation"];
    NSLog(@"%@",self.view.layer.sublayers);
    
}

- (UIButton *)avatarViewBtn
{
    if (!_avatarViewBtn) {
        _avatarViewBtn = [[UIButton alloc] init];
       
        _avatarViewBtn.frame = CGRectMake(0, 0, kavatarViewRadius * 2, kavatarViewRadius * 2);
         _avatarViewBtn.center = self.view.center;
        _avatarViewBtn.layer.cornerRadius = kavatarViewRadius ;
        _avatarViewBtn.layer.masksToBounds = YES;
        [_avatarViewBtn addTarget:self action:@selector(avatarViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _avatarViewBtn.backgroundColor = [UIColor redColor];
        
    }
    return _avatarViewBtn;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.frame;
        _scrollView.contentSize = CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height);
    }
    return _scrollView;
}
- (void)avatarViewBtnAction
{
     [self click];
}
@end
