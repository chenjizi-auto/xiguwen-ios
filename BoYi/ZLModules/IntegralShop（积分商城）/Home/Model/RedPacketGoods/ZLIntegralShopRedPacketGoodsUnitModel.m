//
//  ZLIntegralShopRedPacketGoodsUnitModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopRedPacketGoodsUnitModel.h"

@implementation ZLIntegralShopRedPacketGoodsUnitModel

///红包商品解析
+ (NSArray *)integralShopRedPacketGoodsUnitModelWithArray:(NSArray *)array {
    NSArray *redPacketGoods = array;
    if ([redPacketGoods isKindOfClass:[NSArray class]]) {
        if (redPacketGoods.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < redPacketGoods.count; index++) {
                NSDictionary *unitDict = redPacketGoods[index];
                ZLIntegralShopHomeModel *unitModel = [self new];
                unitModel.keyId = unitDict[@"id"];
                unitModel.goodsPrice = [NSString stringWithFormat:@"%@",unitDict[@"xuyaojifen"]];
                unitModel.goodsUrl = unitDict[@"img"];
                unitModel.goodsName = unitDict[@"name"];
                unitModel.goodsType = ZLIntegralShopHomeGoodsTypeRedPacket;
                [arrayM addObject:unitModel];
            }
            return arrayM;
        }
    }
    return nil;
}

@end
