//
//  ZLHUD.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/8/22.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLHUD.h"

@implementation ZLHUD

/**开启一个HUD
 *@param view 添加到指定的视图上
 */
+ (instancetype)showHUDWithSuperView:(UIView *)view {
    ZLHUD *hud = [ZLHUD showHUDAddedTo:view animated:YES];
    return hud;
}

/**改变显示中的HUD文字
 *@param hud 当前的HUD
 *@param text 提示文字
 *@param complete 文字消失后的处理
 */
+ (void)changeTextHUD:(ZLHUD *)hud Text:(NSString *)text Delay:(void (^)(void))complete {
    hud.label.text = text;
    hud.mode = MBProgressHUDModeText;
    if (complete) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            complete();
        });
    }
}

/**隐藏HUD
 *@param hud 当前的HUD
 */
+ (void)HideHUD:(ZLHUD *)hud {
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud hideAnimated:YES afterDelay:0];
}

/**临时在window上开启HUD
 *@param text 提示文字
 */
+ (void)showWindowHUDWithText:(NSString *)text {
    ZLHUD *hud = [ZLHUD showHUDWithSuperView:[UIApplication sharedApplication].delegate.window];
    [ZLHUD changeTextHUD:hud Text:text Delay:^{
        [ZLHUD HideHUD:hud];
    }];
}

/**弹窗
 *@param delegate 代理
 *@param string 内容信息
 *@param complete 点击确定后的事件
 */
+ (void)presentViewControllerWithDelegate:(UIViewController *)delegate Message:(NSString *)string Results:(void (^)(BOOL cancel))complete {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        complete(YES);
    }];
    [alert addAction:defaultAction];
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        complete(NO);
    }];
    [alert addAction:defaultAction1];
    [delegate presentViewController:alert animated:YES completion:nil];
}

@end
