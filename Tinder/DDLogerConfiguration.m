//
//  DDLogerConfiguration.m
//  Tinder
//
//  Created by 张德荣 on 16/6/15.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DDLogerConfiguration.h"

@implementation DDLogerConfiguration
- (void)configWithAppType:(DDAppType)appType {
    switch (appType) {
        case DDAppTypexxx: {
            self.appKey = @"xxxxxx";
            self.serviceType = @"xxxxx";
            self.sendLogMethod = @"xxxx";
            self.sendActionMethod = @"xxxxxx";
            self.sendLogKey = @"xxxxx";
            self.sendActionKey = @"xxxx";
            break;
        }
    }
}


@end
