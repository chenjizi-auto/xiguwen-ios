//
//  AlertManger.m
//  DoctorDnd
//
//  Created by MedCare on 2017/3/15.
//  Copyright © 2017年 zengmaolin. All rights reserved.
//

#import "AlertManger.h"

@implementation AlertManger
+ (void)showSingleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                okClikedHandle:(AlertViewOkClicked)okHandle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okHandle) {
            okHandle();
        }

    }];
    //修改按钮颜色
//    [action setValue:ZMLColor(69, 173, 216) forKey:@"titleTextColor"];
    [alert addAction:action];
    [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

+ (void)showwSingleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                  okClikedHandle:(AlertViewOkClicked)okHandle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
        if (okHandle) {
            okHandle();
        }
    }];
    UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnull action) {
    }];
    
    NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc]initWithString:message];
    //[messageAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]range:NSMakeRange(7,5)];
    [messageAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13]range:NSMakeRange(0,messageAttribute.string.length)];
    [alertController setValue:messageAttribute forKey:@"attributedMessage"];
    //3.3修改按钮的颜色
//    [sureAction setValue:ZMLColor(69, 173, 216) forKey:@"titleTextColor"];
    [cancelAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
