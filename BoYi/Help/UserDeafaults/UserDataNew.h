//
//  UserDataNew.h
//  BoYi
//
//  Created by heng on 2018/1/29.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModelNew.h"
#import "CertificationDataModel.h"

typedef void(^RequestBlock)(BOOL isSuccess);// 请求是否成功回调

@interface UserDataNew : NSObject
/**
 
 */
+ (instancetype)sharedManager;

- (void)setup;
+ (void)signOut;
+ (void)signOutNoAlert;

/**
 用户信息
 */
@property (nonatomic, strong) UserInfoModelNew *userInfoModel;

/**
 用户认证信息
 */
@property (nonatomic, strong) CertificationDataModel *certificationDataModel;


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

/**
 获取用户认证信息
 */
- (void)getCertificationInfo:(RequestBlock)successful;


@end
