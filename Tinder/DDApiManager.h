//
//  DDApiManager.h
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDApiManager;

//api回调
@protocol DDApiMangerCallBackDelegate <NSObject>

- (void)managerCallApiDidSuccess:(DDApiManager *)manager;
- (void)managerCallApiDidFailed:(DDApiManager *)manager;

@end


//让manager能够获取调用Api所需要的数据
@protocol DDApiMangerParamSource <NSObject>

@required
- (NSDictionary *)paramsForApi:(DDApiManager *)manager;

@end

@protocol DDApiManagerVaildator <NSObject>

@required
- (BOOL)manager:(DDApiManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

@end

@interface DDApiManager : NSObject
@property (nonatomic, weak) id<DDApiMangerCallBackDelegate> delegate;
@property (nonatomic, weak) id<DDApiMangerParamSource> paramSource;
@property (nonatomic, weak) id<DDApiManagerVaildator> *child; 
@end
