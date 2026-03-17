//
//  ZLConversionDetailModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLConversionDetailModel.h"
#import "ZLConversionDetailGoodsModel.h"
#import "ZLConversionDetailRedPacketModel.h"

@implementation ZLConversionDetailModel

#pragma mark - 兑换详情
+ (void)conversionDetailWithInfoModel:(ZLConversionDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"type"] = @(infoModel.conversionType);
    dictM[@"userid"] = infoModel.userId;
    ZLConversionDetailModel *model = infoModel.conversionType == ZLConversionTypeGoods
                                   ? infoModel.goodsModel
                                   : infoModel.redPacketModel;
    dictM[@"p"] = @(model.page);
    dictM[@"rows"] = @(infoModel.count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/duihuanjilu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self conversionDetailModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 兑换详情
+ (void)conversionDetailModelWithInfoModel:(ZLConversionDetailModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            infoModel.conversionType == ZLConversionTypeGoods
            //商品兑换
            ? [self neatenGoodsModelDataWithInfoModel:infoModel Response:dataDict[@"data"]]
            //红包兑换
            : [self neatenRedPacketModelDataWithInfoModel:infoModel Response:dataDict[@"data"]];
        }
    }
}

#pragma mark - 整理 - 商品兑换模型
+ (void)neatenGoodsModelDataWithInfoModel:(ZLConversionDetailModel *)infoModel Response:(NSArray *)response {
    ZLConversionDetailModel *model = infoModel.conversionType == ZLConversionTypeGoods
    ? infoModel.goodsModel
    : infoModel.redPacketModel;
    NSArray *goodsArray = [ZLConversionDetailGoodsModel conversionDetailGoodsModelWithArray:response];
    if (goodsArray) {
        if (goodsArray.count < infoModel.count) {
            model.showNoMore = YES;
        }
        if (model.page == 1) {
            //下拉刷新
            infoModel.goodsModel.goodsModelsArray = goodsArray;
        }else {
            //上拉加载
            [(NSMutableArray *)infoModel.goodsModel.goodsModelsArray addObjectsFromArray:goodsArray];
        }
        return;
    }
    //没有更多
    if (model.page != 1) {
        model.showNoMore = YES;
    }
}

#pragma mark - 整理 - 红包兑换模型
+ (void)neatenRedPacketModelDataWithInfoModel:(ZLConversionDetailModel *)infoModel Response:(NSArray *)response {
    NSArray *redPacketArray = [ZLConversionDetailRedPacketModel conversionDetailRedPacketModelWithArray:response];
    ZLConversionDetailModel *model = infoModel.conversionType == ZLConversionTypeGoods
                                    ? infoModel.goodsModel
                                    : infoModel.redPacketModel;
    if (redPacketArray.count < infoModel.count) {
        model.showNoMore = YES;
    }
    if (redPacketArray) {
        if (model.page == 1) {
            //下拉刷新
            infoModel.redPacketModel.redPacketModelsArray = redPacketArray;
        }else {
            //上拉加载
            [(NSMutableArray *)infoModel.redPacketModel.redPacketModelsArray addObjectsFromArray:redPacketArray];
        }
        return;
    }
    //没有更多
    if (model.page != 1) {
        model.showNoMore = YES;
    }
}

@end
