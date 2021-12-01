//
//  AppDelegate.m
//  ZeroRead_OC
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "FatherTabbarViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "UPPaymentControl.h"
#import <AlipaySDK/AlipaySDK.h>

#define NIMAPPKEY @"79928fa2f7ff38d5ecf05bedb335aafa"
#define NIMProductCer @"pushServices"//pushServices
#define NIMTestCer @"pushDevelopment"//pushDevelopment
#define UMOBAPPKEY @"5ab9b68da40fa37175000106"
#import "LaunchPageView.h"
#import "NTESCellLayoutConfig.h"
#import "NTESMainTabController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "OrderDetilNewViewController.h"
#import "OrderDetilNewSCViewController.h"
#import "OrderDetilNewJDViewController.h"
#import "ShangchengOderDetilJDViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


static void extracted(AppDelegate *object) {
    [LaunchPageView showInView:object.window isAd:NO];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 14.0, *)) {
        [UIDatePicker appearance].preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    
    [self configUSharePlatforms];
    [self registerAPNs];
    [self ConfirmRootViewController];
    if ([UserDataNew UserLoginState]) {
        [[UserDataNew sharedManager] setup];
    }
    [self adView];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLaunched"]) {
        extracted(self);
    }
    
    ///配置极光
    [self registerJPushOptions:launchOptions];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)ConfirmRootViewController {
    
//    //是否登录
//    if (![UserData UserLoginState]) {
    NTESMainTabController *tabbar = [[NTESMainTabController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = tabbar;
    
    // AppDelegate 进行全局设置
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
//        FatherTabbarViewController *tabbar = [[FatherTabbarViewController alloc] init];
//        self.window.rootViewController = tabbar;
    
//    } else {
//        UIViewController *vc = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
//        
//        self.window.rootViewController = vc;
//    }

    
}

- (void)configUSharePlatforms {

    [[NIMSDK sharedSDK] registerWithAppID:NIM_APPKEY cerName:NIMProductCer];
    //    [[NIMSDK sharedSDK] enableConsoleLog];
    //注册自定义消息的解析器
    //    [NIMCustomObject registerCustomDecoder:[NTESCustomAttachmentDecoder new]];
    //注入 NIMKit 布局管理器
    [[NIMKit sharedKit] registerLayoutConfig:[NTESCellLayoutConfig new]];
    
    
    
    [AMapServices sharedServices].apiKey = MAMAP_KEY;
//    UMConfigInstance.appKey = UMOBAPPKEY;
//    UMConfigInstance.channelId = @"App Store";
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMOBAPPKEY];

    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:@"wx9d4329a0f1007c7c"
                                       appSecret:@"853bac444f0c382040482cc69a4d12ef"
                                     redirectURL:nil];
    
    //设置新浪的appKey和appSecret///
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:@"4179100698"
                                       appSecret:@"944e969daa65c9047c07a6c76e5f4e96"
                                     redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:@"1106869350"
                                       appSecret:@"BrBhe64ckcpc00fg"
                                     redirectURL:nil];
//    [WXApi registerApp:@"wx516980adf21e055b"];
     
 
}



#pragma makr - 广告页 启动页
- (void)adView {

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]) {
        [LaunchPageView showInView:self.window isAd:NO];
    }
    
    
}

#pragma mark - misc
- (void)registerAPNs
{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |      UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound |        UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }

}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"DeviceToken: {%@}",deviceToken);
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

#pragma mark -和微信终端交互的具体请求与回应

- (void)onResp:(BaseResp *)resp
{
    DLog(@"%@",resp.errStr);
    if ([resp isKindOfClass:[PayResp class]]) {
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:WECHAT_PAY_RESULT_NOTIFACATION object:[NSNumber numberWithInt:resp.errCode]];
        
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                
                //付款成功
                
                
            }
                break;
            case WXErrCodeUserCancel:
                [NavigateManager showMessage:@"您已取消支付!"];
                break;
            case WXErrCodeSentFail:
                [NavigateManager showMessage:@"支付请求发送失败,支付不成功!" ];
                break;
            case WXErrCodeAuthDeny:
                [NavigateManager showMessage:@"微信授权失败,支付不成功!"];
                break;
            case WXErrCodeUnsupport:
                [NavigateManager showMessage:@"微信不支持,支付不成功!"];
                break;
            default:
                [NavigateManager showMessage:@"您已取消支付!"];
                break;
        }
        
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        //微信的唯一回调在appdelegate,所以用通知传递到支付操作的页面，进行下一步操作。
        
        
        switch (resp.errCode)
        {
                
            case WXSuccess:
            {
                
                SendAuthResp *authResp = (SendAuthResp *)resp;
                //授权成功
                //授权
                [[NSNotificationCenter defaultCenter] postNotificationName:WECHAT_LOGIN_NOTIFICATION object:authResp.code];
                
            }
                break;
            case WXErrCodeUserCancel:
                [NavigateManager showMessage:@"您已取消授权!"];
                break;
            case WXErrCodeSentFail:
                [NavigateManager showMessage:@"授权请求发送失败,授权不成功!" ];
                break;
            case WXErrCodeAuthDeny:
                [NavigateManager showMessage:@"微信授权失败!"];
                break;
            case WXErrCodeUnsupport:
                [NavigateManager showMessage:@"微信不支持,授权不成功!"];
                break;
            default:
                [NavigateManager showMessage:@"您已取消授权!"];
                break;
        }
        
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //分享处理
        [NavigateManager showMessage:resp.errCode == WXSuccess ? @"分享成功!" : @"分享失败!"];
    }
    
    
    
}
//
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    //重置
//    [UserData sharedManager].userInfoModel.isWaitingForPay = NO;
   
    if  ([[UMSocialManager defaultManager] handleOpenURL:url]) {
        
        return YES;
        
    }else if ([WXApi handleOpenURL:url delegate:self]) {
        
        return YES;
        
    }else if ([url.host isEqualToString:@"safepay"]) {
        //            跳转支付宝钱包进行支付，处理支付结果//
        /*
         9000 订单支付成功
         8000 正在处理中
         4000 订单支付失败
         6001 用户中途取消
         6002 网络连接出错
         */
         
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //付款成功
            [[NSNotificationCenter defaultCenter] postNotificationName:ALIPAY_PAY_RESULT_NOTIFACATION object:[resultDic objectForKey:@"resultStatus"]];
            //支付宝支付
            switch ([[resultDic objectForKey:@"resultStatus"] integerValue]) {
                case 9000:
                {
                    
                }
                    break;
                case 6001:
                {
                    //用户中途取消  去订单详情
                    [NavigateManager showMessage:@"用户中途取消"];
                }
                    break;
                case 6002:
                {
                    //网络连接错误
                    [NavigateManager showMessage:@"网络连接错误"];
                }
                    break;
                case 4000:
                {
                    //订单支付失败
                    [NavigateManager showMessage:@"订单支付失败"];
                }
                    break;
                case 8000:
                {
                    //正在处理中
                    [NavigateManager showMessage:@"正在处理中"];
                }
                    break;
                default:
                    [NavigateManager showMessage:@"支付失败!"];
                    break;
            }
            
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:nil];
        
        return YES;
     } else {
         
         
         [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
             
             if([code isEqualToString:@"success"]) {
                 
                 //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
                 if(data != nil){
                     //数据从NSDictionary转换为NSString
                     NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                        options:0
                                                                          error:nil];
                     NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                     
                     //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
//                     if([self verify:sign]) {
//                         //验签成功
//                     }
//                     else {
//                         //验签失败
//                     }
                     //付款成功
                     [[NSNotificationCenter defaultCenter] postNotificationName:ALIPAY_PAY_RESULT_NOTIFACATION object:@9000];
                 }
                 
                 //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
             }
             else if([code isEqualToString:@"fail"]) {
                 //交易失败
                 [NavigateManager showMessage:@"交易失败"];
             }
             else if([code isEqualToString:@"cancel"]) {
                 //交易取消
                 [NavigateManager showMessage:@"交易取消"];
             }
         }];
     }
    
    
    return NO;
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[UMSocialManager defaultManager] handleOpenURL:url]) {
        
        return YES;
        
    }else if ([WXApi handleOpenURL:url delegate:self]) {
        
        return YES;
        
    } else if ([url.host isEqualToString:@"safepay"]) {
        //            跳转支付宝钱包进行支付，处理支付结果
        /*
         9000 订单支付成功
         8000 正在处理中
         4000 订单支付失败
         6001 用户中途取消
         6002 网络连接出错
         */
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //付款成功
            [[NSNotificationCenter defaultCenter] postNotificationName:ALIPAY_PAY_RESULT_NOTIFACATION object:[resultDic objectForKey:@"resultStatus"]];
            //支付宝支付
            switch ([[resultDic objectForKey:@"resultStatus"] integerValue]) {
                case 9000:
                {
                    
                }
                    break;
                case 6001:
                {
                    //用户中途取消  去订单详情
                    [NavigateManager showMessage:@"用户中途取消"];
                }
                    break;
                case 6002:
                {
                    //网络连接错误
                    [NavigateManager showMessage:@"网络连接错误"];
                }
                    break;
                case 4000:
                {
                    //订单支付失败
                    [NavigateManager showMessage:@"订单支付失败"];
                }
                    break;
                case 8000:
                {
                    //正在处理中
                    [NavigateManager showMessage:@"正在处理中"];
                }
                    break;
                default:
                    [NavigateManager showMessage:@"支付失败!"];
                    break;
            }
            
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:nil];
        
        return YES;
    } else {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            
            if([code isEqualToString:@"success"]) {
                
                //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
                if(data != nil){
                    //数据从NSDictionary转换为NSString
                    NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                       options:0
                                                                         error:nil];
                    NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                    
                    //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
//                    if([self verify:sign]) {
//                        //验签成功
//                    }
//                    else {
//                        //验签失败
//                    }
                    //付款成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:ALIPAY_PAY_RESULT_NOTIFACATION object:@9000];
                }
                
                //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
            }
            else if([code isEqualToString:@"fail"]) {
                //交易失败
                [NavigateManager showMessage:@"交易失败"];
            }
            else if([code isEqualToString:@"cancel"]) {
                //交易取消
                [NavigateManager showMessage:@"交易取消"];
            }
        }];
    }
    
    
    return NO;
    
}

- (void)registerJPushOptions:(NSDictionary *)launchOptions{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {//iOS10以上
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //iOS8以上可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil];
    }else {//iOS8以下categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
    }
    BOOL isProduction = YES;// NO为开发环境，YES为生产环境
    [JPUSHService setupWithOption:launchOptions appKey:@"8e01c63912ee557cb05721a4" channel:nil apsForProduction:isProduction advertisingIdentifier:nil];
}

//iOS 7~10
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"this is iOS 7~10 Remote Notification");
    //处理
    [self disposeNotificationWithUserInfo:userInfo];
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//后台时
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{//通知的接收方法
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {//判断是否是远程通知类型
        //处理
        [self disposeNotificationWithUserInfo:userInfo];
        [JPUSHService handleRemoteNotification:userInfo];
    }else {
        // 本地通知
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler();
}
- (void)disposeNotificationWithUserInfo:(NSDictionary *)userInfo {
    //是否登录
    if (![UserData UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:vc animated:YES completion:nil];
        return ;
    }
    NSString *keyId = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
    if ([userInfo[@"style"] integerValue] == 1) {//用户
        if ([userInfo[@"type"] integerValue] == 1) {//婚庆订单详情
            OrderDetilNewViewController *orderDetilNewVc = [OrderDetilNewViewController new];
            orderDetilNewVc.id = [keyId integerValue];
            [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:orderDetilNewVc] animated:YES completion:nil];
        }else if ([userInfo[@"type"] integerValue] == 2) {//商城订单详情
            OrderDetilNewSCViewController *orderDetilNewSCVc = [OrderDetilNewSCViewController new];
            orderDetilNewSCVc.id = [keyId integerValue];
            [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:orderDetilNewSCVc] animated:YES completion:nil];
        }else if ([userInfo[@"type"] integerValue] == 3) {//通知消息
            //暂时不接入
        }
    }else {
        if ([userInfo[@"style"] integerValue] == 2) {//婚庆商家接单
            OrderDetilNewJDViewController *orderDetilNewJDVc = [OrderDetilNewJDViewController new];
            orderDetilNewJDVc.id = [keyId integerValue];
            [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:orderDetilNewJDVc] animated:YES completion:nil];
        }else if ([userInfo[@"style"] integerValue] == 3) {//商城商家接单
            ShangchengOderDetilJDViewController *shangchengOderDetilJDVc = [ShangchengOderDetilJDViewController new];
            shangchengOderDetilJDVc.id = [keyId integerValue];
            [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:shangchengOderDetilJDVc] animated:YES completion:nil];
        }
    }
}

@end
