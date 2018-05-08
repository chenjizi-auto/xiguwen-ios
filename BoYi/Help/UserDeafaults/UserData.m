//
//  UserData.m
//  Sahara
//
//  Created by Chen on 15/6/30.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import "UserData.h"
#import "AppDelegate.h"
#import "MyAlertView.h"

@interface UserData() {
    UserData *_instance;
}

@end

@implementation UserData


+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static UserData *instance;

    dispatch_once(&once, ^{
    
        instance = [[UserData alloc] init];
    });
    return instance;
}

+ (void)signOut {
    
    [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                    message:@"确定退出？"
                       left:@"取消"
                      right:@"确定"
                      block:^(NSInteger index) {
                          if (index == 1) {
//                              [NavigateManager showLoadingMessage:@"正在退出"];
                              
                              [UserData signOutNoAlert];
                          }
                          
    }];
}
+ (void)signOutNoAlert {
    
    [UserData ClearUserDefaults:@"user_dic"];
//    [[CwChatManager sharedManager] signOut];
    [UserData sharedManager].userInfoModel = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:SIGN_OUT_REMOVE_INDEX_TIMER object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [NavigateManager hiddenLoadingMessage];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app ConfirmRootViewController];
    });
}

- (void)setup {
    
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
//    [[CwChatManager sharedManager] loginWithInfo:[dic objectForKey:@"userInfo"]];
}
+ (BOOL)UserLoginState
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"])
    {
        return YES;
    }
    else return NO;
}

+ (void)cleanUserInfo
{
    //清除单例
    [UserData sharedManager].userInfoModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_dic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*

 */
+ (void)WriteUserInfo:(id)dic
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_dic"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user_dic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

/**
 修改个人信息

 @param value 个人信息数值
 @param key 个人信息的Key
 */
+ (void)reWriteUserInfo:(id)value ForKey:(NSString *)key {
    
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
//    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:dict[@"userInfo"]];
    [dict setValue:value forKey:key];
//    [dict setObject:userDic forKey:@"userInfo"];
    [UserData WriteUserInfo:dict];
    [UserData sharedManager].userInfoModel = [UserInfoModel mj_objectWithKeyValues:dict];
}
/**
 修改商铺信息
 
 @param value 商铺信息数值
 @param key 商铺信息的Key
 */
+ (void)reWriteShopInfo:(id)value ForKey:(NSString *)key {
    
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:dict[@"shopInfo"]];
    [userDic setValue:value forKey:key];
    [dict setObject:userDic forKey:@"shopInfo"];
    [UserData WriteUserInfo:dict];
//    [[UserData sharedManager].userInfoModel.shopInfo setValue:value forKey:key];
}
/**
 重新更新本地数据

 @param value 服务器获取的新数据
 */
+ (void)reWriteUserInfo:(NSDictionary *)value {
    
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:dict[@"userInfo"]];
    [userInfo setValuesForKeysWithDictionary:value];
    
//    Userinfo *model = [Userinfo mj_objectWithKeyValues:value];
//    NSDictionary *modelDic = model.mj_keyValues;
//    
//    
//    
//    for (id object in modelDic.allKeys) {
//        
//        if (![[userInfo valueForKey:object] isEqual:[modelDic valueForKey:object]]) {
//            [userInfo setValue:[modelDic valueForKey:object] forKey:object];
//        }
//    }
    [dict setObject:userInfo forKey:@"userInfo"];
    [UserData WriteUserInfo:dict];
    
    [UserData sharedManager].userInfoModel = [UserInfoModel mj_objectWithKeyValues:dict];

}
/**
 重新更新本地商铺信息数据
 
 @param value 服务器获取的新数据
 */
+ (void)reWriteShopInfo:(NSDictionary *)value {
    
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:dict[@"shopInfo"]];
    [userInfo setValuesForKeysWithDictionary:value];
//    Userinfo *model = [Userinfo mj_objectWithKeyValues:value];
//    NSDictionary *modelDic = model.mj_keyValues;
//    
//    
//    
//    for (id object in modelDic.allKeys) {
//        
//        if (![[userInfo valueForKey:object] isEqual:[modelDic valueForKey:object]]) {
//            [userInfo setValue:[modelDic valueForKey:object] forKey:object];
//        }
//    }
    [dict setObject:userInfo forKey:@"shopInfo"];
    [UserData WriteUserInfo:dict];
    [UserData sharedManager].userInfoModel = [UserInfoModel mj_objectWithKeyValues:dict];
    
}

/*

 
 */
+ (NSString *)keyForUser:(NSString *)key
{
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    
//    NSString *string  = [NSString stringWithFormat:@"%@",[dic objectForKey:key]];
    return [dic objectForKey:key];
}


+ (NSDictionary *)authData
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"auth"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"auth"];
    }
    return nil;
}

+ (NSString *)userId {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Id"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"Id"];
    }
    return nil;
}
/**
 *  缓存写入
 */
+ (void)UserDefaults:(NSString *)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  缓存读取
 */
+ (NSString *)UserDefaults:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
/**
 *  缓存清除
 */
+ (void)ClearUserDefaults:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UserInfoModel *)userInfoModel {
    if (!_userInfoModel) {
        NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        _userInfoModel = [UserInfoModel mj_objectWithKeyValues:dic];
    }
    return _userInfoModel;
}

@end
