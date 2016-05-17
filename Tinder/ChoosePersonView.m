//
//  ChoosePersonView.m
//  Tinder
//
//  Created by 张德荣 on 16/5/17.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "ChoosePersonView.h"
#import "ImageLabelView.h"
#import "Person.h"

static const CGFloat ChoosePersonViewImageLabelWidth = 42.f;

@interface ChoosePersonView ()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) ImageLabelView *cameraImageLabelView;
@property (nonatomic, strong) ImageLabelView *interestsImageLabelView;
@property (nonatomic, strong) ImageLabelView *friendsImageLabelView;


@end

@implementation ChoosePersonView

- (instancetype)initWithFrame:(CGRect)frame person:(Person *)person options:(MDCSwipeToChooseViewOptions *)options
{
    self = [super initWithFrame:frame options:options];
    if (self) {
        _person = person;
        self.imageView.image = _person.image;
        
        [self contstructInfomationView];
    }
    return self;
}

- (void)contstructInfomationView {
    CGFloat bottomHeight = 60.f;
    CGRect bottomFrame = CGRectMake(0, CGRectGetHeight(self.bounds)- bottomHeight, CGRectGetWidth(self.bounds), bottomHeight);
    _informationView = [[UIView alloc] initWithFrame:bottomFrame];
    _informationView.backgroundColor = [UIColor whiteColor];
    _informationView.clipsToBounds = YES;
    
    [self addSubview:_informationView];
    
    [self constructNameLabel];
    [self constructCameraImageLabelView];
    [self constructInterestsImageLabelView];
    [self constructFriendsImageLabelView];
}

- (void)constructNameLabel {
    CGFloat leftPadding = 12.f;
    CGFloat topPadding = 17.f;
    CGRect frame = CGRectMake(leftPadding, topPadding, floorf(CGRectGetWidth(_informationView.frame)/2), CGRectGetHeight(_informationView.frame)- topPadding); // floorf 向下取整
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
    _nameLabel.text = [NSString stringWithFormat:@"%@, %@",_person.name,@(_person.age)];
    [_informationView addSubview:_nameLabel];
}

- (void)constructCameraImageLabelView {
    CGFloat rightPadding = 10.f;
    UIImage *image = [UIImage imageNamed:@"camera"];
    _cameraImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetWidth(_informationView.bounds) - rightPadding image:image text:@(_person.numberOfPhotos).stringValue];
    [_informationView addSubview:_cameraImageLabelView];
}

- (void)constructInterestsImageLabelView {
    UIImage *image = [UIImage imageNamed:@"book"];
    _interestsImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetMinX(_cameraImageLabelView.frame) image:image text:@(_person.numberOfPhotos).stringValue];
    [_informationView addSubview:_interestsImageLabelView];
}

- (void)constructFriendsImageLabelView {
    UIImage *image = [UIImage imageNamed:@"group"];
    _friendsImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetMinX(_interestsImageLabelView.frame) image:image text:@(_person.numberOfSharedFriends).stringValue];
    [_informationView addSubview:_friendsImageLabelView];
}
- (ImageLabelView *)buildImageLabelViewLeftOf:(CGFloat)x image:(UIImage *)image text:(NSString *)text{
    CGRect frame = CGRectMake(x - ChoosePersonViewImageLabelWidth, 0, ChoosePersonViewImageLabelWidth, CGRectGetHeight(_informationView.bounds));
    ImageLabelView *view = [[ImageLabelView alloc] initWithFrame:frame image:image text:text];
    return view;
}
@end
