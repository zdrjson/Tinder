//
//  Person.h
//  Tinder
//
//  Created by 张德荣 on 16/5/17.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) NSUInteger numberOfSharedFriends;
@property (nonatomic, assign) NSUInteger numberOfSharedInterests;
@property (nonatomic, assign) NSUInteger numberOfPhotos;

- (instancetype)initWithName:(NSString *)name
                       image:(UIImage *)image
                         age:(NSUInteger)age
       numberOfSharedFriends:(NSUInteger)numberOfSharedFriends
     numberOfSharedInterests:(NSUInteger)numberOfSharedInterests
              numberOfPhotos:(NSUInteger)numberOfPhotos;
@end
