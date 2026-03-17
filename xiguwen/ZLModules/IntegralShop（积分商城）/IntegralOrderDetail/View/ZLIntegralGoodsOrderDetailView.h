//
//  ZLIntegralGoodsOrderDetailView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsOrderDetailModel.h"

typedef NS_ENUM(NSInteger, ZLIntegralGoodsOrderDetailViewInteractionType) {
    ///取消订单
    ZLIntegralGoodsOrderDetailViewInteractionTypeCancelOrder = 1,
    ///发起支付
    ZLIntegralGoodsOrderDetailViewInteractionTypeGoToPay,
    ///查看物流
    ZLIntegralGoodsOrderDetailViewInteractionTypeLookLogistics,
    ///确认收货
    ZLIntegralGoodsOrderDetailViewInteractionTypeSureReceive,
};

@interface ZLIntegralGoodsOrderDetailView : UIView

///后台错误信息
@property (nonatomic,strong) NSString *errorMessage;
///弱引用数据
@property (nonatomic,weak) ZLIntegralGoodsOrderDetailModel *infoModel;
///查看猜你喜欢详情
@property (nonatomic,copy) void (^lookGuessYouLikeDetail)(ZLIntegralGoodsOrderDetailModel *model);
///操作订单交互
@property (nonatomic,copy) void (^operationOrder)(ZLIntegralGoodsOrderDetailViewInteractionType interactionType);

///停掉定时器
- (void)stopTimer;

@end
