//
//  ZLIntegralGoodsOrderDetailViewController.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

///入口类型（类型不同，返回的位置不同）
typedef NS_ENUM (NSInteger , ZLOrderDetailInterfaceType){
    ///积分确认订单界面进入
    ZLOrderDetailInterfaceTypeIntegralSureOrder = 1,
    ///收银台界面进入
    ZLOrderDetailInterfaceTypeCheckstandInterface ,
    ///积分订单详情界面进入
    ZLOrderDetailInterfaceTypeIntegralOrderDetail ,
};

@interface ZLIntegralGoodsOrderDetailViewController : UIViewController

///下文主键
@property (nonatomic,strong) NSString *keyId;
///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///支付成功后，返回的时候需要回至商品详情页（不要再展示收银台、确认订单这两个界面）
@property (nonatomic,unsafe_unretained) ZLOrderDetailInterfaceType interfaceType;
///改变【商品兑换列表页】的订单状态
@property (nonatomic,copy) void (^updateOrderState)(NSInteger orderState);

@end
