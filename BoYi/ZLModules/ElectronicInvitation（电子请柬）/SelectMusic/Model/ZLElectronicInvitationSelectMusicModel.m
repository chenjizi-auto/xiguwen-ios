//
//  ZLElectronicInvitationSelectMusicModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectMusicModel.h"

@implementation ZLElectronicInvitationSelectMusicModel

#pragma mark - 保存音乐数据
+ (void)saveMusicDataWithInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"mid"] = infoModel.keyId;
    dictM[@"yid"] = infoModel.currenMusicModel.keyId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/Invitation/setinvitationsyinyue" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] intValue]) {
                complete(sessionErrorState,responseObject[@"message"]);
                return ;
            }
            complete(sessionErrorState,nil);
            return ;
        }
        complete(sessionErrorState,@"保存失败！");
    }];
}

#pragma mark - 选择音乐数据
+ (void)selectMusicDataWithInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    !infoModel.sectionModels.count
    //请求音乐类型数据
    ? [self musicTypeDataWithInfoModel:infoModel Results:complete]
    //请求音乐数据
    : [self musicDataWithInfoModel:infoModel Results:complete];
}

#pragma mark - 音乐类型数据
+ (void)musicTypeDataWithInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/invitation/invitationsyinyuett" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self musicTypeModelWithInfoModel:infoModel ResponseObject:responseObject];
            //请求首个音乐类型的数据
            [self musicDataWithInfoModel:infoModel Results:complete];
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 音乐数据
+ (void)musicDataWithInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    if (infoModel.sectionModels[infoModel.currentSection].keyId.intValue) {
        dictM[@"tid"] = infoModel.sectionModels[infoModel.currentSection].keyId;
    }
    dictM[@"p"] = @(infoModel.sectionModels[infoModel.currentSection].page);
    dictM[@"rows"] = @(infoModel.sectionModels[infoModel.currentSection].count);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/invitation/invitationsyinyue" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self selectMusicModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 音乐类型解析
+ (void)musicTypeModelWithInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSArray *dataArray = responseObject[@"data"];
    if ([dataArray isKindOfClass:[NSArray class]]) {
        if (dataArray.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            ZLElectronicInvitationSelectMusicModel *sectionModel = [self new];
            sectionModel.title = @"全部";
            sectionModel.keyId = @"0";
            sectionModel.page = 1;
            sectionModel.count = 14;
            [arrayM addObject:sectionModel];
            for (NSInteger index = 0; index < dataArray.count; index++) {
                ZLElectronicInvitationSelectMusicModel *sectionModel = [self new];
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

#pragma mark - 选择音乐数据解析
+ (void)selectMusicModelWithInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSArray *dataArray = responseObject[@"data"][@"data"];
    infoModel.sectionModels[infoModel.currentSection].dataArrive = YES;
    if ([dataArray isKindOfClass:[NSArray class]]) {
        ZLElectronicInvitationSelectMusicModel *sectionModel = infoModel.sectionModels[infoModel.currentSection];
        if (dataArray.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < dataArray.count; index++) {
                ZLElectronicInvitationSelectMusicModel *model = [self new];
                NSDictionary *dict = dataArray[index];
                model.musicUrl = dict[@"url"];
                model.title = dict[@"titile"];
                model.keyId = dict[@"id"];
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

@end
