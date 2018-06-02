//
//  ZLRedPacketGoodsDetailModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsDetailModel.h"

@implementation ZLRedPacketGoodsDetailModel

#pragma mark - 红包商品详情
+ (void)redPacketGoodsDetailWithInfoModel:(ZLRedPacketGoodsDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/hongbaoxiangqing" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self redPacketGoodsDetailModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

+ (void)aaa {
    //appapi/integral/hongbaoduihuan
    //token userid  pwd id
}

#pragma mark - 解析 - 红包商品详情
+ (void)redPacketGoodsDetailModelWithInfoModel:(ZLRedPacketGoodsDetailModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSDictionary *dict = dataDict[@"data"];
            ZLRedPacketGoodsDetailModel *basicDetailModel = nil;
            if ([dict isKindOfClass:[NSDictionary class]]) {
                if (dict.count) {
                    basicDetailModel = [self new];
                    basicDetailModel.cellType = ZLRedPacketGoodsDetailCellTypeBasicDetail;
                    ZLRedPacketGoodsDetailModel *rowModel = [self new];
                    NSMutableArray *arrayM = [NSMutableArray new];
                    rowModel.title = dict[@"name"];
                    CGFloat height = [rowModel.title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size.height;
                    height = height > 20.0 ? height : 20.0;
                    rowModel.titleHeight = height;
                    basicDetailModel.cellHeight = UIScreen.mainScreen.bounds.size.width + height + 70.0;
                    rowModel.integral = [NSString stringWithFormat:@"%@积分",dict[@"xuyaojifen"]];
                    rowModel.number = [NSString stringWithFormat:@"已兑换%@单",dict[@"lingqunum"]];
                    rowModel.imageUrl = dict[@"img"];
                    [arrayM addObject:rowModel];
                    basicDetailModel.unitModels = arrayM;
                }
            }
            //猜你喜欢
            ZLRedPacketGoodsDetailModel *guessYouLikeModel = nil;
            NSArray *array = dataDict[@"youlike"];
            if ([array isKindOfClass:[NSArray class]]) {
                if (array.count) {
                    NSMutableArray  *arrayM = [NSMutableArray new];
                    guessYouLikeModel = [self new];
                    guessYouLikeModel.cellType = ZLRedPacketGoodsDetailCellTypeGuessYouLike;
                    guessYouLikeModel.cellHeight = (UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 76.0;
                    guessYouLikeModel.title = @"猜你喜欢";
                    for (NSInteger index = 0; index < array.count; index++) {
                        ZLRedPacketGoodsDetailModel *rowModel = [self new];
                        NSDictionary *unitDict = array[index];
                        rowModel.imageUrl = unitDict[@"img"];
                        rowModel.keyId = unitDict[@"id"];
                        rowModel.title = unitDict[@"name"];
                        rowModel.number = [NSString stringWithFormat:@"已兑%@",unitDict[@"lingqunum"]];
                        rowModel.integral = [NSString stringWithFormat:@"%@积分",unitDict[@"xuyaojifen"]];
                        [arrayM addObject:rowModel];
                    }
                    guessYouLikeModel.unitModels = arrayM;
                }
            }
            if (basicDetailModel || guessYouLikeModel) {
                infoModel.unitModels = [NSMutableArray new];
            }
            if ([infoModel.unitModels isKindOfClass:[NSArray class]]) {
                [((NSMutableArray *)infoModel.unitModels) addObject:basicDetailModel];
                [((NSMutableArray *)infoModel.unitModels) addObject:guessYouLikeModel];
            }
        }
    }
}

@end
