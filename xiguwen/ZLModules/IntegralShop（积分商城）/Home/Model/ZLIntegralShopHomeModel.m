//
//  ZLIntegralShopHomeModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLIntegralShopHomeModel.h"
#import "ZLIntegralShopIntegralGoodsUnitModel.h"
#import "ZLIntegralShopRedPacketGoodsUnitModel.h"
#import "ZLIntegralShopBannerUnitModel.h"

@implementation ZLIntegralShopHomeModel

#pragma mark - 签到
+ (void)signWithInfoModel:(ZLIntegralShopHomeModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, ZLIntegralShopHomeModel *signModel))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/signin" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            complete(sessionErrorState,[self signResultsWithResponseObject:responseObject]);
            return;
        }
        complete(sessionErrorState,nil);
    }];
}

#pragma mark - 积分商城首页数据
+ (void)integralShopHomeWithInfoModel:(ZLIntegralShopHomeModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/integralindex" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self integralShopHomeModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 首页数据
+ (void)integralShopHomeModelWithInfoModel:(ZLIntegralShopHomeModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            infoModel.signState = [dataDict[@"shifouqiandao"] boolValue];
            infoModel.ongoingSignDayNumber = [NSString stringWithFormat:@"已连续签到%@天",dataDict[@"lianxutianshu"]];
            infoModel.currentTotalIntegral = [NSString stringWithFormat:@"%@",dataDict[@"jifen"]];
            infoModel.currentConversionTotalNumber = [NSString stringWithFormat:@"%@",dataDict[@"duihuanjilushu"]];
            //轮播
            [ZLIntegralShopBannerUnitModel integralShopBannerUnitModelWithArray:dataDict[@"ganggao"] Model:infoModel];
            
            NSMutableArray *sectionModels = [NSMutableArray new];
            //积分商品
            NSArray *goodsModels = [ZLIntegralShopIntegralGoodsUnitModel integralShopIntegralGoodsUnitModelWithArray:dataDict[@"shop"]];
            if ([goodsModels isKindOfClass:[NSArray class]]) {
                ZLIntegralShopHomeModel *goodsModel = [self new];
                goodsModel.sectionTitle = @"热兑商品";
                goodsModel.unitModels = goodsModels;
                [sectionModels addObject:goodsModel];
            }
            //红包商品
            NSArray *redPacketModels = [ZLIntegralShopRedPacketGoodsUnitModel integralShopRedPacketGoodsUnitModelWithArray:dataDict[@"hongbao"]];
            if ([redPacketModels isKindOfClass:[NSArray class]]) {
                ZLIntegralShopHomeModel *redPacketModel = [self new];
                redPacketModel.sectionTitle = @"兑换红包";
                redPacketModel.unitModels = redPacketModels;
                [sectionModels addObject:redPacketModel];
            }
            if (sectionModels.count) {
                infoModel.unitModels = sectionModels;
            }
        }
    }
}

#pragma mark - 解析 - 签到数据
+ (instancetype)signResultsWithResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            ZLIntegralShopHomeModel *model = [self new];
            model.ongoingSignDayNumber = [NSString stringWithFormat:@"%@",dataDict[@"lianxutianshu"]];
            model.todayObtainIntegralNumber = [NSString stringWithFormat:@"%@",dataDict[@"huodejifen"]];
            NSArray *array = dataDict[@"jifen"];
            if ([array isKindOfClass:[NSArray class]]) {
                if (array.count) {
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < array.count; index++) {
                        NSString *integrals = [NSString stringWithFormat:@"%@积分",array[index]];
                        [arrayM addObject:integrals];
                    }
                    model.ongoingSignIntegralsArray = arrayM;
                }
            }
            return model;
        }
    }
    return nil;
}

@end
