//
//  ZLIntegralShopHomeTableHeaderView.h
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopHomeTableHeaderView : UIView

///轮播地址
@property (nonatomic,strong) NSArray *bannerUrlsArray;
///控制交互
@property (nonatomic,unsafe_unretained,getter=isAllowInteraction) BOOL allowInteraction;
///签到状态
@property (nonatomic,unsafe_unretained) BOOL signState;
///连续签到天数
@property (nonatomic,strong) NSString *title;
///数值(object1:我的积分   object2:兑换记录)
@property (nonatomic,strong) NSArray *numbersArray;
///我的积分、兑换记录
@property (nonatomic,copy) void (^function)(BOOL isIntegral);
///签到
@property (nonatomic,copy) void (^sign)(void);
///轮播
@property (nonatomic,copy) void (^bannerClick)(NSInteger index);


///释放定时器
- (void)removeTimer;
///重新启动
- (void)startTimer;
///暂停
- (void)stopTimer;
///图片缩放
- (void)imageZoomWithOffsetY:(CGFloat)offsetY;
///展示加分动画
- (void)showAnimationLabelWithTodayObtainIntegralNumber:(NSString *)number;

@end
