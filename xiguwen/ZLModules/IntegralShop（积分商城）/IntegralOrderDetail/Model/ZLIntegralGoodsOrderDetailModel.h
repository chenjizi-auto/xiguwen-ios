//
//  ZLIntegralGoodsOrderDetailModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, ZLIntegralGoodsOrderDetailType) {
    ///待付款
    ZLIntegralGoodsOrderDetailTypeWaitingPay = 1,
    ///待发货
    ZLIntegralGoodsOrderDetailTypeWaitingSend,
    ///待收货
    ZLIntegralGoodsOrderDetailTypeWaitingReceive,
    ///交易成功
    ZLIntegralGoodsOrderDetailTypeDealSuccessful,
    ///交易关闭
    ZLIntegralGoodsOrderDetailTypeDealShut,
};

@interface ZLIntegralGoodsOrderDetailModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///下文主键
@property (nonatomic,strong) NSString *keyId;

///订单状态
@property (nonatomic,unsafe_unretained) ZLIntegralGoodsOrderDetailType orderState;
///订单倒计时
@property (nonatomic,unsafe_unretained) int orderCountdown;
///收货人姓名
@property (nonatomic,strong) NSString *name;
///收货人电话
@property (nonatomic,strong) NSString *phone;
///收货地址
@property (nonatomic,strong) NSString *address;
///收货地址高度
@property (nonatomic,unsafe_unretained) CGFloat addressHeight;
///实际支付金额
@property (nonatomic,strong) NSString *payPrice;
///订单编号
@property (nonatomic,strong) NSString *orderNumber;
///下单时间
@property (nonatomic,strong) NSString *orderTime;
///付款时间
@property (nonatomic,strong) NSString *payTime;

///单元模型
@property (nonatomic,strong) NSArray <ZLIntegralGoodsOrderDetailModel *>*unitModels;
///商品名称
@property (nonatomic,strong) NSString *goodsName;
///商品名称高度
@property (nonatomic,unsafe_unretained) CGFloat goodsNameHeight;
///商品价格
@property (nonatomic,strong) NSString *goodsPrice;
///商品图片地址
@property (nonatomic,strong) NSString *goodsUrl;
///数量
@property (nonatomic,strong) NSString *number;

///支付密码
@property (nonatomic,strong) NSString *password;

///确认订单
+ (void)sureOrderWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///支付积分订单
+ (void)payOrderWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///取消订单
+ (void)cancelOrderWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///订单详情
+ (void)integralGoodsOrderDetailWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
