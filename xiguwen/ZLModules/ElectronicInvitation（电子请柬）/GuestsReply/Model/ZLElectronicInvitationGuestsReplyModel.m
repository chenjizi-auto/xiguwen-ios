//
//  ZLElectronicInvitationGuestsReplyModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationGuestsReplyModel.h"

@implementation ZLElectronicInvitationGuestsReplyModel

#pragma mark - 删除数据
+ (void)dleteDataWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.willDeleteModel.keyId;
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/invitation/delzhufu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] integerValue]) {
                //删除缓存数据
                NSMutableArray *arrayM = (NSMutableArray *)infoModel.sectionModels[infoModel.currentSection].unitModels;
                for (NSInteger index = 0; index < arrayM.count; index++) {
                    if (infoModel.willDeleteModel == arrayM[index]) {
                        [arrayM removeObjectAtIndex:index];
                        break;
                    }
                }
                //处理下文
                complete(sessionErrorState, nil);
                return ;
            }
            //处理下文
            complete(sessionErrorState, responseObject[@"message"]);
            return;
        }
        complete(sessionErrorState, @"删除失败！");
    }];
}

#pragma mark - 宾客回复数据
+ (void)guestsReplyDataWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    !infoModel.sectionModels.count
    //请求模板数据
    ? [self guestsReplyTypeDataWithInfoModel:infoModel Results:complete]
    //请求请柬数据
    : [self guestsReplyUnitDataWithInfoModel:infoModel Results:complete];
}

#pragma mark - 类型数据
+ (void)guestsReplyTypeDataWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableArray *arrayM = [NSMutableArray new];
    NSArray *titles = @[@"祝福",@"赴宴",@"待定"];
    NSArray *keyIds = @[@(ZLInvitationGuestsReplyTypeBless),@(ZLInvitationGuestsReplyTypeGoToDinner),@(ZLInvitationGuestsReplyTypeWaitSure)];
    for (NSInteger index = 0; index < keyIds.count; index++) {
        ZLElectronicInvitationGuestsReplyModel *sectionModel = [self new];
        sectionModel.title = titles[index];
        sectionModel.keyId = [NSString stringWithFormat:@"%ld",[keyIds[index] integerValue] + 1];
        sectionModel.page = 1;
        sectionModel.count = 8;
        [arrayM addObject:sectionModel];
    }
    infoModel.sectionModels = arrayM;
    //请求首个模板的数据
    [self guestsReplyUnitDataWithInfoModel:infoModel Results:complete];
}

#pragma mark - 宾客回复数据
+ (void)guestsReplyUnitDataWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"type"] = infoModel.sectionModels[infoModel.currentSection].keyId;
    dictM[@"id"] = infoModel.keyId;
    dictM[@"p"] = @(infoModel.sectionModels[infoModel.currentSection].page);
    dictM[@"rows"] = @(infoModel.sectionModels[infoModel.currentSection].count);
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/invitation/zhufu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self guestsReplyModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 选择模板数据解析
+ (void)guestsReplyModelWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSArray *dataArray = responseObject[@"data"];
    infoModel.sectionModels[infoModel.currentSection].dataArrive = YES;
    if ([dataArray isKindOfClass:[NSDictionary class]]) {
        dataArray = ((NSDictionary *)dataArray)[@"info"];
    }
    if ([dataArray isKindOfClass:[NSArray class]]) {
        ZLElectronicInvitationGuestsReplyModel *sectionModel = infoModel.sectionModels[infoModel.currentSection];
        if (dataArray.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < dataArray.count; index++) {
                ZLElectronicInvitationGuestsReplyModel *model = [self new];
                NSDictionary *dict = dataArray[index];
                model.title = dict[@"name"];
                model.time = dict[@"createti"];
                if (infoModel.currentSection == ZLInvitationGuestsReplyTypeBless) {
                    model.content = dict[@"cont"];
                    CGFloat height = [model.content boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
                    model.contentHeight = height > 20.0 ? height : 20.0;
                    model.cellHeight = model.contentHeight + 60.0;
                }else if (infoModel.currentSection == ZLInvitationGuestsReplyTypeGoToDinner) {
                    model.content = dict[@"telephone"];
                    model.value = [dict[@"cont"] integerValue];
                    model.cellHeight = 80.0;
                }else if (infoModel.currentSection == ZLInvitationGuestsReplyTypeWaitSure) {
                    model.content = dict[@"telephone"];
                    model.cellHeight = 80.0;
                }
                model.titleWidth = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size.width;
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
