//
//  NavigateManager.m
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "NavigateManager.h"
#import <UIKit/UIKit.h>
#import <RDVTabBarController/RDVTabBarController.h>

static NSString *NTESReadableTitle(UIViewController *vc) {
    if (!vc) {
        return @"";
    }
    NSString *title = vc.title;
    if (title.length == 0) {
        title = vc.navigationItem.title;
    }
    return title ?: @"";
}

static NSString *NTESDescribeViewController(UIViewController *vc) {
    if (!vc) {
        return @"<nil>";
    }
    NSString *className = NSStringFromClass([vc class]);
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        NSString *topTitle = NTESReadableTitle(nav.topViewController);
        if (topTitle.length > 0) {
            return [NSString stringWithFormat:@"%@ stack=%lu top=\"%@\"",
                    className, (unsigned long)nav.viewControllers.count, topTitle];
        }
        return [NSString stringWithFormat:@"%@ stack=%lu", className, (unsigned long)nav.viewControllers.count];
    }
    if ([vc isKindOfClass:[RDVTabBarController class]]) {
        RDVTabBarController *tab = (RDVTabBarController *)vc;
        return [NSString stringWithFormat:@"%@ tabs=%lu selected=%lu",
                className, (unsigned long)tab.viewControllers.count, (unsigned long)tab.selectedIndex];
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        NSUInteger selected = tab.selectedIndex;
        return [NSString stringWithFormat:@"%@ tabs=%lu selected=%lu",
                className, (unsigned long)tab.viewControllers.count, (unsigned long)selected];
    }
    NSString *title = NTESReadableTitle(vc);
    if (title.length > 0) {
        return [NSString stringWithFormat:@"%@ title=\"%@\"", className, title];
    }
    return className;
}

static void NTESAppendLine(NSMutableString *output, NSInteger indent, NSString *line) {
    if (!output || !line) {
        return;
    }
    for (NSInteger i = 0; i < indent; i++) {
        [output appendString:@"  "];
    }
    [output appendString:line];
    [output appendString:@"\n"];
}

static void NTESAppendViewControllerTree(UIViewController *vc, NSMutableString *output, NSInteger indent, NSString *label) {
    if (!vc) {
        return;
    }
    NSString *desc = NTESDescribeViewController(vc);
    if (label.length > 0) {
        NTESAppendLine(output, indent, [NSString stringWithFormat:@"%@: %@", label, desc]);
    } else {
        NTESAppendLine(output, indent, desc);
    }

    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        NSArray<UIViewController *> *stack = nav.viewControllers ?: @[];
        UIViewController *visible = nav.visibleViewController;
        for (NSInteger i = 0; i < (NSInteger)stack.count; i++) {
            UIViewController *child = stack[i];
            BOOL isVisible = (child == visible);
            BOOL isTop = (child == nav.topViewController);
            NSString *flag = isVisible ? @" (visible)" : (isTop ? @" (top)" : @"");
            NSString *childLabel = [NSString stringWithFormat:@"stack[%ld]%@",
                                    (long)i, flag];
            NTESAppendViewControllerTree(child, output, indent + 1, childLabel);
        }
    } else if ([vc isKindOfClass:[RDVTabBarController class]]) {
        RDVTabBarController *tab = (RDVTabBarController *)vc;
        NSArray<UIViewController *> *tabs = tab.viewControllers ?: @[];
        NSUInteger selected = tab.selectedIndex;
        for (NSUInteger i = 0; i < tabs.count; i++) {
            UIViewController *child = tabs[i];
            NSString *flag = (i == selected) ? @" (selected)" : @"";
            NSString *childLabel = [NSString stringWithFormat:@"tab[%lu]%@",
                                    (unsigned long)i, flag];
            NTESAppendViewControllerTree(child, output, indent + 1, childLabel);
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        NSArray<UIViewController *> *tabs = tab.viewControllers ?: @[];
        NSUInteger selected = tab.selectedIndex;
        for (NSUInteger i = 0; i < tabs.count; i++) {
            UIViewController *child = tabs[i];
            NSString *flag = (i == selected) ? @" (selected)" : @"";
            NSString *childLabel = [NSString stringWithFormat:@"tab[%lu]%@",
                                    (unsigned long)i, flag];
            NTESAppendViewControllerTree(child, output, indent + 1, childLabel);
        }
    } else {
        NSArray<UIViewController *> *children = vc.childViewControllers ?: @[];
        if (children.count > 0) {
            for (NSUInteger i = 0; i < children.count; i++) {
                UIViewController *child = children[i];
                NSString *childLabel = [NSString stringWithFormat:@"child[%lu]", (unsigned long)i];
                NTESAppendViewControllerTree(child, output, indent + 1, childLabel);
            }
        }
    }

    if (vc.presentedViewController) {
        NTESAppendViewControllerTree(vc.presentedViewController, output, indent + 1, @"presented");
    }
}

@implementation NavigateManager

+ (UIViewController *)getCurrentViewController
{
    UINavigationController *currentNavigateController = nil;
    UIViewController *viewController  = [[[UIApplication sharedApplication].delegate window] rootViewController];
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return nil;
    }
    
    currentNavigateController = (UINavigationController *)viewController;
    return [currentNavigateController visibleViewController];
}

+ (void)pushViewController:(__kindof UIViewController *)viewController
{
    UIViewController *curViewController = [NavigateManager getCurrentViewController];
    [curViewController.navigationController pushViewController:viewController animated:YES];
}

+ (void)popViewController:(__kindof UIViewController *)viewController
{
    UIViewController *curViewController = [NavigateManager getCurrentViewController];
    [curViewController.navigationController popToViewController:viewController animated:YES];
}

+ (UIView *)getShowView {
    if ([NavigateManager getCurrentViewController]) {
        return [NavigateManager getCurrentViewController].view;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (void)showMessage:(NSString *)message {
    [self showMessage:message inView:[NavigateManager getShowView]];
}

+ (void)showMessage:(NSString *)message inView:(UIView *)superView {
    
//    [NavigateManager hiddenLoadingMessage];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        [hud hide:YES afterDelay:1.5f];
    });
    
}


+ (void)showLoadingMessage:(NSString *)message {
    
    [NavigateManager hiddenLoadingMessage];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[NavigateManager getShowView] animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.graceTime = 1;
        hud.labelText = message;
    });
    
}
+ (void)hiddenLoadingMessage {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in [NavigateManager getShowView] .subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                MBProgressHUD *hud = (MBProgressHUD *)view;
                [hud hide:YES];
            }
        }
    });
    
}


+ (void)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage {
    
    [NavigateManager hiddenLoadingMessage];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[NavigateManager getShowView] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = detailMessage;
        hud.labelText = message;
        [hud hide:YES afterDelay:2.5f];
    });
    
    
}

+ (NSString *)viewControllerHierarchyPath {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        return @"<no window>";
    }
    UIViewController *root = window.rootViewController;
    if (!root) {
        return @"<no root view controller>";
    }
    NSMutableString *output = [[NSMutableString alloc] init];
    NTESAppendViewControllerTree(root, output, 0, @"root");
    return [output copy];
}

+ (void)logViewControllerHierarchyPath {
    NSString *path = [self viewControllerHierarchyPath];
    NSLog(@"VC Hierarchy:\n%@", path);
}
@end
