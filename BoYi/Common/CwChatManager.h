//
//  CwChatManager.h
//  ZeroRead
//
//  Created by Chen on 2017/3/12.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NIMSDK/NIMSDK.h>
#import "NIMKit.h"


@interface CwChatManager : NSObject<NIMChatManagerDelegate,NIMLoginManagerDelegate,NIMUserManagerDelegate>

+ (CwChatManager *)sharedManager;
/**
 登录
 
 @param userInfo 登录用户信息
 */
- (void)loginWithInfo:(NSDictionary *)userInfo;
/**
 第一次登录
 
 @param userInfo 登录用户信息
 */
- (void)FirstLoginWithInfo:(NSDictionary *)userInfo;
/**
 好友列表
 
 @return 云信好友列表
 */
- (NSArray <NIMUser *>*)myFriends;
/**
 
 
 @param userId 是否是我的好友
 */
- (BOOL)isMyFriend:(NSString *)userId;
/**
 加好友
 
 @param userId 好友ID
 */
- (void)requestFriend:(NSString *)userId NIMUserBlock:(void(^)(NSError *error))NIMUserBlock;
/**
 给好友发送消息
 
 @param userId 好友ID
 */
- (void)sendMessageToFriend:(NSString *)userId;
/**
 删除好友
 
 @param userId 好友ID
 */
- (void)deleteFriend:(NSString *)userId;

/**
 添加黑名单
 
 @param userId 好友ID
 */
- (void)addToBlackList:(NSString *)userId;
/**
 *  登出
 *
 *   完成回调
 *   用户在登出是需要调用这个接口进行 SDK 相关数据的清理,回调 Block 中的 error 只是指明和服务器的交互流程中可能出现的错误,但不影响后续的流程。
 *              如用户登出时发生网络错误导致服务器没有收到登出请求，客户端仍可以登出(切换界面，清理数据等)，但会出现推送信息仍旧会发到当前手机的问题。
 */
- (void)signOut;
/**
 更新用户信息
 
 @param values 信息
 @param block 成功回调
 */
- (void)updateMyUserInfo:(NSDictionary *)values completion:(NIMUserBlock)block;


/**
 *  设置一个会话里所有消息置为已读
 *
 *  @param session 需设置的会话
 *  @discussion 异步方法，消息会标记为设置的状态
 */
- (void)markAllMessagesReadInSession:(NSString *)session;
@end
