//
//  NavigateManager.h
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigateManager : NSObject

+ (void)pushViewController:(__kindof UIViewController *)viewController;

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message inView:(UIView *)superView;
+ (UIViewController *)getCurrentViewController;
+ (void)showLoadingMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage ;
+ (void)hiddenLoadingMessage;

+ (UIView *)getShowView;
@end
