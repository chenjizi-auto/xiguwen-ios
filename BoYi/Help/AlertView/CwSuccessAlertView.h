//
//  CwSuccessAlertView.h
//  ZeroRead
//
//  Created by Chen on 2017/3/14.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CwSuccessAlertView : UIView
+ (void)showAlertViewWithTitle:(NSString *)title des:(NSString *)des leftBtn:(NSString *)left Success:(void (^)(NSInteger type))success;
@end
