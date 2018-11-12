//
//  ZLIntegralGoodsOrderDetailModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailModel.h"

@implementation ZLIntegralGoodsOrderDetailModel

#pragma mark - 确认订单
+ (void)sureOrderWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"token"] = infoModel.token;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/confirmreceipt" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] integerValue]) {
                //处理下文
                complete(sessionErrorState,nil);
                return;
            }
            //处理下文
            complete(sessionErrorState,responseObject[@"message"]);
            return;
        }
        complete(sessionErrorState,nil);
    }];
}

#pragma mark - 支付积分订单
+ (void)payOrderWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"ordersn"] = infoModel.orderNumber;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"token"] = infoModel.token;
    dictM[@"pwd"] = infoModel.password;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/danjifenzhifu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] integerValue]) {
                //处理下文
                complete(sessionErrorState,nil);
                return;
            }
            //处理下文
            complete(sessionErrorState,responseObject[@"message"]);
            return;
        }
        complete(sessionErrorState,nil);
    }];
}

#pragma mark - 取消订单
+ (void)cancelOrderWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"token"] = infoModel.token;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/quxiaodingdan" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] integerValue]) {
                //处理下文
                complete(sessionErrorState,nil);
                return;
            }
            //处理下文
            complete(sessionErrorState,responseObject[@"message"]);
            return;
        }
        complete(sessionErrorState,nil);
    }];
}

#pragma mark - 订单详情
+ (void)integralGoodsOrderDetailWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"token"] = infoModel.token;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/jifendingdanxq" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self integralGoodsOrderDetailModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 确认订单
+ (void)integralGoodsOrderDetailModelWithInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            
            //基本信息
            NSDictionary *dict = dataDict[@"data"];
            if ([dataDict isKindOfClass:[NSDictionary class]]) {
                if (dataDict.count) {
                    infoModel.orderState = [dict[@"status"] integerValue];
                    infoModel.orderCountdown = [dict[@"fukuantime"] intValue];
                    infoModel.name = dict[@"postname"];
                    infoModel.phone = dict[@"postmobile"];
                    infoModel.address = dict[@"postaddress"];
                    CGFloat height = [infoModel.address boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 65.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
                    height = height > 20.0 ? height : 20.0;
                    infoModel.addressHeight = height;
                    NSString *integral = dict[@"jifen"];
                    NSString *money = dict[@"jine"];
                    integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@积分+%@元",integral,money] : [NSString stringWithFormat:@"%@积分",integral];
                    infoModel.goodsPrice = integral;
                    infoModel.payPrice = dict[@"paidmoney"];
                    infoModel.goodsUrl = dict[@"shop_tupian"];
                    infoModel.goodsUrl = dict[@"shop_tupian"];
                    infoModel.goodsName = dict[@"shop_name"];
                    height = [infoModel.goodsName boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
                    height = height > 20.0 ? height : 20.0;
                    infoModel.goodsNameHeight = height > 55.0 ? 55.0 : height;
                    infoModel.orderNumber = dict[@"order_sn"];
                    infoModel.orderTime = dict[@"paixiashijian"];
                    infoModel.payTime = dict[@"fukuanshijian"];
                }
            }
            
            //猜你喜欢
            NSArray *array = dataDict[@"youlike"];
            if ([array isKindOfClass:[NSArray class]]) {
                if (array.count) {
                    NSMutableArray  *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < array.count; index++) {
                        ZLIntegralGoodsOrderDetailModel *rowModel = [self new];
                        NSDictionary *unitDict = array[index];
                        rowModel.goodsUrl = unitDict[@"tupian"];
                        rowModel.keyId = unitDict[@"id"];
                        rowModel.goodsName = unitDict[@"name"];
                        rowModel.number = [NSString stringWithFormat:@"已兑%@",unitDict[@"yiduinum"]];
                        NSString *integral = unitDict[@"jifen"];
                        NSString *money = unitDict[@"jiage"];
                        integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@积分+%@元",integral,money] : [NSString stringWithFormat:@"%@积分",integral];
                        rowModel.goodsPrice = integral;
                        [arrayM addObject:rowModel];
                    }
                    infoModel.unitModels = arrayM;
                }
            }
        }
    }
}

@end
