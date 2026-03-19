//
//  CwChatManager.m
//  ZeroRead
//
//  Created by Chen on 2017/3/12.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import "CwChatManager.h"
#import "NavigateManager.h"
#import "UserDataNew.h"

@interface CwChatUnavailableViewController : UIViewController
@property (nonatomic, assign) BOOL hasShownUnavailableMessage;
@end

@implementation CwChatUnavailableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"会话";

    UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGE_NAME(@"无数据 空状态")];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"聊天服务未开启";
    label.textColor = RGBA(202, 202, 202, 1);
    label.font = [UIFont boldSystemFontOfSize:13.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-40.0],
        [label.topAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:12.0],
        [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.hasShownUnavailableMessage) {
        self.hasShownUnavailableMessage = YES;
        [NavigateManager showMessage:@"聊天服务未开启"];
    }
}

@end

static CwChatSessionViewControllerBuilder cw_sessionViewControllerBuilder = nil;
static CwChatViewControllerBuilder cw_sessionListViewControllerBuilder = nil;
static CwChatViewControllerBuilder cw_contactListViewControllerBuilder = nil;

static NSString *CwNormalizedIMUserId(id userId) {
    if (userId == nil) {
        return nil;
    }
    NSString *rawValue = [NSString stringWithFormat:@"%@", userId];
    if (rawValue.length == 0 || [rawValue isEqualToString:@"(null)"]) {
        return nil;
    }
    if ([rawValue hasPrefix:@"user_"]) {
        return rawValue;
    }
    if ([rawValue hasPrefix:@"user"] && rawValue.length > 4) {
        NSString *suffix = [rawValue substringFromIndex:4];
        if ([suffix hasPrefix:@"_"]) {
            return rawValue;
        }
        return [NSString stringWithFormat:@"user_%@", suffix];
    }
    return [NSString stringWithFormat:@"user_%@", rawValue];
}

static NSString *CwNormalizedIMToken(id token) {
    if (token == nil) {
        return nil;
    }
    NSString *rawValue = [NSString stringWithFormat:@"%@", token];
    if (rawValue.length == 0 || [rawValue isEqualToString:@"(null)"] || [rawValue isEqualToString:@"<null>"]) {
        return nil;
    }
    return rawValue;
}

static BOOL CwIsChatServiceEnabled(void) {
    NSString *token = [UserDataNew sharedManager].userInfoModel.user.im_token;
    return token.length > 0;
}

@implementation CwChatManager 

+ (NSString *)normalizedIMUserIdFromValue:(id)userId {
    return CwNormalizedIMUserId(userId);
}

+ (CwChatManager *)sharedManager
{
    static CwChatManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+ (void)registerSessionViewControllerBuilder:(CwChatSessionViewControllerBuilder)builder {
    cw_sessionViewControllerBuilder = [builder copy];
}

+ (void)registerSessionListViewControllerBuilder:(CwChatViewControllerBuilder)builder {
    cw_sessionListViewControllerBuilder = [builder copy];
}

+ (void)registerContactListViewControllerBuilder:(CwChatViewControllerBuilder)builder {
    cw_contactListViewControllerBuilder = [builder copy];
}

+ (BOOL)hasRegisteredCustomChatUIKitBridge {
    return cw_sessionViewControllerBuilder != nil ||
           cw_sessionListViewControllerBuilder != nil ||
           cw_contactListViewControllerBuilder != nil;
}

+ (void)registerLegacyChatUIKitIfNeeded {
    // Legacy NIMKit has been removed from the project. The runtime bridge
    // should register the new chat UIKit builders before chat entry points are used.
}

+ (void)pushP2PSessionWithIMUserId:(id)userId fromViewController:(UIViewController *)viewController {
    if (viewController == nil || userId == nil) {
        return;
    }
    if (!CwIsChatServiceEnabled()) {
        [NavigateManager showMessage:@"聊天服务未开启"];
        return;
    }
    NSString *sessionId = CwNormalizedIMUserId(userId);
    if (sessionId.length == 0) {
        return;
    }
    NSLog(@"[CwChat] pushP2P rawUserId=%@ normalizedSessionId=%@", userId, sessionId);
    NIMSession *session = [NIMSession session:sessionId type:NIMSessionTypeP2P];
    [self pushSession:session fromViewController:viewController];
}

+ (void)pushSession:(NIMSession *)session fromViewController:(UIViewController *)viewController {
    if (viewController == nil || session == nil) {
        return;
    }
    if (!CwIsChatServiceEnabled()) {
        [NavigateManager showMessage:@"聊天服务未开启"];
        return;
    }
    if (session.sessionType == NIMSessionTypeP2P) {
        NSString *normalizedSessionId = CwNormalizedIMUserId(session.sessionId);
        if (normalizedSessionId.length > 0 && ![normalizedSessionId isEqualToString:session.sessionId]) {
            session = [NIMSession session:normalizedSessionId type:NIMSessionTypeP2P];
        }
    }
    UIViewController *vc = [self sessionViewControllerWithSession:session];
    [viewController.navigationController pushViewController:vc animated:YES];
}

+ (UIViewController *)sessionViewControllerWithSession:(NIMSession *)session {
    if (cw_sessionViewControllerBuilder) {
        return cw_sessionViewControllerBuilder(session);
    }
    UIViewController *vc = [[UIViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor whiteColor];
    return vc;
}

+ (UIViewController *)sessionListViewController {
    if (!CwIsChatServiceEnabled()) {
        return [[CwChatUnavailableViewController alloc] init];
    }
    if (cw_sessionListViewControllerBuilder) {
        return cw_sessionListViewControllerBuilder();
    }
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    return vc;
}

+ (UIViewController *)contactListViewController {
    if (!CwIsChatServiceEnabled()) {
        return [[CwChatUnavailableViewController alloc] init];
    }
    if (cw_contactListViewControllerBuilder) {
        return cw_contactListViewControllerBuilder();
    }
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    return vc;
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
    
    NSString *userId = CwNormalizedIMUserId(userInfo[@"token"][@"userid"]);
    NSString *token = CwNormalizedIMToken(userInfo[@"user"][@"im_token"]);
    if (userId.length == 0 || token.length == 0) {
        DLog(@"[CwChat] autoLogin skipped invalid params userId=%@ token=%@ rawTokenUserId=%@ rawIMToken=%@",
             userId,
             token.length > 0 ? @"<non-empty>" : @"<empty>",
             userInfo[@"token"][@"userid"],
             userInfo[@"user"][@"im_token"]);
        return;
    }
    
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
    NSString *userId = CwNormalizedIMUserId(userInfo[@"token"][@"userid"]);
    NSString *token = CwNormalizedIMToken(userInfo[@"user"][@"im_token"]);
    if (userId.length == 0 || token.length == 0) {
        DLog(@"[CwChat] firstLogin skipped invalid params userId=%@ token=%@ rawTokenUserId=%@ rawIMToken=%@",
             userId,
             token.length > 0 ? @"<non-empty>" : @"<empty>",
             userInfo[@"token"][@"userid"],
             userInfo[@"user"][@"im_token"]);
        return;
    }
    [[[NIMSDK sharedSDK] loginManager] login:userId token:token completion:^(NSError * _Nullable error) {
        if (error) {
            DLog(@"----------云信登录失败！！%@ account=%@ token=%@", error, userId, token.length > 0 ? @"<non-empty>" : @"<empty>");
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
    // Disabled while the app is bridged to the V2 conversation UIKit.
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
