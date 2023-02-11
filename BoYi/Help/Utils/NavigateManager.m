//
//  NavigateManager.m
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "NavigateManager.h"

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
@end
