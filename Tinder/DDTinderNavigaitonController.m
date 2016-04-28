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
    
    [self setupScrollToTop];
    
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
- (UIScrollView *)paggingScrollView
{
    if (!_paggingScrollView) {
        self.paggingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _paggingScrollView.bounces = NO;
        _paggingScrollView.pagingEnabled = YES;
        [_paggingScrollView setScrollsToTop:NO];
        _paggingScrollView.delegate = self;
        _paggingScrollView.showsVerticalScrollIndicator = NO;
        _paggingScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _paggingScrollView;
}
- (DDTinderNavigationBar *)paggingNavbar
{
    if (!_paggingNavbar) {
        self.paggingNavbar = [[DDTinderNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
        _paggingNavbar.backgroundColor = [UIColor clearColor];
        _paggingNavbar.navigationController = self;
        _paggingNavbar.itemViews = self.navbarItemViews;
        [self.view addSubview:_paggingNavbar];
    }
    return _paggingNavbar;
}
- (UIViewController *)getPageViewControllerAtIndex:(NSInteger)index {
    if (index < self.paggedViewControllers.count) {
        return self.paggedViewControllers[index];
    } else {
        return nil;
    }
}
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    
    self.paggingNavbar.currentPage = currentPage + 1;
    
    [self setupScrollToTop];
    [self callBackChangedPage];
}
- (void)setNavbarItemViews:(NSArray *)navbarItemViews
{
    _navbarItemViews = navbarItemViews;
    self.paggingNavbar.itemViews = navbarItemViews;
}
#pragma mark - Life Cycle
- (void)setupTargetViewController:(UIViewController *)targetViewController withSlideType:(DDSlideType)slideType {
    if (!targetViewController) {
        return;
    }
    [self addChildViewController:targetViewController];
    CGRect targetViewFrame = targetViewController.view.frame;
    switch (slideType) {
        case DDSlideTypeLeft: {
            targetViewFrame.origin.x = -CGRectGetWidth(self.view.bounds);
            break;
        }
        case DDSlideTypeRight: {
            targetViewFrame.origin.x = CGRectGetWidth(self.view.bounds) * 2;
            break;
        }
        default:
            break;
    }
    targetViewController.view.frame = targetViewFrame;
    [self.view insertSubview:targetViewController.view atIndex:0];
    [targetViewController didMoveToParentViewController:self];
}
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewContrller {
    return [self initWithLeftViewController:leftViewContrller rightViewController:nil];
}

- (instancetype)initWithRightViewController:(UIViewController *)rightViewController {
    return [self initWithLeftViewController:nil rightViewController:rightViewController];
}

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewContrller rightViewController:(UIViewController *)rightViewContller {
    self = [super init];
    if (self) {
        self.leftViewController = leftViewContrller;
        
        self.rightViewController = rightViewContller;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    [self reloadData];
}
- (void)setupViews {
    [self.view addSubview:self.centerContainerView];
    
    [self setupTargetViewController:self.leftViewController withSlideType:DDSlideTypeLeft];
    [self setupTargetViewController:self.rightViewController withSlideType:DDSlideTypeRight];
}
- (void)dealloc {
    self.paggingScrollView.delegate = nil;
    self.paggingScrollView = nil;
    
    self.paggingNavbar = nil;
    
    self.paggedViewControllers = nil;
    
    self.didChangePageCompleted = nil;
    
}

- (void)callBackChangedPage {
    
}

- (void)pageGestureRecognizerHandle:(id)sender {
    
}



#pragma mark - TableView Helper Method
- (void)setupScrollToTop {
    for (int i = 0; i<self.paggedViewControllers.count; i++) {
        UITableView *tableView = (UITableView *)[self subviewWithClass:[UITableView class] onView:[self getPageViewControllerAtIndex:i].view];
        if (tableView) {
            if (self.currentPage == i) {
                [tableView setScrollsToTop:YES];
            } else {
                [tableView setScrollsToTop:NO];
            }
        }
    }
}
#pragma mark - View Helper Method
- (UIView *)subviewWithClass:(Class)currentClasss onView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:currentClasss]) {
            return subView;
        }
    }
    return nil;
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.paggingNavbar.contentOffSet = scrollView.contentOffset;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(self.paggingScrollView.frame);
                       //向下取整
    self.currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

@end
