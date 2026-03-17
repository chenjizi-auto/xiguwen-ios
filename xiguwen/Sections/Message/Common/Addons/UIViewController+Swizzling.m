//
//  UIViewController+Swizzling.m
//  NIM
//
//  Created by chris on 15/6/15.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "SwizzlingDefine.h"
#import "UIResponder+NTESFirstResponder.h"
#import "UIView+NTES.h"
#import "UIImage+NTESColor.h"
#import <RDVTabBarController/RDVTabBarController.h>
#import <RDVTabBarController/RDVTabBarItem.h>
#import <RDVTabBarController/RDVTabBar.h>

static CGFloat const NTESBaseTabBarHeight = 50.0;

static CGFloat NTESBottomSafeAreaInsetForView(UIView *view) {
    if (!view) {
        return 0.0;
    }
    if (@available(iOS 11.0, *)) {
        CGFloat inset = view.safeAreaInsets.bottom;
        if (inset <= 0.0 && view.superview) {
            inset = view.superview.safeAreaInsets.bottom;
        }
        if (inset <= 0.0 && view.window) {
            inset = view.window.safeAreaInsets.bottom;
        }
        return MAX(inset, 0.0);
    }
    return 0.0;
}

@implementation UIViewController (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillAppear:), @selector(swizzling_viewWillAppear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidAppear:), @selector(swizzling_viewDidAppear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillDisappear:), @selector(swizzling_viewWillDisappear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidLoad),    @selector(swizzling_viewDidLoad));
        swizzling_exchangeMethod([UIViewController class], @selector(init), @selector(swizzling_init));
        swizzling_exchangeMethod([UIViewController class], @selector(initWithCoder:), @selector(swizzling_initWithCoder:));
        swizzling_exchangeMethod([UIViewController class], @selector(initWithNibName:bundle:), @selector(swizzling_initWithNibName:bundle:));
        Class tabBarClass = NSClassFromString(@"RDVTabBarController");
        if (tabBarClass) {
            swizzling_exchangeMethod(tabBarClass, @selector(viewDidLayoutSubviews), @selector(ntes_rdv_viewDidLayoutSubviews));
        }
        Class rdvTabBarClass = NSClassFromString(@"RDVTabBar");
        if (rdvTabBarClass) {
            swizzling_exchangeMethod(rdvTabBarClass, @selector(layoutSubviews), @selector(ntes_rdv_tabBar_layoutSubviews));
        }
    });
}

#pragma mark - ViewDidLoad
- (void)swizzling_viewDidLoad{
    if (self.navigationController) {
        UIImage *buttonNormal = [[UIImage imageNamed:@"返回(red)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationController.navigationBar setBackIndicatorImage:buttonNormal];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:buttonNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
    }
    [self swizzling_viewDidLoad];
}


#pragma mark - InitWithNibName:bundle:
//如果希望vchidesBottomBarWhenPushed为NO的话，请在vc init方法之后调用vc.hidesBottomBarWhenPushed = NO;
- (instancetype)swizzling_init {
    id instance = [self swizzling_init];
    if (instance) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return instance;
}

- (instancetype)swizzling_initWithCoder:(NSCoder *)coder {
    id instance = [self swizzling_initWithCoder:coder];
    if (instance) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return instance;
}

- (instancetype)swizzling_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    id instance = [self swizzling_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (instance) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return instance;
}

#pragma mark - ViewWillAppear
static char UIFirstResponderViewAddress;

- (void)swizzling_viewWillAppear:(BOOL)animated{
    [self swizzling_viewWillAppear:animated];
    [self ntes_updateTabBarHiddenIfNeeded];
    if (self.parentViewController == self.navigationController)
    {
        if ([self swizzling_isUseClearBar] && self.navigationController)
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }
        else
        {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
        }
    }
}

#pragma mark - RDV TabBar Visibility
- (void)ntes_updateTabBarHiddenIfNeeded
{
    RDVTabBarController *tabBarController = self.rdv_tabBarController;
    if (!tabBarController) {
        return;
    }
    if (!self.navigationController) {
        return;
    }
    BOOL shouldHide = [self ntes_shouldHideTabBarInNavigationController:self.navigationController];
    [tabBarController setTabBarHidden:shouldHide animated:NO];
}

- (UIViewController *)ntes_tabBarVisibilityOwnerViewController
{
    UINavigationController *navigationController = self.navigationController;
    if (!navigationController) {
        return self;
    }

    UIViewController *owner = self;
    while (owner.parentViewController && owner.parentViewController != navigationController) {
        owner = owner.parentViewController;
    }
    return owner ?: self;
}

- (BOOL)ntes_shouldHideTabBarInNavigationController:(UINavigationController *)navigationController
{
    if (!navigationController) {
        return NO;
    }

    UIViewController *owner = [self ntes_tabBarVisibilityOwnerViewController];
    UIViewController *root = navigationController.viewControllers.firstObject;
    return owner.hidesBottomBarWhenPushed && owner != root;
}

#pragma mark - RDV TabBar Layout
- (void)ntes_rdv_viewDidLayoutSubviews
{
    [self ntes_rdv_viewDidLayoutSubviews];
    if (![self isKindOfClass:[RDVTabBarController class]]) {
        return;
    }
    RDVTabBarController *tabController = (RDVTabBarController *)self;
    CGSize viewSize = tabController.view.bounds.size;
    CGFloat safeAreaBottom = NTESBottomSafeAreaInsetForView(tabController.view);
    CGFloat tabBarHeight = NTESBaseTabBarHeight + safeAreaBottom;
    CGFloat tabBarStartingY = viewSize.height;
    CGFloat contentViewHeight = viewSize.height;
    if (!tabController.isTabBarHidden) {
        tabBarStartingY = viewSize.height - tabBarHeight;
        if (!tabController.tabBar.isTranslucent) {
            contentViewHeight -= tabBarHeight;
        }
    }

    tabController.tabBar.frame = CGRectMake(0, tabBarStartingY, viewSize.width, tabBarHeight);
    [tabController.tabBar setNeedsLayout];

    UIView *contentView = nil;
    SEL contentSelector = NSSelectorFromString(@"contentView");
    if ([tabController respondsToSelector:contentSelector]) {
        SuppressPerformSelectorLeakWarning(contentView = [tabController performSelector:contentSelector]);
    }
    if (!contentView) {
        for (UIView *subview in tabController.view.subviews) {
            if (subview != tabController.tabBar) {
                contentView = subview;
                break;
            }
        }
    }
    if ([contentView isKindOfClass:[UIView class]]) {
        contentView.frame = CGRectMake(0, 0, viewSize.width, contentViewHeight);
        UIViewController *selected = tabController.selectedViewController;
        if (selected) {
            selected.view.frame = contentView.bounds;
        }
    }
}

#pragma mark - RDV TabBar Layout
- (void)ntes_rdv_tabBar_layoutSubviews
{
    if (![self isKindOfClass:[RDVTabBar class]]) {
        [self ntes_rdv_tabBar_layoutSubviews];
        return;
    }
    RDVTabBar *tabBar = (RDVTabBar *)self;
    NSArray *items = tabBar.items;
    if (items.count == 0) {
        [self ntes_rdv_tabBar_layoutSubviews];
        return;
    }
    CGFloat safeAreaBottom = NTESBottomSafeAreaInsetForView(tabBar);
    CGFloat tabBarHeight = MAX(CGRectGetHeight(tabBar.bounds), NTESBaseTabBarHeight + safeAreaBottom);
    CGFloat visibleItemHeight = MAX(tabBarHeight - safeAreaBottom, NTESBaseTabBarHeight);
    tabBar.contentEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, safeAreaBottom, 0.0);
    [items enumerateObjectsUsingBlock:^(RDVTabBarItem *item, NSUInteger idx, BOOL *stop) {
        item.itemHeight = tabBarHeight;
    }];
    [self ntes_rdv_tabBar_layoutSubviews];

    CGFloat width = CGRectGetWidth(tabBar.bounds) / items.count;
    [items enumerateObjectsUsingBlock:^(RDVTabBarItem *item, NSUInteger idx, BOOL *stop) {
        item.frame = CGRectMake(width * idx, 0.0, width, visibleItemHeight);
    }];
    [tabBar setNeedsDisplay];
}

#pragma mark - ViewDidAppear
- (void)swizzling_viewDidAppear:(BOOL)animated{
    [self swizzling_viewDidAppear:animated];
    UIView *view = objc_getAssociatedObject(self, &UIFirstResponderViewAddress);
    [view becomeFirstResponder];
}


#pragma mark - ViewWillDisappear

- (void)swizzling_viewWillDisappear:(BOOL)animated{
    [self swizzling_viewWillDisappear:animated];
    UIView *view = (UIView *)[UIResponder currentFirstResponder];
    if ([view isKindOfClass:[UIView class]] && view.viewController == self) {
        objc_setAssociatedObject(self, &UIFirstResponderViewAddress, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [view resignFirstResponder];
    }else{
        objc_setAssociatedObject(self, &UIFirstResponderViewAddress, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - Private
- (BOOL)swizzling_isUseClearBar
{
    SEL  sel = NSSelectorFromString(@"useClearBar");
    BOOL use = NO;
    if ([self respondsToSelector:sel]) {
        SuppressPerformSelectorLeakWarning(use = (BOOL)[self performSelector:sel]);
    }
    return use;
}


@end
