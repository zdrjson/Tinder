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

@interface DDMiddleVc ()


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DDLeftView *leftView;
@property (nonatomic, strong) DDMiddleView *middleView;
@property (nonatomic, strong) DDRightView *rightView;
@property (nonatomic, strong) DDRadarView *ddRadarView;
@end

@implementation DDMiddleVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView];
//   [self generateContent];
        [self setupChildViews];

    [self.middleView addSubview:self.ddRadarView];
    [self.ddRadarView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.center;
        make.size.mas_equalTo(CGSizeMake(kavatarViewRadius * 2, kavatarViewRadius * 2));
    }];
    
    

//    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(click:) userInfo:nil repeats:YES];
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
        
        view.backgroundColor = [self randomColor];
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


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
