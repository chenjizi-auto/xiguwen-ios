//
//  CwChatManager.m
//  ZeroRead
//
//  Created by Chen on 2017/3/12.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import "CwChatManager.h"

@implementation CwChatManager 

+ (CwChatManager *)sharedManager
{
    static CwChatManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        [[[NIMSDK sharedSDK] chatManager] addDelegate:self];
        [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
        [[[NIMSDK sharedSDK] userManager] addDelegate:self];
        [NIMSDKConfig sharedConfig].enabledHttpsForInfo = NO;
//        onUserInfoChanged
        
    }
    return self;
}
/**
 *  好友状态发生变化 (在线)
 *
 *  @param user 用户对象
 */
- (void)onFriendChanged:(NIMUser *)user {
    
    if (![[[NIMSDK sharedSDK] userManager] isMyFriend:user.userId]) {
        ///删除会话列表
        NIMDeleteMessagesOption *option = [[NIMDeleteMessagesOption alloc] init];
        option.removeSession = YES;
        option.removeTable = YES;
        [[[NIMSDK sharedSDK] conversationManager] deleteAllmessagesInSession:[NIMSession session:user.userId type:NIMSessionTypeP2P] option:option];
    }
}
//- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages {
//    
//}


/**
 登录
 
 @param userInfo 登录用户信息
 */
- (void)loginWithInfo:(NSDictionary *)userInfo {
    
    NSString *userId = [NSString stringWithFormat:@"user_%@",NSStringFormatter(userInfo[@"token"][@"userid"])];
    NSString *token  =  NSStringFormatter(userInfo[@"user"][@"im_token"]);
    
    NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
    loginData.account = userId;
    loginData.token   = token;
    loginData.forcedMode = YES;
    [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];

}
/**

 
 @param userId 是否是我的好友
 */
- (BOOL)isMyFriend:(NSString *)userId{
    return [[[NIMSDK sharedSDK] userManager] isMyFriend:userId];
}
/**
 第一次登录
 
 @param userInfo 登录用户信息
 */
- (void)FirstLoginWithInfo:(NSDictionary *)userInfo {
    
    
    WeakSelf(self);
    NSString *userId = [NSString stringWithFormat:@"user%@",NSStringFormatter(userInfo[@"token"][@"userid"])];
    NSString *token  =  NSStringFormatter(userInfo[@"user"][@"im_token"]);
    [[[NIMSDK sharedSDK] loginManager] login:userId token:token completion:^(NSError * _Nullable error) {
        if (error) {
            DLog(@"----------云信登录失败！！%@",error);
        } else {
//            NIMPushNotificationSetting *setting = [[[NIMSDK sharedSDK] apnsManager] currentSetting];
//            setting.type = NIMPushNotificationDisplayTypeDetail;
//            [[[NIMSDK sharedSDK] apnsManager] updateApnsSetting:setting
//                                                     completion:^(NSError *error) {
//                                                         
//                                                     }];
            DLog(@"----------云信登录成功！！");
            NSString *head = [NSString stringWithFormat:@"%@",NSStringFormatter(userInfo[@"user"][@"head"])];
            NSString *nickname = [NSString stringWithFormat:@"%@",NSStringFormatter(userInfo[@"user"][@"nickname"])];
            //更新资料
            [weakSelf updateMyUserInfo:@{@(NIMUserInfoUpdateTagNick) : nickname,
                                         @(NIMUserInfoUpdateTagAvatar):head} completion:^(NSError * _Nullable error) {
                
            }];
        }
        
    }];

}
/**
 *  登出
 *
 *   完成回调
 *   用户在登出是需要调用这个接口进行 SDK 相关数据的清理,回调 Block 中的 error 只是指明和服务器的交互流程中可能出现的错误,但不影响后续的流程。
 *              如用户登出时发生网络错误导致服务器没有收到登出请求，客户端仍可以登出(切换界面，清理数据等)，但会出现推送信息仍旧会发到当前手机的问题。
 */
- (void)signOut {
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error){}];
    
}
/**
 好友列表

 @return 云信好友列表
 */
- (NSArray<NIMUser *> *)myFriends {
    return [[[NIMSDK sharedSDK] userManager] myFriends];
}

/**
 加好友

 @param userId 好友ID
 */
- (void)requestFriend:(NSString *)userId NIMUserBlock:(void(^)(NSError *error))NIMUserBlock {
    
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId          = userId;                            //封装用户ID
    request.operation       = NIMUserOperationRequest;                    //封装验证方式
    request.message         = @"跪求通过";                                 //封装自定义验证消息
    [[[NIMSDK sharedSDK] userManager] requestFriend:request completion:NIMUserBlock];
     
//     ^(NSError * _Nullable error) {
//        DLog(@"-------------添加好友%@%@",userId,error ? @"失败" : @"成功");
//        
//    }];
}

/**
 给好友发送消息

 @param userId 好友ID
 */
- (void)sendMessageToFriend:(NSString *)userId {
    //构造消息
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text    = @"快来聊聊~";
    
    //构造会话
    NIMSession *session = [NIMSession session:userId type:NIMSessionTypeP2P];
    //发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
}
/**
 删除好友

 @param userId 好友ID
 */
- (void)deleteFriend:(NSString *)userId {
    [[[NIMSDK sharedSDK] userManager] deleteFriend:userId completion:^(NSError * _Nullable error) {
        
        DLog(@"-------------删除好友%@%@",userId,error ? @"失败" : @"成功");
    }];
}

/**
 添加黑名单

 @param userId 好友ID
 */
- (void)addToBlackList:(NSString *)userId {
    [[[NIMSDK sharedSDK] userManager] addToBlackList:userId completion:^(NSError * _Nullable error) {
        
        DLog(@"-------------拉黑好友%@%@",userId,error ? @"失败" : @"成功");
    }];
}

/**
 更新用户信息

 @param values 信息
 @param block 成功回调
 */
- (void)updateMyUserInfo:(NSDictionary *)values completion:(NIMUserBlock)block {
    [[[NIMSDK sharedSDK] userManager] updateMyUserInfo:values
                                            completion:^(NSError * _Nullable error) {
                                                if (block) {
                                                    block(error);
                                                }
                                                DLog(@"-------------更新头像%@------",error ? @"失败" : @"成功");
        if (!error) {
            [[[NIMSDK sharedSDK] userManager] fetchUserInfos:@[[NIMSDK sharedSDK].loginManager.currentAccount]
                                                  completion:^(NSArray<NIMUser *> * _Nullable users, NSError * _Nullable error) {
                                                      DLog(@"-------------更新云信头像%@------",error ? @"失败" : @"成功");
                                                  }];
        }
    }];
}

/**
 *  设置一个会话里所有消息置为已读
 *
 *  @param session 需设置的会话
 *  @discussion 异步方法，消息会标记为设置的状态
 */
- (void)markAllMessagesReadInSession:(NSString *)session {
    
    NIMSession *session1 = [NIMSession session:@"" type:NIMSessionTypeP2P];
    [[[NIMSDK sharedSDK] conversationManager] markAllMessagesReadInSession:session1];
}

#pragma mark - 登录/登出 回调

/**
 *  被踢(服务器/其他端)回调
 *
 *  @param code        被踢原因
 *  @param clientType  发起踢出的客户端类型
 */
- (void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType {
    [NavigateManager showMessage:@"您的账号已在其他地方登录，请重新登录"];
    [UserData signOutNoAlert];
}
/**
 *  登录回调
 *
 *  @param step 登录步骤
 *  @discussion 这个回调主要用于客户端UI的刷新
 */
- (void)onLogin:(NIMLoginStep)step {
    
    // 同步信息
    if (step == NIMLoginStepSyncOK) {
        //
        NIMSession *ssion = [NIMSession session:@"user_admin" type:NIMSessionTypeP2P];
        
        NIMMessageSearchOption *option = [[NIMMessageSearchOption alloc] init];
        option.order = NIMMessageSearchOrderDesc;
        option.messageTypes = @[@(NIMMessageTypeText)];
        option.limit = 20;
        
        [[NIMSDK sharedSDK].conversationManager searchMessages:ssion option:option result:^(NSError * _Nullable error, NSArray<NIMMessage *> * _Nullable messages) {
            //验证是否是订单消息
            messages = [[messages reverseObjectEnumerator] allObjects];
            for (NIMMessage *msg in messages) {
                NSDictionary *info = msg.remoteExt;
                if (info[@"msgType"]) {
                    //余额变化
                    if ([info[@"msgType"] integerValue] == 2) {
                        DLog(@"-------钱发生变化了，余额:%@ ----------",info[@"incomeCert"][@"balance"]);
                        [UserData reWriteUserInfo:info[@"incomeCert"][@"balance"] ForKey:@"balance"];
                        break;
                    }
                }
            }
        }];
    }
    DLog(@"登录中.....%ld    ",step);
}
/*
 大部分自动登录回调错误 APP 并不需要关心，只需注意如下两种情况：
 
 1.用户名密码错误导致自动登录失败，error code 为 302。这种情况一般发生于用户在其他设备上修改了密码。
 
 2.已有一端登录导致自动登录失败，error code 为 417。这种情况发生于非强制登录模式下已有一端在线而当前设备进行自动登录(设置为只允许一端同时登录时)，出于安全方面的考虑，云信服务器判定当前端需要重新手动输入用户密码进行登录，故拒绝登录。
 
 一旦发生如上情况，APP 同样需要进行注销并切换到登录界面。
 */
- (void)onAutoLoginFailed:(NSError *)error {
    
    if (error.code == 302) {
        
        [NavigateManager showMessage:@"您的账号密码已更改，请重新登录"];
//        [UserData signOutNoAlert];
        
    } else if (error.code == 417) {
        
        [NavigateManager showMessage:@"您的账号已在其他地方登录，请重新登录"];
//        [UserData signOutNoAlert];
    }
}

#pragma mark - 配置信息 回调




@end
