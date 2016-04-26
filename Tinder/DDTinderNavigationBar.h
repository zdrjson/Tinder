//
//  DDTinderNavigationBar.h
//  Tinder
//
//  Created by 张德荣 on 16/4/26.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDTinderNavigaitonController;
@interface DDTinderNavigationBar : UINavigationBar

@property (nonatomic, strong) NSArray *itemViews;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) CGPoint contentOffSet;

@property (nonatomic, strong) DDTinderNavigaitonController *navigationController;

- (void)reloadData;

@end

@protocol DDTinderNavigationBarItem <NSObject>

@optional

- (void)updateViewWithRatio:(CGFloat)ratio;

@end