//
//  ZLIntegralGoodsSureOrderModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

@interface ZLIntegralGoodsSureOrderModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///下文主键
@property (nonatomic,strong) NSString *keyId;

///商家名称
@property (nonatomic,strong) NSString *shopName;
///商品名称
@property (nonatomic,strong) NSString *goodsName;
///商品名称高度
@property (nonatomic,unsafe_unretained) CGFloat goodsNameHeight;
///商品图片
@property (nonatomic,strong) NSString *goodsImageUrl;
///商品价格
@property (nonatomic,strong) NSString *goodsPrice;
///商品数量
@property (nonatomic,strong) NSString *goodsNumber;
///留言
@property (nonatomic,strong) NSString *LeaveMessage;
///收货人姓名
@property (nonatomic,strong) NSString *name;
///收货人电话
@property (nonatomic,strong) NSString *phone;
///详细地址
@property (nonatomic,strong) NSString *address;
///收货地址高度
@property (nonatomic,unsafe_unretained) CGFloat addressHeight;
///详细地址主键
@property (nonatomic,strong) NSString *addressId;

///订单编号
@property (nonatomic,strong) NSString *orderNumber;

///确认订单
+ (void)integralGoodsSureOrderWithInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;
///提交订单
+ (void)commitOrderWithInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

@end
