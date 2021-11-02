//
//  UserDataNew.m
//  BoYi
//
//  Created by heng on 2018/1/29.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UserDataNew.h"
#import "AppDelegate.h"
#import "MyAlertView.h"

@interface UserDataNew() {
    UserDataNew *_instance;
}
@end
@implementation UserDataNew



+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static UserDataNew *instance;
    
    dispatch_once(&once, ^{
        
        instance = [[UserDataNew alloc] init];
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
                              
                              [UserDataNew signOutNoAlert];
                          }
                          
                      }];
}
+ (void)signOutNoAlert {
    
    [UserDataNew ClearUserDefaults:@"user_dic"];
    [[CwChatManager sharedManager] signOut];
    [UserDataNew sharedManager].userInfoModel = nil;
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
    [[CwChatManager sharedManager] FirstLoginWithInfo:dic];
}
+ (BOOL)UserLoginState
{
    if ([UserDataNew sharedManager].userInfoModel.token.userid)
    {
        return YES;
    }
    else return NO;
}

+ (void)cleanUserInfo
{
    //清除单例
    [UserDataNew sharedManager].userInfoModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_dic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*
 
 */
+ (void)WriteUserInfo:(id)dic
{
    [UserDataNew sharedManager].userInfoModel = nil;
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
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:dict[@"user"]];
    [userDic setValue:value forKey:key];
    [dict setObject:userDic forKey:@"user"];
    [UserDataNew WriteUserInfo:dict];
    [UserDataNew sharedManager].userInfoModel = [UserInfoModelNew mj_objectWithKeyValues:dict];
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
    [UserDataNew WriteUserInfo:dict];
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
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:dict[@"user"]];
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
    [dict setObject:userInfo forKey:@"user"];
    [UserDataNew WriteUserInfo:dict];
     UserInfoModelNew *model = [UserInfoModelNew mj_objectWithKeyValues:dict];
    [UserDataNew sharedManager].userInfoModel = model;
    
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
    [UserDataNew WriteUserInfo:dict];
    [UserDataNew sharedManager].userInfoModel = [UserInfoModelNew mj_objectWithKeyValues:dict];
    
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

- (UserInfoModelNew *)userInfoModel {
    if (!_userInfoModel) {
        NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        _userInfoModel = [UserInfoModelNew mj_objectWithKeyValues:dic];
    }
    return _userInfoModel;
}

- (CertificationDataModel *)certificationDataModel {
	if (!_certificationDataModel) {
//		NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"certification"];
//		NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        NSString *jsonStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"certification"];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
		_certificationDataModel = [CertificationDataModel mj_objectWithKeyValues:dict];
	}
	return _certificationDataModel;
}

#pragma mark - 获取用户认证信息
- (void)getCertificationInfo:(RequestBlock)successful {
	// 请求认证信息
	[[RequestManager sharedManager] requestUrl:URL_certification
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   
                                           if ([response[@"code"] integerValue] == 0) {
										   // 储存认证信息
										   if ([[NSUserDefaults standardUserDefaults] objectForKey:@"certification"]) {
											   //清除单例
											   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"certification"];
											   
										   }
                                            NSData *data = [NSJSONSerialization dataWithJSONObject:response[@"data"] options:(NSJSONWritingPrettyPrinted) error:nil];
                                               NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
										   [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:@"certification"];
                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                           self.certificationDataModel = [CertificationDataModel mj_objectWithKeyValues:response[@"data"]];
										   successful(YES);
                                           }
									   }
									   failure:^(NSURLSessionDataTask *task, NSError *error) {
										   successful(NO);
									   }];
}

@end
