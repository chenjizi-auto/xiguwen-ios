//
//  AlertManger.h
//  DoctorDnd
//
//  Created by MedCare on 2017/3/15.
//  Copyright © 2017年 zengmaolin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  @brief 点击确定按钮回调
 */
typedef void (^AlertViewOkClicked)();
@interface AlertManger : NSObject
+ (void)showSingleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                   okClikedHandle:(AlertViewOkClicked)okHandle;
+ (void)showwSingleAlertWithTitle:(NSString *)title
                          message:(NSString *)message
                   okClikedHandle:(AlertViewOkClicked)okHandle;
@end
