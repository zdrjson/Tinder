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
#import "ZLSwipeableViewController.h"
#import "HistoryDemoViewController.h"
#import "CardView.h"


@interface DDMiddleVc () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

#define  Width   [UIScreen mainScreen].bounds.size.width
#define  Height  [UIScreen mainScreen].bounds.size.height
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DDLeftView *leftView;
@property (nonatomic, strong) DDMiddleView *middleView;
@property (nonatomic, strong) DDRightView *rightView;
@property (nonatomic, strong) DDRadarView *ddRadarView;

@property (nonatomic, strong) ZLSwipeableView *swipeableView;

@property (nonatomic, strong) NSString *rightNavBarButtonItemTitle;
@property (nonatomic, strong) UIBarButtonItem *rightNavBarButtonItem;


@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;
@end

@implementation DDMiddleVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorIndex = 0;
    self.colors = @[
                    @"Turquoise",
                    @"Green Sea",
                    @"Emerald",
                    @"Nephritis",
                    @"Peter River",
                    @"Belize Hole",
                    @"Amethyst",
                    @"Wisteria",
                    @"Wet Asphalt",
                    @"Midnight Blue",
                    @"Sun Flower",
                    @"Orange",
                    @"Carrot",
                    @"Pumpkin",
                    @"Alizarin",
                    @"Pomegranate",
                    @"Clouds",
                    @"Silver",
                    @"Concrete",
                    @"Asbestos"
                    ];

    [self setupScrollView];

    
    [self setupChildViews];


    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStyleDone target:self action:@selector(stop)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"star" style:UIBarButtonItemStyleDone target:self action:@selector(star)];
    
    
    self.rightNavBarButtonItemTitle = @"Rewind";
    self.rightNavBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:self.rightNavBarButtonItemTitle
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = _rightNavBarButtonItem;
    [self updateRightBarButtonItem];
    
    
}
- (void)updateRightBarButtonItem {
    NSUInteger historyLength = self.swipeableView.history.count;
    BOOL enabled = historyLength != 0;
    self.navigationItem.rightBarButtonItem.enabled = enabled;
    if (!enabled) {
        self.navigationItem.rightBarButtonItem.title = self.rightNavBarButtonItemTitle;
        return;
    }
    self.navigationItem.rightBarButtonItem.title =
    [NSString stringWithFormat:@"%@(%lu)", self.rightNavBarButtonItemTitle, historyLength];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    [self updateRightBarButtonItem];
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)barButtonItem {
    [self.swipeableView rewind];
    [self updateRightBarButtonItem];
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
    
    
    //中间的View
    [self.middleView addSubview:self.ddRadarView];
    [self.ddRadarView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.center;
        make.size.mas_equalTo(CGSizeMake(kavatarViewRadius * 2, kavatarViewRadius * 2));
    }];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stop];
        self.ddRadarView.hidden = YES;
        [self addSwipView];
        
    });

}

- (void)addSwipView
{
    

    
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenWidth - 20)];
//    swipeableView.backgroundColor = [UIColor yellowColor];
//    swipeableView.subviews.firstObject.backgroundColor = [UIColor greenColor];
//    swipeableView.subviews[1].backgroundColor = [UIColor grayColor];
//    
    NSLog(@"%@",swipeableView.subviews);
    
    self.swipeableView = swipeableView;
    [self.middleView addSubview:self.swipeableView];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    [self.swipeableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(10, 10, 200, 10));
    }];

}


#pragma mark - ZLSwipeableViewDelegate
//
//- (void)swipeableView:(ZLSwipeableView *)swipeableView
//         didSwipeView:(UIView *)view
//          inDirection:(ZLSwipeableViewDirection)direction {
//    //    NSLog(@"did swipe in direction: %zd", direction);
//}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    //    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    //    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    //    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
    //          translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    //    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
    if (!swipeableView.activeViews.count) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
      
            
            
            self.ddRadarView.hidden = NO;
            [self.ddRadarView backAnimation];
            
            [self star];
            
            [swipeableView removeFromSuperview];
            
            
        });
    }
}

#pragma mark - ZLSwipeableViewDataSource
/**
 展示方式
 1.一段时间请求到一定量展示
 
 2.一段时间请求到多少展示多少！
 
 3.请求到一定量展示
 
 展示过程中,请求到的处理
 1.请求到的接到正在展示的后面
 
 2.放到下次再展示
 
 */
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.colorIndex >= self.colors.count) {
        self.colorIndex = 0;
    }
    NSLog(@"%ld %ld",self.colorIndex,self.colors.count);
    NSLog(@"%@",swipeableView.activeViews);
    if (self.colorIndex == 5) {
        return nil;
    }
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = XWRandomColor;
    self.colorIndex++;
    return view;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.swipeableView loadViewsIfNeeded];
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
