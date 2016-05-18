//
//  ChoosePersonVc.h
//  Tinder
//
//  Created by 张德荣 on 16/5/17.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePersonView.h"
@interface ChoosePersonVc : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) Person *currrentPerson;
@property (nonatomic, strong) ChoosePersonView *frontCardView;
@property (nonatomic, strong) ChoosePersonView *middelCardView;
@property (nonatomic, strong) ChoosePersonView *backCardView;


@end
