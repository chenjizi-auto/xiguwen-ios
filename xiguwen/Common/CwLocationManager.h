//
//  CwLocationManager.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/19.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CwLocationManager : NSObject
+ (CwLocationManager *)sharedManager;



@property (nonatomic,strong) CLLocation *location;

@property (nonatomic,strong) id lat;
@property (nonatomic,strong) id lon;
/**
 开始定位搜索地址
 @param GeoSearch 是否需要地址信息
 @param complete 搜索完成回调
 */
- (void)startWithGeoSearch:(BOOL)GeoSearch complete:(void (^)(BOOL success, NSString *province,NSString *city))complete;
@end
