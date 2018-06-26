//
//  ZLElectronicInvitationHomeModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationHomeModel.h"

@implementation ZLElectronicInvitationHomeModel

#pragma mark - 电子请柬首页数据
+ (void)electronicInvitationHomeDataWithInfoModel:(ZLElectronicInvitationHomeModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"p"] = @(infoModel.page);
    dictM[@"rows"] = @(infoModel.count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://boyi.qanlian.com/appapi/Invitation/myinvitations" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self electronicInvitationHomeModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 电子请柬首页数据解析
+ (void)electronicInvitationHomeModelWithInfoModel:(ZLElectronicInvitationHomeModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    infoModel.dataArrive = YES;
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSArray *dataArray = dataDict[@"user"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                if (dataArray.count) {
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < dataArray.count; index++) {
                        ZLElectronicInvitationHomeModel *model = [self new];
                        NSDictionary *dict = dataArray[index];
                        model.imageUrl = dict[@"cover"];
                        model.keyId = dict[@"id"];
                        model.sharetime = dict[@"sharetime"];
                        model.shareurl = dict[@"shareurl"];
                        model.htmlUrl = dict[@"url"];
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
                    infoModel.unitModels = [NSMutableArray new];
                }
            }
        }
    }
}

@end
