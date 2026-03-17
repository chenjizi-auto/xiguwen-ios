//
//  ZLIntegralShopBannerUnitModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/27.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopBannerUnitModel.h"

@implementation ZLIntegralShopBannerUnitModel

///积分商品解析
+ (void)integralShopBannerUnitModelWithArray:(NSArray *)array Model:(ZLIntegralShopHomeModel *)model {
    NSArray *integralGoods = array;
    if ([integralGoods isKindOfClass:[NSArray class]]) {
        if (integralGoods.count) {
            NSMutableArray *bannerModels = [NSMutableArray new];
            NSMutableArray *bannerUrls = [NSMutableArray new];
            for (NSInteger index = 0; index < integralGoods.count; index++) {
                NSDictionary *unitDict = integralGoods[index];
                ZLIntegralShopBannerUnitModel *unitModel = [self new];
                unitModel.keyId = unitDict[@"aptid"];
                unitModel.goodsUrl = unitDict[@"wapimg"];
                unitModel.goodsName = unitDict[@"title"];
                unitModel.goodsPrice = unitDict[@"price"];
                NSString *src = [NSString stringWithFormat:@"%@",unitDict[@"src"]];
                unitModel.bannerSrc = src.length ? src : nil;
                NSInteger type = [unitDict[@"aptype"] integerValue];
                unitModel.bannerType = type;
                [bannerModels addObject:unitModel];
                [bannerUrls addObject:unitModel.goodsUrl];
            }
            model.bannerModelsArray = bannerModels;
            model.bannerUrlsArray = bannerUrls;
        }
    }
}

@end
