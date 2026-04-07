//
//  FatherTabbarViewController.m
//  Base
//
//  Created by Chen on 2016/11/29.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "FatherTabbarViewController.h"
#import "BaseNavigationViewController.h"

@interface FatherTabbarViewController () <UITabBarControllerDelegate>

@end

@implementation FatherTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadViewController];
    [self applyTabBarAppearance];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateTabBarFrameToScreenBottom];
    [self normalizeTabBarSubviews];
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    [self updateTabBarFrameToScreenBottom];
    [self normalizeTabBarSubviews];
}

- (void)applyTabBarAppearance
{
    if (@available(iOS 18.0, *)) {
        self.mode = UITabBarControllerModeTabBar;
    }
    if (@available(iOS 26.0, *)) {
        self.tabBarMinimizeBehavior = UITabBarMinimizeBehaviorNever;
    }
    self.tabBar.translucent = NO;
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.layoutMargins = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        self.tabBar.insetsLayoutMarginsFromSafeArea = NO;
        self.tabBar.directionalLayoutMargins = NSDirectionalEdgeInsetsZero;
    }
    self.tabBar.layer.cornerRadius = 0.0;
    self.tabBar.layer.masksToBounds = YES;
    self.tabBar.layer.shadowColor = nil;
    self.tabBar.layer.shadowOpacity = 0.0;
    self.tabBar.layer.shadowOffset = CGSizeZero;
    self.tabBar.layer.shadowRadius = 0.0;
    self.tabBar.itemPositioning = UITabBarItemPositioningFill;
    self.tabBar.itemSpacing = 0.0;
    self.tabBar.itemWidth = 0.0;
    self.tabBar.clipsToBounds = YES;
    self.tabBar.selectionIndicatorImage = [UIImage new];
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.backgroundImage = [UIImage new];
        appearance.shadowImage = [UIImage new];
        appearance.shadowColor = [UIColor clearColor];
        appearance.selectionIndicatorImage = [UIImage new];
        appearance.selectionIndicatorTintColor = [UIColor clearColor];
        appearance.stackedItemPositioning = UITabBarItemPositioningFill;
        appearance.stackedItemSpacing = 0.0;
        appearance.stackedItemWidth = 0.0;
        self.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = appearance;
        }
    }
}

- (void)updateTabBarFrameToScreenBottom
{
    CGRect containerBounds = self.view.bounds;
    if (self.view.window) {
        containerBounds = [self.view convertRect:self.view.window.bounds fromView:self.view.window];
    }
    CGRect frame = self.tabBar.frame;
    frame.origin.x = containerBounds.origin.x;
    frame.size.width = containerBounds.size.width;
    frame.origin.y = CGRectGetMaxY(containerBounds) - frame.size.height;
    self.tabBar.frame = frame;
    self.tabBar.bounds = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height);
    [self normalizeTabBarBackgroundView];
}

- (void)normalizeTabBarBackgroundView
{
    for (UIView *subview in self.tabBar.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        BOOL isBackground = [className containsString:@"Background"] || [subview isKindOfClass:[UIVisualEffectView class]];
        if (isBackground) {
            subview.frame = self.tabBar.bounds;
            subview.layoutMargins = UIEdgeInsetsZero;
            subview.preservesSuperviewLayoutMargins = NO;
            if (@available(iOS 11.0, *)) {
                subview.insetsLayoutMarginsFromSafeArea = NO;
            }
            subview.layer.cornerRadius = 0.0;
            subview.layer.masksToBounds = NO;
            subview.layer.shadowColor = nil;
            subview.layer.shadowOpacity = 0.0;
            subview.layer.shadowOffset = CGSizeZero;
            subview.layer.shadowRadius = 0.0;
        }
    }
}

- (void)normalizeTabBarSubviews
{
    [self normalizeTabBarSubview:self.tabBar];
    [self layoutTabBarButtonsToFill];
}

- (void)normalizeTabBarSubview:(UIView *)view
{
    NSString *className = NSStringFromClass([view class]);
    BOOL isBackground = [className containsString:@"Background"] || [view isKindOfClass:[UIVisualEffectView class]];
    BOOL isTabBarButton = [className containsString:@"TabBarButton"];
    if (isBackground) {
        view.frame = self.tabBar.bounds;
        view.layoutMargins = UIEdgeInsetsZero;
        view.preservesSuperviewLayoutMargins = NO;
        if (@available(iOS 11.0, *)) {
            view.insetsLayoutMarginsFromSafeArea = NO;
        }
        view.layer.cornerRadius = 0.0;
        view.layer.masksToBounds = YES;
        view.layer.shadowColor = nil;
        view.layer.shadowOpacity = 0.0;
        view.layer.shadowOffset = CGSizeZero;
        view.layer.shadowRadius = 0.0;
    }
    if (isTabBarButton) {
        view.transform = CGAffineTransformIdentity;
        view.layer.cornerRadius = 0.0;
        view.layer.shadowColor = nil;
        view.layer.shadowOpacity = 0.0;
        view.layer.shadowOffset = CGSizeZero;
        view.layer.shadowRadius = 0.0;
    }
    for (UIView *subview in view.subviews) {
        [self normalizeTabBarSubview:subview];
    }
}

- (void)layoutTabBarButtonsToFill
{
    NSMutableArray<UIView *> *buttons = [NSMutableArray array];
    for (UIView *subview in self.tabBar.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        if ([className containsString:@"TabBarButton"]) {
            [buttons addObject:subview];
        }
    }
    if (buttons.count == 0) {
        return;
    }
    [buttons sortUsingComparator:^NSComparisonResult(UIView *a, UIView *b) {
        CGFloat ax = CGRectGetMinX(a.frame);
        CGFloat bx = CGRectGetMinX(b.frame);
        if (ax < bx) {
            return NSOrderedAscending;
        } else if (ax > bx) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    CGFloat totalWidth = CGRectGetWidth(self.tabBar.bounds);
    CGFloat height = CGRectGetHeight(self.tabBar.bounds);
    CGFloat width = floor(totalWidth / buttons.count);
    CGFloat remainder = totalWidth - width * buttons.count;
    [buttons enumerateObjectsUsingBlock:^(UIView *button, NSUInteger idx, BOOL *stop) {
        CGFloat extra = (idx == buttons.count - 1) ? remainder : 0.0;
        CGRect frame = CGRectMake(width * idx, 0.0, width + extra, height);
        button.frame = frame;
        button.transform = CGAffineTransformIdentity;
        button.layer.cornerRadius = 0.0;
        button.layer.shadowColor = nil;
        button.layer.shadowOpacity = 0.0;
        button.layer.shadowOffset = CGSizeZero;
        button.layer.shadowRadius = 0.0;
        button.layoutMargins = UIEdgeInsetsZero;
        button.preservesSuperviewLayoutMargins = NO;
        if (@available(iOS 11.0, *)) {
            button.insetsLayoutMarginsFromSafeArea = NO;
            button.directionalLayoutMargins = NSDirectionalEdgeInsetsZero;
        }
        for (UIView *subview in button.subviews) {
            NSString *subClassName = NSStringFromClass([subview class]);
            if ([subClassName containsString:@"Selection"] ||
                [subClassName containsString:@"Indicator"] ||
                [subClassName containsString:@"Highlight"]) {
                subview.hidden = YES;
                subview.alpha = 0.0;
            }
            subview.transform = CGAffineTransformIdentity;
            subview.layer.cornerRadius = 0.0;
            subview.layer.shadowColor = nil;
            subview.layer.shadowOpacity = 0.0;
            subview.layer.shadowOffset = CGSizeZero;
            subview.layer.shadowRadius = 0.0;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  标签栏控制器
 */

- (void)loadViewController {
    
//    self.view.backgroundColor          = [UIColor blackColor];

    NSArray *arr = APP_MESSAGE_ENTRY_ENABLED
    ? @[@"首页",@"案例-(1)hui",@"爱心",@"消息",@"联系人"]
    : @[@"首页",@"案例-(1)hui",@"爱心",@"联系人"];
    NSArray *arrSelect = APP_MESSAGE_ENTRY_ENABLED
    ? @[@"首页_red",@"案例-(1)",@"爱心red",@"消息red",@"联系人red"]
    : @[@"首页_red",@"案例-(1)",@"爱心red",@"联系人red"];
    NSArray *nameArray = APP_MESSAGE_ENTRY_ENABLED
    ? @[@"首页",@"案例",@"喜帖",@"消息",@"我的"]
    : @[@"首页",@"案例",@"喜帖",@"我的"];
    NSArray *vcArray = APP_MESSAGE_ENTRY_ENABLED
    ? @[@"IndexViewController",@"FindViewController",@"WeddingCardViewController",@"MessageViewController",@"MineViewController"]
    : @[@"IndexViewController",@"FindViewController",@"WeddingCardViewController",@"MineViewController"];
    
    NSMutableArray *NavArr = [[NSMutableArray alloc] initWithCapacity:vcArray.count];
    
    for (int i = 0; i < vcArray.count; i++) {
        id vc = [[NSClassFromString(vcArray[i]) alloc] init];
        
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:nameArray[i]
                                                      image:[[UIImage imageNamed:arr[i]]
                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[[UIImage imageNamed:arrSelect[i]]
                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [NavArr addObject:nav];
    }
    self.delegate = self;
    self.viewControllers = NavArr;
    //设定Tabbar的点击后的颜色
    
    [[UITabBar appearance] setTintColor:MAINCOLOR];
    
    //设定Tabbar的颜色
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    self.hidesBottomBarWhenPushed = YES;
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    for (int i = 0; i < self.viewControllers.count; i++) {
//        if ([viewController isEqual:self.viewControllers[i]]) {
//            if (i == 4 && !TOKEN) {
//                LoginViewController *vc = [[LoginViewController alloc] init];
//                [self presentViewController:[[BaseNavigationViewController alloc] initWithRootViewController:vc] animated:YES completion:^{
//                    
//                }];
//                return NO;
//            }
//            
//        }
        if ([viewController isEqual:self.viewControllers[i]] && i != self.selectedIndex) {
            UIView *view = self.tabBar.subviews[i + 1];
            [UIView transitionWithView:view duration:0.35 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self normalizeTabBarSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.08 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self normalizeTabBarSubviews];
    });
}
@end
