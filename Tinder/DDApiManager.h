//
//  DDApiManager.h
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDURLResponse.h"
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


/**
 DDApiManager的派生类必须符合这些protocal
 */
@protocol DDApiManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(DDApiManager *)manager beforePerformSuccessWithResponse:(DDURLResponse *)reponse;
- (void)manager:(DDApiManager *)manager afterPerformSuccesWithResponse:(DDURLResponse *)response;

- (BOOL)manager:(DDApiManager *)manager beforePerformFailWithResponse:(DDURLResponse *)response;
- (void)manager:(DDApiManager *)manager afterPerformFailWithResponse:(DDURLResponse *)response;

- (BOOL)manager:(DDApiManager *)manager shouldCallApiWithParams:(NSDictionary *)params;
- (void)manager:(DDApiManager *)manager afterCallingApiWithParams:(NSDictionary *)params;

@end

@protocol DDApiMangerDataReformer <NSObject>

@required
- (id)manager:(DDApiManager *)manager reformData:(NSDictionary *)data;

@end


typedef NS_ENUM(NSUInteger, DDApiManagerErrorType) {
    DDApiManagerErrorTypeDefault,
    DDApiManagerErrorTypeSuccess,
    DDApiManagerErrorTypeNoContent,
    DDApiManagerErrorTypeParamsError,
    DDApiManagerErrorTypeTimeout,
    DDApiManagerErrorTypeNoNetWork
};

@interface DDApiManager : NSObject
@property (nonatomic, weak) id<DDApiMangerCallBackDelegate> delegate;
@property (nonatomic, weak) id<DDApiMangerParamSource> paramSource;
@property (nonatomic, weak) id<DDApiManagerVaildator> validator; //里面会调用NSObject的方法，所以这里不用id
@property (nonatomic, weak) id <DDApiManagerInterceptor>interceptor;

@property (nonatomic, copy, readonly) NSString *errorMessage;

@property (nonatomic, readonly) DDApiManagerErrorType errorType;
@property (nonatomic, strong) DDURLResponse *response;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (id)fetchDataWithReformer:(id<DDApiMangerDataReformer>)reformer;

/**
 尽量使用loadData这个方法，这个方法会通过param source来获得参数,这使得参数的生成逻辑位于controller中的国定位置
 */
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

// 拦截器方法，继承之后需要调用一下super
- (BOOL)beforePerformSuccessWithResponse:(DDURLResponse *)response;
- (BOOL)afterPerformSuccessWithResponse:(DDURLResponse *)response;

- (BOOL)beforePerformFailWithResponse:(DDURLResponse *)response;
- (void)afterPerformFailWithResponse:(DDURLResponse *)response;

- (BOOL)shouldCallApiWithParams:(NSDictionary *)params;
- (void)afterCallingApiWithParams:(NSDictionary *)params;

- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;

- (void)successedOnCallingApi:(DDURLResponse *)response;
- (void)failedOnCallingApi:(DDURLResponse *)response withErrorType:(DDApiManagerErrorType)errorType;
@end
