//
//  ZLIntegralGoodsSureOrderModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsSureOrderModel.h"

@implementation ZLIntegralGoodsSureOrderModel

#pragma mark - 提交订单
+ (void)commitOrderWithInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"token"] = infoModel.token;
    dictM[@"liuyan"] = infoModel.LeaveMessage;
    dictM[@"postid"] = infoModel.addressId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/jifendingdanzhifu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] integerValue]) {
                //数据解析
                [self orderModelWithInfoModel:infoModel ResponseObject:responseObject];
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

#pragma mark - 确认订单
+ (void)integralGoodsSureOrderWithInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"token"] = infoModel.token;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/qurendingdandizhi" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self integralGoodsSureOrderModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 提交订单
+ (void)orderModelWithInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            infoModel.orderNumber = dataDict[@"ordersn"];
        }
    }
}

#pragma mark - 解析 - 确认订单
+ (void)integralGoodsSureOrderModelWithInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            infoModel.shopName = dataDict[@"shangjianame"];
            infoModel.goodsImageUrl = dataDict[@"tupian"];
            infoModel.goodsName = dataDict[@"name"];
            NSString *addressId =  dataDict[@"shouhuoid"];
            infoModel.addressId = addressId.length ? addressId : nil;
            NSString *name = dataDict[@"shouhuoming"];
            infoModel.name = name.length ? name : @"请选择收货地址";
            infoModel.phone = dataDict[@"shouhuodianhua"];
            NSString *address =  dataDict[@"shouhuodizhi"];
            infoModel.address = address.length ? address : @"请选择收货地址";
            CGFloat height = [infoModel.address boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 100.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
            infoModel.addressHeight = height > 20.0 ? height : 20.0;
            height = [infoModel.goodsName boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
            height = height > 20.0 ? height : 20.0;
            infoModel.goodsNameHeight =  height > 55.0 ? 55.0 : height;
            infoModel.goodsNumber = @"X 1";
            NSString *integral = dataDict[@"jifen"];
            NSString *money = dataDict[@"jiage"];
            integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@积分+%@元",integral,money] : [NSString stringWithFormat:@"%@积分",integral];
            infoModel.goodsPrice = integral;
        }
    }
}

@end
