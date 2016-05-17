//
//  Person.m
//  Tinder
//
//  Created by 张德荣 on 16/5/17.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithName:(NSString *)name
                       image:(UIImage *)image
                         age:(NSUInteger)age
       numberOfSharedFriends:(NSUInteger)numberOfSharedFriends
     numberOfSharedInterests:(NSUInteger)numberOfSharedInterests
              numberOfPhotos:(NSUInteger)numberOfPhotos {
    self = [super init];
    if (self) {
        _name = name;
        _image = image;
        _age = age;
        _numberOfSharedFriends = numberOfSharedFriends;
        _numberOfSharedInterests = numberOfSharedInterests;
        _numberOfPhotos = numberOfPhotos;
    }
    return self;
}
@end
