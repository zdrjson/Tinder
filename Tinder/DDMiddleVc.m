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

//RGB颜色
#define XWColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XWColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//随机色
#define XWRandomColor XWColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
@interface DDMiddleVc ()

#define  Width   [UIScreen mainScreen].bounds.size.width
#define  Height  [UIScreen mainScreen].bounds.size.height
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DDLeftView *leftView;
@property (nonatomic, strong) DDMiddleView *middleView;
@property (nonatomic, strong) DDRightView *rightView;
@property (nonatomic, strong) DDRadarView *ddRadarView;
@property (nonatomic, strong) UIButton *showView;
@end

@implementation DDMiddleVc
- (void)initButton {
    
    
    
    CGFloat width                    = 80.f;
    self.showView                    = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    self.showView.center             = self.view.center;
    self.showView.backgroundColor    = [UIColor cyanColor];
    self.showView.layer.cornerRadius = width / 2.f;
    [self.middleView addSubview:self.showView];
    [self.showView addTarget:self action:@selector(doAnimation) forControlEvents:UIControlEventTouchUpInside];
}

- (void)doAnimation {
    
    // 移除动画
    [self.showView.layer pop_removeAllAnimations];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    // 设置代理
    spring.delegate            = self;
    
    // 动画起始值 + 动画结束值
    spring.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    spring.toValue             = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    spring.removedOnCompletion = NO;
    // 参数的设置
    spring.springSpeed         = 12;
    spring.springBounciness    = 11.164021492004395;
    spring.dynamicsMass        = 1;
    spring.dynamicsFriction    = 8.1296300888061523;
    spring.dynamicsTension     = 116.40476226806641;
    
    // 执行动画
    [self.showView.layer pop_addAnimation:spring forKey:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView];

    
    [self setupChildViews];

//    [self initButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStyleDone target:self action:@selector(stop)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"star" style:UIBarButtonItemStyleDone target:self action:@selector(star)];
}
- (void)stop {
    [self.ddRadarView stopScan];
}
- (void)star {
     [self.ddRadarView starScan];
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
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    for (int i = 0; i < 3; i++) {
        UIView *view = UIView.new;
        
        view.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastView ? lastView.mas_right : @0);
            make.top.equalTo(@0);
            make.height.equalTo(contentView.mas_height);
            make.width.equalTo(@(width));
        }];
        
        switch (i) {
            case 0:
            {
                self.leftView = (DDLeftView *)view;
            }
                break;
            case 1:
            {
                self.middleView = (DDMiddleView *)view;
            }
                break;
            case 2:
            {
                self.rightView = (DDRightView *)view;
            }
                break;
                
            default:
                break;
        }
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right);
    }];
    
    
    
    [self.middleView addSubview:self.ddRadarView];
    [self.ddRadarView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.center;
        make.size.mas_equalTo(CGSizeMake(kavatarViewRadius * 2, kavatarViewRadius * 2));
    }];


}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
     [self.scrollView setContentOffset: CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];
}
- (void)setupScrollView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
}
- (DDRadarView *)ddRadarView
{
    if (!_ddRadarView) {
        _ddRadarView = [[DDRadarView alloc] init];
    }
    return _ddRadarView;
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
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}





@end
