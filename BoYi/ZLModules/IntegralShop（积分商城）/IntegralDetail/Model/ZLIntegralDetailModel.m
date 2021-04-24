//
//  ZLIntegralDetailModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLIntegralDetailModel.h"

@implementation ZLIntegralDetailModel

#pragma mark - 积分明细
+ (void)integralDetailWithInfoModel:(ZLIntegralDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"p"] = @(infoModel.page);
    dictM[@"rows"] = @(infoModel.count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/integraldetail" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self integralDetailModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 积分明细
+ (void)integralDetailModelWithInfoModel:(ZLIntegralDetailModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSArray *dataArray = dataDict[@"data"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                if (dataArray.count) {
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < dataArray.count; index++) {
                        ZLIntegralDetailModel *model = [self new];
                        NSDictionary *dict = dataArray[index];
                        model.title = dict[@"title"];
                        model.time = dict[@"huodeshijian"];
                        NSInteger type = [dict[@"type"] integerValue];
                        NSString *string = type == 1 ? @"+" : @"-";
                        model.integral = [NSString stringWithFormat:@"%@%@",string,dict[@"jifen"]];
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
