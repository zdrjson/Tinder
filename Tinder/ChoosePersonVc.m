//
//  ChoosePersonVc.m
//  Tinder
//
//  Created by 张德荣 on 16/5/17.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "ChoosePersonVc.h"
#import "Person.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

static const CGFloat ChoosePersonButtonHorizontalPadding = 80.f;
static const CGFloat ChoosePersonButtonVerticalPadding = 20.f;
static const CGFloat horizontalPadding = 20.f;
static const CGFloat topPadding = 60.f;
static const CGFloat bottomPadding = 200.f;

@interface ChoosePersonVc () <MDCSwipeToChooseDelegate>
@property (nonatomic, strong) Person *currrentPerson;
@property (nonatomic, strong) NSMutableArray *people;
@property (nonatomic, strong) ChoosePersonView *frontCardView;
@property (nonatomic, strong) ChoosePersonView *middelCardView;
@property (nonatomic, strong) ChoosePersonView *backCardView;
@end

@implementation ChoosePersonVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]];
    [self.view addSubview:self.backCardView];
    
    self.frontCardView = [self popPersonViewWithFrame:[self frontCardViewFrame]];
    [self.view addSubview:self.frontCardView];
    

    

   
    [self constructNopeButton];
    [self constructLikedButton];
    
}
#pragma mark - MDCSwipeToChooseDelegate
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"You could't decide no %@.",self.currrentPerson.name);
}
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"You noped %@.",self.currrentPerson.name);
    } else {
        NSLog(@"You liked %@.",self.currrentPerson.name);
    }
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]])) {
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backCardView.alpha = 1.f;
        } completion:nil];
    }
}

- (ChoosePersonView *)popPersonViewWithFrame:(CGRect)frame{
    
    if (!self.people.count) {
        return nil;
    }
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.threshold = 160.f;
    options.onPan = ^(MDCPanState *state) {
        CGRect frame = [self backCardViewFrame];
        NSLog(@"%f",state.thresholdRatio);
        self.backCardView.frame = CGRectMake(frame.origin.x, frame.origin.y - (state.thresholdRatio * 10.f), CGRectGetWidth(frame), CGRectGetHeight(frame));
    };
    
    
    
    ChoosePersonView *personView = [[ChoosePersonView alloc] initWithFrame:frame person:self.people[0] options:options];
    [self.people removeObjectAtIndex:0];
    return personView;
    
}
#pragma mark - View Contruction
- (CGRect)frontCardViewFrame {
    return CGRectMake(horizontalPadding, topPadding, CGRectGetWidth(self.view.frame) - (horizontalPadding * 2), CGRectGetHeight(self.view.frame) - bottomPadding);
}
- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x, frontFrame.origin.y + 10.f, CGRectGetWidth(frontFrame), CGRectGetHeight(frontFrame));
}
#pragma mark Control Events
- (void)noneFrontCardView
{
    [self.people addObject:self.people.lastObject];
    [self.frontCardView mdc_swipe:MDCSwipeDirectionLeft];
}
- (void)likeFrontCardView
{
    [self.people addObject:self.people.lastObject];
    [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
}

- (void)constructNopeButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"nope"];
    button.frame = CGRectMake(ChoosePersonButtonHorizontalPadding, CGRectGetMaxY(self.frontCardView.frame) + ChoosePersonButtonVerticalPadding, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:247.f/255.f
                                         green:91.f/255.f
                                          blue:37.f/255.f
                                         alpha:1.f]];
    [button addTarget:self action:@selector(noneFrontCardView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)constructLikedButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"liked"];
    button.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChoosePersonButtonHorizontalPadding, CGRectGetMaxY(self.frontCardView.frame) + ChoosePersonButtonVerticalPadding, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:29.f/255.f
                                         green:245.f/255.f
                                          blue:106.f/255.f
                                         alpha:1.f]];
    [button addTarget:self
               action:@selector(likeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma setter & getter
- (void)setFrontCardView:(ChoosePersonView *)frontCardView
{
    _frontCardView = frontCardView;
    self.currrentPerson = frontCardView.person;
}
- (NSMutableArray *)people
{
    if (!_people) {
        _people = [NSMutableArray arrayWithArray:@[
                                                          [[Person alloc] initWithName:@"Finn"
                                                                                 image:[UIImage imageNamed:@"finn"]
                                                                                   age:15
                                                                 numberOfSharedFriends:3
                                                               numberOfSharedInterests:2
                                                                        numberOfPhotos:1],
                                                          [[Person alloc] initWithName:@"Jake"
                                                                                 image:[UIImage imageNamed:@"jake"]
                                                                                   age:28
                                                                 numberOfSharedFriends:2
                                                               numberOfSharedInterests:6
                                                                        numberOfPhotos:8],
                                                          [[Person alloc] initWithName:@"Fiona"
                                                                                 image:[UIImage imageNamed:@"fiona"]
                                                                                   age:14
                                                                 numberOfSharedFriends:1
                                                               numberOfSharedInterests:3
                                                                        numberOfPhotos:5],
                                                          [[Person alloc] initWithName:@"P. Gumball"
                                                                                 image:[UIImage imageNamed:@"prince"]
                                                                                   age:18
                                                                 numberOfSharedFriends:1
                                                               numberOfSharedInterests:1
                                                                        numberOfPhotos:2],
                                                          ]];
        
        
    }
    return _people;
}
@end
