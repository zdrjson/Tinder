//
//  DDApiBaseManager.m
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDApiBaseManager.h"
#import "DDApiProxy.h"

@interface DDApiBaseManager ()
@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, strong, readwrite) BOOL isLoading;
@property (nonatomic, assign) BOOL isNativeDataEmpty;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) DDApiBaseManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;

@end

@implementation DDApiBaseManager

- (void)a{
//    __weak typeof(self) weakSelf = self;
   
    
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = DDApiBaseManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(DDApiManager)]) {
            self.child = (id <DDApiManager>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}
- (void)dealloc {
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests {
    
}
- (void)cancelRequestWithRequestId:(NSInteger)requestID {
    [self removeRequestIdWithRequestID:requestID];
}
- (id)fetchDataWithReformer:(id<DDApiMangerDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}
#pragma mark - calling api
- (NSInteger)loadData {
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}
- (NSInteger)loadDataWithParams:(NSDictionary *)params{
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    if ([self shouldCallApiWithParams:apiParams]) {
        if ([self.validator manager:self isCorrectWithCallBackData:apiParams]) {
            if ([self shouldLoadFromNative]) {
                [self loadDataFromNative];
            }
            
            //先检查一下是否有缓存
            if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
                return 0;
            }
            
            // 实际的网络请求
            if ([self isReachable]) {
                self.isLoading = YES;
                switch (self.child.requestType) {
                    case DDApiBaseManagerRequestTypeGet: {
                        
                        break;
                    }
                    case DDApiBaseManagerRequestTypePost: {
                        
                        break;
                    }
                    case DDApiBaseManagerRequestTypePut: {
                        
                        break;
                    }
                    case DDApiBaseManagerRequestTypeDelete: {
                        
                        break;
                    }
                }
            }
        }
    }
    return 0;
}

- (void)loadDataFromNative
{
    NSString *methodName = self.child.methodName;
    NSDictionary *result = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:methodName];
    
    if (result) {
        self.isNativeDataEmpty = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof (weakSelf) strongSelf = weakSelf;
            DDURLResponse *response = [[DDURLResponse alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:0 error:NULL]];
            [strongSelf successedOnCallingApi:response];
        });
    } else {
        self.isNativeDataEmpty = YES;
    }
    
}
- (BOOL)shouldLoadFromNative
{
    return YES;
}
#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}
- (BOOL)hasCacheWithParams:(NSDictionary *)params {
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache]
    return YES;
    
}
@end
