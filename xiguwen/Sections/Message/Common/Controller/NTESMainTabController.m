//
//  MainTabController.m
//  NIMDemo
//
//  Created by chris on 15/2/2.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESMainTabController.h"
#import "AppDelegate.h"
#import "UIImage+NTESColor.h"
//#import "NTESCustomNotificationDB.h"
//#import "NTESNotificationCenter.h"
#import "NTESNavigationHandler.h"
#import "NTESNavigationAnimator.h"
//#import "NTESBundleSetting.h"
#import <RDVTabBarController/RDVTabBarItem.h>
#import "IndexViewController.h"
#import "IndexSubViewController.h"
#import "MyNewViewController.h"
#import "FindNewSubViewController.h"
#import "ShopNewCarSubViewController.h"
#import "MessageSubViewController.h"
#import "MyNewViewController.h"
#import "NavigateManager.h"
#import "UIViewController+Swizzling.h"
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



@interface NTESMainTabController ()<NIMSystemNotificationManagerDelegate,RDVTabBarControllerDelegate>

@property (nonatomic,strong) NSArray *navigationHandlers;

@property (nonatomic,strong) NTESNavigationAnimator *animator;

@property (nonatomic,assign) NSInteger sessionUnreadCount;

@property (nonatomic,assign) NSInteger systemUnreadCount;

@property (nonatomic,assign) NSInteger customSystemUnreadCount;

@property (nonatomic,copy)  NSDictionary *configs;

@end

@implementation NTESMainTabController

static NSInteger const kTabBarTopLineTag = 91342;

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
    self.viewControllers = [self buildViewControllers];
    [self configureTabBarItems];
    [self configureTabBarAppearance];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
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
#ifdef DEBUG
    [NavigateManager logViewControllerHierarchyPath];
#endif
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutTabBarTopLine];
}

- (void)configureTabBarAppearance
{
    RDVTabBar *tabBar = self.tabBar;
    tabBar.translucent = NO;
    tabBar.backgroundColor = [UIColor clearColor];
    tabBar.layoutMargins = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        tabBar.insetsLayoutMarginsFromSafeArea = NO;
        tabBar.directionalLayoutMargins = NSDirectionalEdgeInsetsZero;
    }
    tabBar.contentEdgeInsets = UIEdgeInsetsZero;
    tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    tabBar.backgroundView.layer.cornerRadius = 0.0;
    tabBar.backgroundView.layer.masksToBounds = YES;
    [self layoutTabBarTopLine];
}

- (void)layoutTabBarTopLine {
    RDVTabBar *tabBar = self.tabBar;
    if (!tabBar) {
        return;
    }
    UIView *line = [tabBar viewWithTag:kTabBarTopLineTag];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = kTabBarTopLineTag;
        line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [tabBar addSubview:line];
    }
    CGFloat height = 1.0 / [UIScreen mainScreen].scale;
    line.frame = CGRectMake(0, 0, tabBar.bounds.size.width, height);
    [tabBar bringSubviewToFront:line];
}

- (void)configureTabBarItems
{
    NSArray<RDVTabBarItem *> *items = self.tabBar.items;
    if (items.count == 0) {
        return;
    }
    [items enumerateObjectsUsingBlock:^(RDVTabBarItem *item, NSUInteger idx, BOOL *stop) {
        NSDictionary *cfg = [self vcInfoForTabType:(NTESMainTabType)idx];
        NSString *title = cfg[TabbarTitle] ?: @"";
        NSString *imageName = cfg[TabbarImage] ?: @"";
        NSString *selectedImageName = cfg[TabbarSelectedImage] ?: @"";
        UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        item.title = title;
        item.unselectedTitleAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0],
                                           NSFontAttributeName : [UIFont systemFontOfSize:10.0]};
        item.selectedTitleAttributes = @{NSForegroundColorAttributeName : MAINCOLOR,
                                         NSFontAttributeName : [UIFont systemFontOfSize:10.0]};
        // Increase spacing between icon and title.
        item.imagePositionAdjustment = UIOffsetMake(0.0, -4.0);
        item.titlePositionAdjustment = UIOffsetMake(0.0, 4.0);
    }];
}

- (void)dealloc{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray*)tabbars{
    self.sessionUnreadCount  = 0;
    self.systemUnreadCount   = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
//    self.customSystemUnreadCount = [[NTESCustomNotificationDB sharedInstance] unreadCount];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}


- (NSArray<UIViewController *> *)buildViewControllers
{
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title = item[TabbarTitle] ?: @"";
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
        
        
        vc.title = title;
        vc.hidesBottomBarWhenPushed = NO;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [vcArray addObject:nav];
    }];
    return [vcArray copy];
}


- (void)setUpStatusBar{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:style
                                                animated:NO];
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


- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    BOOL shouldSelect = YES;
    UINavigationController *nav = (UINavigationController *)viewController;
    if ([nav.topViewController isKindOfClass:[MessageSubViewController class]] || [nav.topViewController isKindOfClass:[ShopNewCarSubViewController class]] || [nav.topViewController isKindOfClass:[MyNewViewController class]]) {
        if (![UserDataNew UserLoginState]) {
            [self showLogin];
            shouldSelect = NO;
        }
    }
    return shouldSelect;
}
//没登录不能进

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
#ifdef DEBUG
    [NavigateManager logViewControllerHierarchyPath];
#endif
    UINavigationController *nav = (UINavigationController *)viewController;
    UIViewController *top = nav.topViewController;
    BOOL shouldHide = [top ntes_shouldHideTabBarInNavigationController:nav];
    [tabBarController setTabBarHidden:shouldHide animated:NO];
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
