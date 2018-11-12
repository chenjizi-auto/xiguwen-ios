//
//  ZLIntegralShopHomeTableHeaderFunctionBar.h
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopHomeTableHeaderFunctionBar : UIView

///子标题值
@property (nonatomic,strong) NSArray *subTitlesArray;
///标题值
@property (nonatomic,strong) NSArray *titlesArray;
///我的积分、兑换记录
@property (nonatomic,copy) void (^function)(BOOL isIntegral);

///展示加分动画
- (void)showAnimationLabelWithTodayObtainIntegralNumber:(NSString *)number;

@end
