//
//  UserData.h
//  Sahara
//
//  Created by Chen on 15/6/30.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserData : NSObject

/**
 
 */
+ (instancetype)sharedManager;

- (void)setup;
+ (void)signOut;
+ (void)signOutNoAlert;

/**
 用户信息
 */
@property (nonatomic, strong) UserInfoModel *userInfoModel;

+ (BOOL)UserLoginState;
+ (void)WriteUserInfo:(id)dic;
/**
 修改个人信息
 
 @param value 个人信息数值
 @param key 个人信息的Key
 */
+ (void)reWriteUserInfo:(id)value ForKey:(NSString *)key;
/**
 修改商铺信息
 
 @param value 商铺信息数值
 @param key 商铺信息的Key
 */
+ (void)reWriteShopInfo:(id)value ForKey:(NSString *)key;
//
+ (NSString *)keyForUser:(NSString *)key;
//
+ (void)cleanUserInfo;


+ (NSDictionary *)authData;

+ (NSString *)userId;
/**
 *  缓存写入
 */
+ (void)UserDefaults:(NSString *)value key:(NSString *)key;
/**
 *  缓存读取
 */
+ (NSString *)UserDefaults:(NSString *)key;
/**
 *  缓存清除
 */
+ (void)ClearUserDefaults:(NSString *)key;

/**
 重新更新本地数据
 
 @param value 服务器获取的新数据
 */
+ (void)reWriteUserInfo:(NSDictionary *)value;
/**
 重新更新本地商铺信息数据
 
 @param value 服务器获取的新数据
 */
+ (void)reWriteShopInfo:(NSDictionary *)value;
@end
