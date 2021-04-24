//
//  ZLRedPacketGoodsListModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/26.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsListModel.h"

@implementation ZLRedPacketGoodsListModel

#pragma mark - 红包商品
+ (void)redPacketGoodsListWithInfoModel:(ZLRedPacketGoodsListModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"p"] = @(infoModel.page);
    dictM[@"rows"] = @(infoModel.count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/chakanhongbao" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self redPacketGoodsListModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 红包商品
+ (void)redPacketGoodsListModelWithInfoModel:(ZLRedPacketGoodsListModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSArray *dataArray = dataDict[@"data"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                if (dataArray.count) {
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < dataArray.count; index++) {
                        ZLRedPacketGoodsListModel *model = [self new];
                        NSDictionary *dict = dataArray[index];
                        model.title = dict[@"name"];
                        model.imageUrl = dict[@"img"];
                        model.keyId = dict[@"id"];
                        model.integral = [NSString stringWithFormat:@"%@",dict[@"xuyaojifen"]];
                        [arrayM addObject:model];
                    }
                    if (arrayM.count < infoModel.count) {
                        infoModel.showNoMore = YES;
                    }
                    if (infoModel.page == 1) {
                        infoModel.unitModels = arrayM;
                    }else {
                        [(NSMutableArray *)infoModel.unitModels addObjectsFromArray:arrayM];
                    }
                    return;
                }
                if (infoModel.page != 1) {
                    infoModel.showNoMore = YES;
                }
            }
        }
    }
}

@end
