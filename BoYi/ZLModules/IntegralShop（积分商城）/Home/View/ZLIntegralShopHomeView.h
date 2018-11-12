//
//  ZLIntegralShopHomeView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralShopHomeModel.h"

@interface ZLIntegralShopHomeView : UIView

///首页数据
@property (nonatomic,weak) ZLIntegralShopHomeModel *shopHomeModel;
///签到数据
@property (nonatomic,weak) ZLIntegralShopHomeModel *signModel;

///改变导航按钮的颜色
@property (nonatomic,copy) void (^changeNavItemColor)(CGFloat alpha);
///我的积分、兑换记录
@property (nonatomic,copy) void (^function)(BOOL isIntegral);
///查看详情
@property (nonatomic,copy) void (^lookDetail)(ZLIntegralShopHomeModel *model);
///区头 - 查看全部
@property (nonatomic,copy) void (^lookAll)(NSInteger index);
///签到
@property (nonatomic,copy) void (^sign)(void);
///轮播
@property (nonatomic,copy) void (^bannerClick)(ZLIntegralShopHomeModel *model);

///释放定时器
- (void)removeTimer;
///重新启动
- (void)startTimer;
///暂停
- (void)stopTimer;

@end
