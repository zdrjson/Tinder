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

@interface ChoosePersonVc ()
@property (nonatomic, strong) NSMutableArray *people;

@end

@implementation ChoosePersonVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.frontCardView = [self popPersonViewWithFrame:[self frontCardViewFrame]];
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
        self.backCardView.frame = CGRectMake(frame.origin.x, frame.origin.y - (state.thresholdRatio * 10.f), CGRectGetWidth(frame), CGRectGetHeight(frame));
    };
    
    ChoosePersonView *personView = [[ChoosePersonView alloc] initWithFrame:frame person:self.people[0] options:options];
    [self.people removeObjectAtIndex:0];
    return personView;
    
}
#pragma mark - View Contruction
- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 20.f;
    CGFloat topPadding = 60.f;
    CGFloat bottomPadding = 200.f;
    return CGRectMake(horizontalPadding, topPadding, CGRectGetWidth(self.view.frame) - (horizontalPadding * 2), CGRectGetHeight(self.view.frame) - bottomPadding);
}
- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x, frontFrame.origin.y + 10.f, CGRectGetWidth(frontFrame), CGRectGetHeight(frontFrame));
}
#pragma lazy
- (NSMutableArray *)people
{
    if (!_people) {
        _people = [[NSMutableArray alloc] initWithArray:@[
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
