//
//  MainTabController.m
//  NIMDemo
//
//  Created by chris on 15/2/2.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESMainTabController.h"
#import "AppDelegate.h"
#import "NTESSessionListViewController.h"
#import "NTESContactViewController.h"
#import "UIImage+NTESColor.h"
//#import "NTESCustomNotificationDB.h"
//#import "NTESNotificationCenter.h"
#import "NTESNavigationHandler.h"
#import "NTESNavigationAnimator.h"
//#import "NTESBundleSetting.h"
#import "IndexViewController.h"
#import "IndexSubViewController.h"
#import "MyNewViewController.h"
#import "FindNewSubViewController.h"
#import "ShopNewCarSubViewController.h"
#import "MessageSubViewController.h"
#import "MyNewViewController.h"
#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabbarItemBadgeValue @"badgeValue"
#define TabBarCount 5

typedef NS_ENUM(NSInteger,NTESMainTabType) {
    
    NTESMainTabTypeindex = 0,        //通讯录
    NTESMainTabTypefind = 1,   //聊天室
    NTESMainTabTypeMessage = 2,    //聊天
    NTESMainTabTypecar = 3,    //聊天
    NTESMainTabTypemy = 4,        //设置
};



@interface NTESMainTabController ()<NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate,UITabBarControllerDelegate>

@property (nonatomic,strong) NSArray *navigationHandlers;

@property (nonatomic,strong) NTESNavigationAnimator *animator;

@property (nonatomic,assign) NSInteger sessionUnreadCount;

@property (nonatomic,assign) NSInteger systemUnreadCount;

@property (nonatomic,assign) NSInteger customSystemUnreadCount;

@property (nonatomic,copy)  NSDictionary *configs;

@end

@implementation NTESMainTabController

+ (instancetype)instance{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[NTESMainTabController class]]) {
        return (NTESMainTabController *)vc;
    }else{
        return nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUpSubNav];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    self.delegate = self;
    extern NSString *NTESCustomNotificationCountChanged;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCustomNotifyChanged:) name:NTESCustomNotificationCountChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin) name:@"UserNotLoginIn_ToLogin" object:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpStatusBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //会话界面发送拍摄的视频，拍摄结束后点击发送后可能顶部会有红条，导致的界面错位。
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Ensure tab bar sticks to the bottom and spans full width.
    CGRect frame = self.tabBar.frame;
    frame.origin.x = 0.0;
    frame.size.width = self.view.bounds.size.width;
    frame.origin.y = self.view.bounds.size.height - frame.size.height;
    self.tabBar.frame = frame;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray*)tabbars{
    self.sessionUnreadCount  = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    self.systemUnreadCount   = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
//    self.customSystemUnreadCount = [[NTESCustomNotificationDB sharedInstance] unreadCount];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}


- (void)setUpSubNav{
    NSMutableArray *handleArray = [[NSMutableArray alloc] init];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title  = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc;
        
        if ([vcName isEqualToString:@"IndexSubViewController"]) {
            IndexSubViewController *orderSub = [[IndexSubViewController alloc] init];
            orderSub.titleColorSelected = MAINCOLOR;
            orderSub.menuViewStyle = WMMenuViewStyleLine;
            orderSub.automaticallyCalculatesItemWidths = YES;
            orderSub.progressWidth = 40;
            orderSub.progressViewIsNaughty = YES;
            
            
            vc = orderSub;
        }else if ([vcName isEqualToString:@"FindNewSubViewController"]){
            FindNewSubViewController *orderSub = [[FindNewSubViewController alloc] init];
            orderSub.titleColorSelected = MAINCOLOR;
            orderSub.menuViewStyle = WMMenuViewStyleLine;
            orderSub.automaticallyCalculatesItemWidths = YES;
            orderSub.progressWidth = ScreenWidth / 2;
            
            orderSub.progressViewIsNaughty = YES;
            vc = orderSub;
        }else if ([vcName isEqualToString:@"ShopNewCarSubViewController"]){
            ShopNewCarSubViewController *orderSub = [[ShopNewCarSubViewController alloc] init];
            orderSub.titleColorSelected = MAINCOLOR;
            orderSub.menuViewStyle = WMMenuViewStyleLine;
            orderSub.automaticallyCalculatesItemWidths = YES;
            orderSub.progressWidth = 40;
            orderSub.progressViewIsNaughty = YES;
            orderSub.scrollEnable = NO;
            vc = orderSub;
        }else if ([vcName isEqualToString:@"MessageSubViewController"]){
            MessageSubViewController *orderSub = [[MessageSubViewController alloc] init];
            orderSub.titleColorSelected = MAINCOLOR;
            orderSub.menuViewStyle = WMMenuViewStyleLine;
            orderSub.automaticallyCalculatesItemWidths = YES;
            orderSub.progressWidth = 40;
            orderSub.progressViewIsNaughty = YES;
            orderSub.scrollEnable = NO;
            vc = orderSub;
        }else {
            vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        }
        
        
        vc.hidesBottomBarWhenPushed = NO;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        //        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
        //                                                       image:[UIImage imageNamed:imageName]
        //                                               selectedImage:[UIImage imageNamed:imageSelected]];
        nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title
                                                      image:[[UIImage imageNamed:imageName]
                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[[UIImage imageNamed:imageSelected]
                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[TabbarItemBadgeValue] integerValue];
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        //        NTESNavigationHandler *handler = [[NTESNavigationHandler alloc] initWithNavigationController:nav];
        //        nav.delegate = handler;
        
        [vcArray addObject:nav];
        //        [handleArray addObject:handler];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
    //    self.navigationHandlers = [NSArray arrayWithArray:handleArray];
    
    //设定Tabbar的点击后的颜色
    
    [[UITabBar appearance] setTintColor:MAINCOLOR];
    
    //设定Tabbar的颜色
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}


- (void)setUpStatusBar{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:style
                                                animated:NO];
}


#pragma mark - NIMConversationManagerDelegate
- (void)didAddRecentSession:(NIMRecentSession *)recentSession
           totalUnreadCount:(NSInteger)totalUnreadCount{
    self.sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}


- (void)didUpdateRecentSession:(NIMRecentSession *)recentSession
              totalUnreadCount:(NSInteger)totalUnreadCount{
    self.sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}


- (void)didRemoveRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    self.sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}

- (void)messagesDeletedInSession:(NIMSession *)session{
    self.sessionUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    [self refreshSessionBadge];
}

- (void)allMessagesDeleted{
    self.sessionUnreadCount = 0;
    [self refreshSessionBadge];
}

#pragma mark - NIMSystemNotificationManagerDelegate
- (void)onSystemNotificationCountChanged:(NSInteger)unreadCount
{
    self.systemUnreadCount = unreadCount;
    //    [self refreshContactBadge];
}

#pragma mark - Notification
//- (void)onCustomNotifyChanged:(NSNotification *)notification
//{
//    NTESCustomNotificationDB *db = [NTESCustomNotificationDB sharedInstance];
//    self.customSystemUnreadCount = db.unreadCount;
//    //    [self refreshSettingBadge];
//}



- (void)refreshSessionBadge{
//    UINavigationController *nav = self.viewControllers[NTESMainTabTypeMessage];
//    nav.tabBarItem.badgeValue = self.sessionUnreadCount ? @(self.sessionUnreadCount).stringValue : nil;
}

//- (void)refreshContactBadge{
//    UINavigationController *nav = self.viewControllers[NTESMainTabTypeContact];
//    NSInteger badge = self.systemUnreadCount;
//    nav.tabBarItem.badgeValue = badge ? @(badge).stringValue : nil;
//}
//
//- (void)refreshSettingBadge{
//    UINavigationController *nav = self.viewControllers[NTESMainTabTypeSetting];
//    NSInteger badge = self.customSystemUnreadCount;
//    nav.tabBarItem.badgeValue = badge ? @(badge).stringValue : nil;
//}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}



#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(NTESMainTabType)type{
    
    if (_configs == nil)
    {
        _configs = @{
                     @(NTESMainTabTypeindex) : @{
                             TabbarVC           : @"IndexSubViewController",
                             TabbarTitle        : @"首页",
                             TabbarImage        : @"首页",
                             TabbarSelectedImage: @"首页sele"
                             },
                     @(NTESMainTabTypefind)     : @{
                             TabbarVC           : @"FindNewSubViewController",
                             TabbarTitle        : @"发现",
                             TabbarImage        : @"发现",
                             TabbarSelectedImage: @"发现sele",
                             //                             TabbarItemBadgeValue: @(self.systemUnreadCount)
                             },
                     @(NTESMainTabTypeMessage): @{
                             TabbarVC           : @"MessageSubViewController",
                             TabbarTitle        : @"消息",
                             TabbarImage        : @"消息",
                             TabbarSelectedImage: @"消息sele",
                             TabbarItemBadgeValue: @(self.sessionUnreadCount)
                             },
                     @(NTESMainTabTypecar): @{
                             TabbarVC           : @"ShopNewCarSubViewController",
                             TabbarTitle        : @"购物车",
                             TabbarImage        : @"购物车",
                             TabbarSelectedImage: @"购物车sele",
                             //                             TabbarItemBadgeValue: @(self.sessionUnreadCount)
                             },
                     @(NTESMainTabTypemy)     : @{
                             TabbarVC           : @"MyNewViewController",
                             TabbarTitle        : @"我的",
                             TabbarImage        : @"我的",
                             TabbarSelectedImage: @"我的sele",
                             //                             TabbarItemBadgeValue: @(self.customSystemUnreadCount)
                             }
                     };
        
    }
    return _configs[@(type)];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    UINavigationController *nav = (UINavigationController *)viewController;
    if ([nav.topViewController isKindOfClass:[MessageSubViewController class]] || [nav.topViewController isKindOfClass:[ShopNewCarSubViewController class]] || [nav.topViewController isKindOfClass:[MyNewViewController class]]) {
        if (![UserDataNew UserLoginState]) {
            [self showLogin];
            return NO;
        }
    }
    
    return YES;
}
//没登录不能进

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    
    
    
    //    return YES;
}
- (void)showLogin {
    
    //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"需要登录才能进行此操作" preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
    //
    NewLoginViewController *vc = [[NewLoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:NULL];
    
    //        }];
    //
    //        UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnull action) {
    //
    //
    //        }];
    //        [alertController addAction:sureAction];
    //        [alertController addAction:cancelAction];
    //        [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
