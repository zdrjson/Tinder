//
//  DDApiBaseManager.m
//  Tinder
//
//  Created by 张德荣 on 16/5/30.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDApiBaseManager.h"

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
    __weak typeof(self) weakSelf = self;
    
    
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
                        <#statement#>
                        break;
                    }
                    case DDApiBaseManagerRequestTypePost: {
                        <#statement#>
                        break;
                    }
                    case DDApiBaseManagerRequestTypePut: {
                        <#statement#>
                        break;
                    }
                    case DDApiBaseManagerRequestTypeDelete: {
                        <#statement#>
                        break;
                    }
                }
            }
        }
    }
}

- (void)loadDataFromNative
{
    
}
- (BOOL)shouldLoadFromNative
{
}
#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    
}
@end
