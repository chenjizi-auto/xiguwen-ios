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
                NSString *src = @"https://www.jianshu.com/p/da4e8fe1cd84?utm_campaign=hugo&utm_medium=reader_share&utm_content=note&utm_source=qq";//[NSString stringWithFormat:@"%@",unitDict[@"src"]];
                unitModel.bannerSrc = src.length ? src : nil;
                NSInteger type = [unitDict[@"aptype"] integerValue];
                if (type == 1) {
                    unitModel.bannerType = ZLIntegralShopHomeBannerTypeWeddingBossPage;
                }else if (type == 2) {
                    unitModel.bannerType = ZLIntegralShopHomeBannerTypeShopBossPage;
                }else if (type == 3) {
                    unitModel.bannerType = ZLIntegralShopHomeBannerTypeExample;
                }else if (type == 5) {
                    unitModel.bannerType = ZLIntegralShopHomeBannerTypeGoods;
                }else if (type == 6) {
                    unitModel.bannerType = ZLIntegralShopHomeBannerTypePrice;
                }
                [bannerModels addObject:unitModel];
                [bannerUrls addObject:unitModel.goodsUrl];
            }
            model.bannerModelsArray = bannerModels;
            model.bannerUrlsArray = bannerUrls;
        }
    }
}

@end
