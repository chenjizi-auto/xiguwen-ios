//
//  ZLHUD.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/8/22.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "MBProgressHUD.h"

@interface ZLHUD : MBProgressHUD

/**开启一个HUD
 *@param view 添加到指定的视图上
 */
+ (instancetype)showHUDWithSuperView:(UIView *)view;

/**改变显示中的HUD文字
 *@param hud 当前的HUD
 *@param text 提示文字
 *@param complete 文字消失后的处理
 */
+ (void)changeTextHUD:(ZLHUD *)hud Text:(NSString *)text Delay:(void (^)(void))complete;

/**隐藏HUD
 *@param hud 当前的HUD
 */
+ (void)HideHUD:(ZLHUD *)hud;

/**临时在window上开启HUD
 *@param text 提示文字
 */
+ (void)showWindowHUDWithText:(NSString *)text;

/**弹窗
 *@param delegate 代理
 *@param string 内容信息
 *@param complete 点击确定后的事件
 */
+ (void)presentViewControllerWithDelegate:(UIViewController *)delegate Message:(NSString *)string Results:(void (^)(BOOL cancel))complete;

@end
