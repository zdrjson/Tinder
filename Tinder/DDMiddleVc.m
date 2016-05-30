//
//  DDMiddleVc.m
//  Tinder
//
//  Created by 张德荣 on 16/5/27.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDMiddleVc.h"
#import "DDLeftView.h"
#import "DDMiddleView.h"
#import "DDRightView.h"
#import "DDRadarView.h"
#import <Masonry/Masonry.h>
static CGFloat const kavatarViewRadius = 40.0f;
@interface DDMiddleVc ()

@property (nonatomic, strong) UIButton *avatarViewBtn;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DDLeftView *leftView;
@property (nonatomic, strong) DDMiddleView *middleView;
@property (nonatomic, strong) DDRightView *rightView;

@end

@implementation DDMiddleVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupScrollView];
  
    
//    [self  setupLeftView];
//    [self  setupMiddleView];
//    [self  setupRightView];
//    [self setupChildViews];
    
//    [self.view addSubview:self.avatarViewBtn];
    
//    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(click) userInfo:nil repeats:YES];
}
- (void)setupChildViews
{
    UIView* contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    CGFloat height = [UIScreen mainScreen].bounds.size.width;
    
    for (int i = 0; i < 1; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        [contentView addSubview:view];
        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//        [view addGestureRecognizer:singleTap];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView ? lastView.mas_right : @0);
            make.top.equalTo(@0);
            make.height.equalTo(contentView.mas_height);
            make.width.equalTo(@(height));
        }];
        
        height += [UIScreen mainScreen].bounds.size.width;
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right);
    }];
    
}
- (void)setupScrollView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
    [self generateContent];

}
- (void) setupLeftView {
    
//    [self.scrollView addSubview:self.leftView];
//    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(-self.view.frame.size.width);
//        make.edges.equalTo(self.scrollView);
//        make.height.equalTo(self.scrollView);
//        
//    }];
//    self.leftView.backgroundColor = [UIColor redColor];

    
}
- (void) setupMiddleView
{
    
}
- (void) setupRightView
{
    
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
- (DDRightView *)rightView
{
    if (!_rightView) {
        _rightView = [[DDRightView alloc] init];
    }
    return _rightView;
}
- (DDLeftView *)leftView
{
    if (!_leftView) {
        _leftView = [[DDLeftView alloc] init];
    }
    return _leftView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
           _scrollView.backgroundColor = [UIColor grayColor];
//        _scrollView.contentSize = CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height);
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
- (void)generateContent {
    UIView* contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    CGFloat height = 25;
    
    for (int i = 0; i < 10; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        [contentView addSubview:view];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [view addGestureRecognizer:singleTap];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.mas_bottom : @0);
            make.left.equalTo(@0);
            make.width.equalTo(contentView.mas_width);
            make.height.equalTo(@(height));
        }];
        
        height += 25;
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)singleTap:(UITapGestureRecognizer*)sender {
    [sender.view setAlpha:sender.view.alpha / 1.20]; // To see something happen on screen when you tap :O
    [self.scrollView scrollRectToVisible:sender.view.frame animated:YES];
};
- (void)avatarViewBtnAction
{
     [self click];
}
@end
