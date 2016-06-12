//
//  ViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLSwipeableViewController.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"

@interface ZLSwipeableViewController ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;

@property (nonatomic) BOOL loadCardFromXib;

@property (nonatomic, strong) UIBarButtonItem *reloadBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *upBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *downBarButtonItem;
@end

@implementation ZLSwipeableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.toolbarHidden = NO;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view, typically from a nib.
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

;

    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    [self.view addSubview:self.swipeableView];

    // Required Data Source
    self.swipeableView.dataSource = self;

    // Optional Delegate
    self.swipeableView.delegate = self;


//    NSLog(@"%@",self.swipeableView.subviews);

    
    [self.swipeableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(10, 10, 200, 10));
    }];

}

- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
//    NSLog(@"did swipe in direction: %zd", direction);
}

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
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
     NSLog(@"%ld %ld",self.colorIndex,self.colors.count);
    if (self.colorIndex >= self.colors.count) {
        self.colorIndex = 0;
    }
    if (self.colorIndex == 5)  return nil;
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = XWRandomColor;
    self.colorIndex++;
    return view;
}





@end
