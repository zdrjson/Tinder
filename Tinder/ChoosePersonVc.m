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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
