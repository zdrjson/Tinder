//
//  DDApiBaseManager.h
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDURLResponse.h"
@class DDApiBaseManager;

//api回调
@protocol DDApiMangerCallBackDelegate <NSObject>

- (void)managerCallApiDidSuccess:(DDApiBaseManager *)manager;
- (void)managerCallApiDidFailed:(DDApiBaseManager *)manager;

@end


//让manager能够获取调用Api所需要的数据
@protocol DDApiMangerParamSource <NSObject>

@required
- (NSDictionary *)paramsForApi:(DDApiBaseManager *)manager;

@end

@protocol DDApiBaseManagerVaildator <NSObject>

@required
- (BOOL)manager:(DDApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

@end
typedef NS_ENUM(NSUInteger, DDApiBaseManagerRequestType) {
    DDApiBaseManagerRequestTypeGet,
    DDApiBaseManagerRequestTypePost,
    DDApiBaseManagerRequestTypePut,
    DDApiBaseManagerRequestTypeDelete
};

@protocol DDApiManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (DDApiBaseManagerRequestType)requestType;
- (BOOL)shouldCache;

//used for pagable API Manager mainly
- (void)cheanData;
- (NSDictionary *)reformParams:(NSDictionary *)param;
- (BOOL)shouldLoadFromNative;
@optional

@end

/**
 DDApiBaseManager的派生类必须符合这些protocal
 */
@protocol DDApiBaseManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(DDApiBaseManager *)manager beforePerformSuccessWithResponse:(DDURLResponse *)reponse;
- (void)manager:(DDApiBaseManager *)manager afterPerformSuccesWithResponse:(DDURLResponse *)response;

- (BOOL)manager:(DDApiBaseManager *)manager beforePerformFailWithResponse:(DDURLResponse *)response;
- (void)manager:(DDApiBaseManager *)manager afterPerformFailWithResponse:(DDURLResponse *)response;

- (BOOL)manager:(DDApiBaseManager *)manager shouldCallApiWithParams:(NSDictionary *)params;
- (void)manager:(DDApiBaseManager *)manager afterCallingApiWithParams:(NSDictionary *)params;

@end

@protocol DDApiMangerDataReformer <NSObject>

@required
- (id)manager:(DDApiBaseManager *)manager reformData:(NSDictionary *)data;

@end


typedef NS_ENUM(NSUInteger, DDApiBaseManagerErrorType) {
    DDApiBaseManagerErrorTypeDefault,
    DDApiBaseManagerErrorTypeSuccess,
    DDApiBaseManagerErrorTypeNoContent,
    DDApiBaseManagerErrorTypeParamsError,
    DDApiBaseManagerErrorTypeTimeout,
    DDApiBaseManagerErrorTypeNoNetWork
};

@interface DDApiBaseManager : NSObject
@property (nonatomic, weak) id<DDApiMangerCallBackDelegate> delegate;
@property (nonatomic, weak) id<DDApiMangerParamSource> paramSource;
@property (nonatomic, weak) id<DDApiBaseManagerVaildator> validator;
@property (nonatomic, weak) NSObject<DDApiManager> *child; //里面会调用NSObject的方法，所以这里不用id
@property (nonatomic, weak) id <DDApiBaseManagerInterceptor>interceptor;

@property (nonatomic, copy, readonly) NSString *errorMessage;

@property (nonatomic, readonly) DDApiBaseManagerErrorType errorType;
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
- (void)failedOnCallingApi:(DDURLResponse *)response withErrorType:(DDApiBaseManagerErrorType)errorType;
@end
