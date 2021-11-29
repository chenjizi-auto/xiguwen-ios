//
//  baojiaShopCar_New.h
//  BoYi
//
//  Created by itzhaolei on 2021/11/27.
//  Copyright © 2021 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface baojiaShopCar_New : UIScrollView

/// 展示下单选择
/// @param view 展示在哪个视图上
/// @param dic 外界带进来的参数
/// @param userid 用户标识
/// @param block 回执
+ (void)showInView:(UIView *)view dic:(NSMutableDictionary *)dic userid:(NSString *)userid block:(void(^)(NSDictionary *dic))block;

@end

NS_ASSUME_NONNULL_END
