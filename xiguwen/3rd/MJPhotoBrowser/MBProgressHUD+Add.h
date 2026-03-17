//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

//默认1.5
+(void) showMsg:(NSString *) msg;
//用户自定义
+(void) showMsg:(NSString *) msg  withTime:(float) time;
//加载菊花
+ (void)show:(NSString *)text  view:(UIView *)view;

@end
