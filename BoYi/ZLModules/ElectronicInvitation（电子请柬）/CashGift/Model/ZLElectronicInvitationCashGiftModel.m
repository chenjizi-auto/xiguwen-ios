//
//  ZLElectronicInvitationCashGiftModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationCashGiftModel.h"

@implementation ZLElectronicInvitationCashGiftModel

#pragma mark - 礼金数据
+ (void)cashGiftDataWithInfoModel:(ZLElectronicInvitationCashGiftModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"id"] = infoModel.keyId;
    dictM[@"p"] = @(infoModel.page);
    dictM[@"rows"] = @(infoModel.count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/invitation/lijing" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self cashGiftModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 礼金数据解析
+ (void)cashGiftModelWithInfoModel:(ZLElectronicInvitationCashGiftModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            infoModel.amount = dataDict[@"lijinzongshu"];
            NSArray *dataArray = dataDict[@"list"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                if (dataArray.count) {
                    infoModel.showStaticPage = NO;
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < dataArray.count; index++) {
                        ZLElectronicInvitationCashGiftModel *model = [self new];
                        NSDictionary *dict = dataArray[index];
                        model.name = dict[@"name"];
                        model.time = dict[@"paytime"];
                        model.amount = dict[@"lijin"];
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
                }else {
                    infoModel.showStaticPage = YES;
                }
            }
        }
    }
}

@end
