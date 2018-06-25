//
//  ZLElectronicInvitationSelectTemplateModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectTemplateModel.h"

@implementation ZLElectronicInvitationSelectTemplateModel

#pragma mark - 选择模板数据
+ (void)selectTemplateDataWithInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    !infoModel.sectionModels.count
    //请求模板数据
    ? [self templateTypeDataWithInfoModel:infoModel Results:complete]
    //请求请柬数据
    : [self invitationDataWithInfoModel:infoModel Results:complete];
}

#pragma mark - 模板类型数据
+ (void)templateTypeDataWithInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://boyi.qanlian.com/appapi/invitation/invitationstype" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self templateTypeModelWithInfoModel:infoModel ResponseObject:responseObject];
            //请求首个模板的数据
            [self invitationDataWithInfoModel:infoModel Results:complete];
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 请柬数据
+ (void)invitationDataWithInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"leibieid"] = infoModel.sectionModels[infoModel.currentSection].keyId;
    dictM[@"p"] = @(infoModel.sectionModels[infoModel.currentSection].page);
    dictM[@"rows"] = @(infoModel.sectionModels[infoModel.currentSection].count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://boyi.qanlian.com/appapi/invitation/invitationslist" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self selectTemplateModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 模板类型解析
+ (void)templateTypeModelWithInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSArray *dataArray = responseObject[@"data"];
    if ([dataArray isKindOfClass:[NSArray class]]) {
        if (dataArray.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < dataArray.count; index++) {
                ZLElectronicInvitationSelectTemplateModel *sectionModel = [self new];
                NSDictionary *dict = dataArray[index];
                sectionModel.title = dict[@"title"];
                sectionModel.keyId = dict[@"id"];
                sectionModel.page = 1;
                sectionModel.count = 12;
                [arrayM addObject:sectionModel];
            }
            infoModel.sectionModels = arrayM;
        }
    }
}

#pragma mark - 选择模板数据解析
+ (void)selectTemplateModelWithInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    infoModel.sectionModels[infoModel.currentSection].dataArrive = YES;
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSArray *dataArray = dataDict[@"data"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                ZLElectronicInvitationSelectTemplateModel *sectionModel = infoModel.sectionModels[infoModel.currentSection];
                if (dataArray.count) {
                    NSMutableArray *arrayM = [NSMutableArray new];
                    for (NSInteger index = 0; index < dataArray.count; index++) {
                        ZLElectronicInvitationSelectTemplateModel *model = [self new];
                        NSDictionary *dict = dataArray[index];
                        model.imageUrl = dict[@"cover"];
                        model.keyId = dict[@"id"];
                        model.title = dict[@"title"];
                        model.htmlUrl = dict[@"url"];
                        [arrayM addObject:model];
                    }
                    if (arrayM.count < sectionModel.count) {
                        sectionModel.showNoMore = YES;
                    }
                    if (sectionModel.page == 1) {
                        sectionModel.unitModels = arrayM;
                    }else {
                        [(NSMutableArray *)sectionModel.unitModels addObjectsFromArray:arrayM];
                    }
                    return;
                }
                if (sectionModel.page > 1) {
                    sectionModel.showNoMore = YES;
                }else {
                    sectionModel.showStaticPage = YES;
                }
            }
        }
    }
}

@end
