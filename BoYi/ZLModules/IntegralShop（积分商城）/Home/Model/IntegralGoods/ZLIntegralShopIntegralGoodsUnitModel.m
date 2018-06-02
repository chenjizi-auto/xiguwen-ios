//
//  ZLIntegralShopIntegralGoodsUnitModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopIntegralGoodsUnitModel.h"

@implementation ZLIntegralShopIntegralGoodsUnitModel

///积分商品解析
+ (NSMutableArray *)integralShopIntegralGoodsUnitModelWithArray:(NSArray *)array {
    NSArray *integralGoods = array;
    if ([integralGoods isKindOfClass:[NSArray class]]) {
        if (integralGoods.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < integralGoods.count; index++) {
                NSDictionary *unitDict = integralGoods[index];
                ZLIntegralShopHomeModel *unitModel = [self new];
                unitModel.keyId = unitDict[@"id"];
                NSString *integral = unitDict[@"jifen"];
                NSString *money = unitDict[@"jiage"];
                integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@,%@",integral,money] : [NSString stringWithFormat:@"%@",integral];
                unitModel.goodsPrice = integral;
                unitModel.goodsUrl = unitDict[@"tupian"];
                unitModel.goodsName = unitDict[@"name"];
                unitModel.goodsType = ZLIntegralShopHomeGoodsTypeGoods;
                [arrayM addObject:unitModel];
            }
            return arrayM;
        }
    }
    return nil;
}

@end
