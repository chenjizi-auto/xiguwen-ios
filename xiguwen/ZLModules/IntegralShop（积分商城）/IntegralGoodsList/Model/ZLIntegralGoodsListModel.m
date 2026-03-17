//
//  ZLIntegralGoodsListModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/26.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsListModel.h"

@implementation ZLIntegralGoodsListModel

#pragma mark - 积分商品
+ (void)integralGoodsListWithInfoModel:(ZLIntegralGoodsListModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"p"] = @(infoModel.page);
    dictM[@"rows"] = @(infoModel.count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/seeintegralshop" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self integralGoodsListModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 积分商品
+ (void)integralGoodsListModelWithInfoModel:(ZLIntegralGoodsListModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSArray *dataArray = dataDict[@"data"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                if (dataArray.count) {
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < dataArray.count; index++) {
                        ZLIntegralGoodsListModel *model = [self new];
                        NSDictionary *dict = dataArray[index];
                        model.title = dict[@"name"];
                        model.imageUrl = dict[@"tupian"];
                        model.keyId = dict[@"id"];
                        NSString *integral = dict[@"jifen"];
                        NSString *money = dict[@"jiage"];
                        integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@,%@",integral,money] : [NSString stringWithFormat:@"%@",integral];
                        model.integral = integral;
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
