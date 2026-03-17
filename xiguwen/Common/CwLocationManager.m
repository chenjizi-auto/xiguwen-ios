//
//  CwLocationManager.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/19.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "CwLocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface CwLocationManager() {
    BOOL _isLoaded;
}
@property (strong,nonatomic) AMapLocationManager *locationManager;
@end

@implementation CwLocationManager
+ (CwLocationManager *)sharedManager
{
    static CwLocationManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (id)lat {
    if (self.location) {
        NSString *latString = [NSString stringWithFormat:@"%f",self.location.coordinate.latitude];
        return latString;
    }
    return [NSNull null];
}
- (id)lon {
    
    if (self.location) {
        NSString *lonString = [NSString stringWithFormat:@"%f",self.location.coordinate.longitude];
        return lonString;
    }
    return [NSNull null];
}

/**
 开始定位搜索地址
 @param GeoSearch 是否需要地址信息
 @param complete 搜索完成回调
 */
- (void)startWithGeoSearch:(BOOL)GeoSearch complete:(void (^)(BOOL success, NSString *province,NSString *city))complete {
    
    if (!self.locationManager) {
        self.locationManager = [[AMapLocationManager alloc] init];
        //        self.locationManager.delegate = self;
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为10s
        self.locationManager.locationTimeout = 10;
        //   逆地理请求超时时间，最低2s，此处设置为10s
        self.locationManager.reGeocodeTimeout = 10;
    }
    
    @weakify(self);
    [self.locationManager requestLocationWithReGeocode:GeoSearch completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        @strongify(self);
        if (!error) {
            self.location = location;
            complete(YES,regeocode.province,regeocode.city);
        } else {
            complete(NO,nil,nil);
        }
        
        self.locationManager = nil;
    }];
}
@end
