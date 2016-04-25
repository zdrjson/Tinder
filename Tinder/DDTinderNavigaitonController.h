//
//  DDTinderNavigaitonController.h
//  Tinder
//
//  Created by 张德荣 on 16/4/25.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DDDidChangePageBlock)(NSInteger currentPage, NSString *title);

@interface DDTinderNavigaitonController : UIViewController
@property (nonatomic, copy) DDDidChangePageBlock didChangePageCompleted;

@property (nonatomic, strong) NSArray *paggedViewControllers;
@property (nonatomic, strong) NSArray *navbarItemViews;

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewContrller;

- (instancetype)initWithRightViewController:(UIViewController *)rightViewController;

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewContrller rightViewController:(UIViewController *)rightViewContller;

- (NSInteger)getCurrentPageIndex;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

- (void)reloadData;
@end
