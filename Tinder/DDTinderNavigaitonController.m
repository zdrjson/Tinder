//
//  DDTinderNavigaitonController.m
//  Tinder
//
//  Created by 张德荣 on 16/4/25.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDTinderNavigaitonController.h"

typedef NS_ENUM(NSInteger, DDSlideType) {
    DDSlideTypeLeft = 0,
    DDSlideTypeRight = 1,
};


@interface DDTinderNavigaitonController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *centerContainerView;
@property (nonatomic, strong) UIScrollView *paggingScrollView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UIViewController *rightViewController;



@end

@implementation DDTinderNavigaitonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
