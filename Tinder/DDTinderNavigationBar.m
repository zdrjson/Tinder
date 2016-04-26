//
//  DDTinderNavigationBar.m
//  Tinder
//
//  Created by 张德荣 on 16/4/26.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDTinderNavigationBar.h"
#import "DDTinderNavigaitonController.h"
@interface DDTinderNavigationBar ()

@end

@implementation DDTinderNavigationBar
#pragma mark - DataSource
- (void)reloadData {
    if (!self.items.count) {
        return;
    }
    [self.itemViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
    }];
}
- (void)tapGestureHandle:(UITapGestureRecognizer *)tapGesture {
    NSInteger pageIndex = [self.itemViews indexOfObject:tapGesture.view];
    [self.navigationController setCurrentPage:pageIndex animated:YES];
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
