//
//  DDTinderNavigationBar.m
//  Tinder
//
//  Created by 张德荣 on 16/4/26.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDTinderNavigationBar.h"
#import "DDTinderNavigaitonController.h"

#define WIDTH self.bounds.size.width
#define IMAGESIZE 30
#define SPEED 2.45
#define Y_POSITION 28

@interface DDTinderNavigationBar ()

@end

@implementation DDTinderNavigationBar
#pragma mark - DataSource
- (void)reloadData {
    if (!self.items.count) {
        return;
    }
    [self.itemViews enumerateObjectsUsingBlock:^(UIView<DDTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGFloat width = WIDTH - 30;
        CGFloat step = (width / 2 - 15) * idx + 15;
        
        CGRect itemViewFrame = CGRectMake(step, Y_POSITION, IMAGESIZE, IMAGESIZE);
        itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        itemView.frame = itemViewFrame;
        if (self.currentPage + 1 == idx) {
            [self updateItemView:itemView withRation:1.0];
        } else {
            [self updateItemView:itemView withRation:0.0];
        }

    }];
}
- (void)tapGestureHandle:(UITapGestureRecognizer *)tapGesture {
    NSInteger pageIndex = [self.itemViews indexOfObject:tapGesture.view];
    [self.navigationController setCurrentPage:pageIndex animated:YES];
}
#pragma mark - Other
- (void)updateItemView:(UIView<DDTinderNavigationBarItem> *)itemView withRation:(CGFloat)ration {
    if ([itemView respondsToSelector:@selector(updateViewWithRatio:)]) {
        [itemView updateViewWithRatio:ration];
    }
}
#pragma mark - Properties
- (void)setContentOffSet:(CGPoint)contentOffSet {
    _contentOffSet = contentOffSet;
    
    CGFloat xOffset = contentOffSet.x;
    
    CGFloat normalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    [self.itemViews enumerateObjectsUsingBlock:^(UIView<DDTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat width = WIDTH - 30;
        CGFloat step = (width / 2 - 15) * idx + 15;
        
        CGRect itemViewFrame = itemView.frame;
        itemViewFrame.origin.x = step - (xOffset - normalWidth) / SPEED;
        itemView.frame = itemViewFrame;
        
        CGFloat ratio;
        if (xOffset < normalWidth * idx) {
            ratio = (xOffset - normalWidth * (idx - 1)) / normalWidth;
        } else {
            ratio = 1 - ((xOffset - normalWidth * idx) / normalWidth);
        }
        
        [self updateItemView:itemView withRation:ratio];
    }];
    
}
- (void)setItemViews:(NSArray *)itemViews {
    if (itemViews) {
        [self.itemViews enumerateObjectsUsingBlock:^(UIView<DDTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL * _Nonnull stop) {
            [itemView removeFromSuperview];
        }];
        
        [itemViews enumerateObjectsUsingBlock:^(UIView<DDTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL * _Nonnull stop) {
            itemView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            [itemView addGestureRecognizer:tapGesture];
            [self addSubview:itemView];
        }];
    }
    _itemViews = itemViews;
}
#pragma mark - Lift Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}
- (void)dealloc
{
    self.itemViews = nil;
}


@end
