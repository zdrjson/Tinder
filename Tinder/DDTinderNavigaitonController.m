//
//  DDTinderNavigaitonController.m
//  Tinder
//
//  Created by 张德荣 on 16/4/25.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDTinderNavigaitonController.h"
#import "DDTinderNavigationBar.h"

typedef NS_ENUM(NSInteger, DDSlideType) {
    DDSlideTypeLeft = 0,
    DDSlideTypeRight = 1,
};


@interface DDTinderNavigaitonController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *centerContainerView;
@property (nonatomic, strong) UIScrollView *paggingScrollView;

@property (nonatomic, strong) DDTinderNavigationBar *paggingNavbar;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UIViewController *rightViewController;



@end

@implementation DDTinderNavigaitonController
#pragma mark - DataSource
- (NSInteger)getCurrentPageIndex {
    return self.currentPage;
}
- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    self.paggingNavbar.currentPage = currentPage;
    self.currentPage = currentPage;
    
    CGFloat pageWidth = CGRectGetWidth(self.paggingScrollView.frame);
    
    [self.paggingScrollView setContentOffset:CGPointMake(currentPage * pageWidth, 0) animated:animated];
}
- (void)reloadData {
    if (!self.paggedViewControllers.count) {
        return;
    }
    [self.paggingScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.paggedViewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect contentViewFrame = viewController.view.bounds;
        contentViewFrame.origin.x = idx * CGRectGetWidth(self.view.bounds);
        viewController.view.frame = contentViewFrame;
        [self.paggingScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
    
    [self.paggingScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds) * self.paggedViewControllers.count, 0)];
    
    self.paggingNavbar.itemViews = self.navbarItemViews;
    [self.paggingNavbar reloadData];
    
    [self setupScrollTop];
    
    [self callBackChangedPage];
}
#pragma mark - Propertys
- (UIView *)centerContainerView
{
    if (!_centerContainerView) {
        _centerContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _centerContainerView.backgroundColor = [UIColor whiteColor];
        
        [_centerContainerView addSubview:self.paggingScrollView];
        [self.paggingScrollView.panGestureRecognizer addTarget:self action:@selector(pageGestureRecognizerHandle:)];
    }
    return _centerContainerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupScrollTop {
	
}

- (void)callBackChangedPage {
	
}

- (void)pageGestureRecognizerHandle:(id)sender {
	
}



@end
