//
//  DDTinderNavigationBar.m
//  Tinder
//
//  Created by 张德荣 on 16/4/26.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDTinderNavigationBar.h"

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
