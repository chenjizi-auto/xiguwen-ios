//
//  ZLElectronicInvitationEditTemplateModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/9.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateModel.h"
#import "ZLElectronicInvitationEditTemplateNeaten.h"
#import "ZLElectronicInvitationEditTemplateTextView.h"
#import <UIButton+AFNetworking.h>

@implementation ZLElectronicInvitationEditTemplateModel

#pragma mark - 删除编辑模块单页数据
+ (void)deleteEditTemplatePageDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    //先删除json里的数据
    NSString *jsonString = [self deleteJsonStringWithInfoModel:infoModel];
    //发送保存的请求
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"umid"] = infoModel.invitationId;
    dictM[@"appdata"] = jsonString;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/Invitation/invitationscreateer" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] intValue]) {
                complete(sessionErrorState,responseObject[@"message"]);
                return ;
            }
            //再删除主数据
            NSMutableArray *sectionArrayM = infoModel.invitationDatas[@"bean"];
            [sectionArrayM removeObjectAtIndex:infoModel.willDeletePageIndex];
            //然后删除控件数据
            NSMutableArray *arrayM = (NSMutableArray *)infoModel.units;
            [arrayM removeObjectAtIndex:infoModel.willDeletePageIndex];
            //处理下文
            complete(sessionErrorState,nil);
            return ;
        }
        complete(sessionErrorState,@"删除失败！");
        return ;
    }];
}

#pragma mark - 删除编辑模块数据
+ (void)deleteEditTemplateDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"id"] = infoModel.invitationId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/Invitation/delinvitations" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] intValue]) {
                complete(sessionErrorState,responseObject[@"message"]);
                return ;
            }
            complete(sessionErrorState,nil);
            return ;
        }
        complete(sessionErrorState,@"删除失败！");
    }];
}

#pragma mark - 修改编辑模块数据
+ (void)changeEditTemplateDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"umid"] = infoModel.invitationId;
    if (!infoModel.currentIndexPath.section) {
        dictM[@"type"] = @(1);
    }
    dictM[@"appdata"] = [self jsonStringWithInfoModel:infoModel];
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/Invitation/invitationscreateer" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] intValue]) {
                complete(sessionErrorState,responseObject[@"message"]);
                return ;
            }
            //刷新界面
            [self changeValueWithInfoModel:infoModel];
            infoModel.invitationDatas = [NSJSONSerialization JSONObjectWithData:[dictM[@"appdata"] dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingMutableContainers) error:nil];
            //处理下文
            complete(sessionErrorState,nil);
            return ;
        }
        complete(sessionErrorState,@"保存失败！");
        return ;
    }];
}

#pragma mark - 查询编辑模块数据
+ (void)editTemplateDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = infoModel.token;
    dictM[@"userid"] = infoModel.userId;
    dictM[@"id"] = infoModel.keyId;
    NSString *path = infoModel.isFromPreviewTemplateEnter
    ? @"appapi/Invitation/invitationscreateyi"
    : @"appapi/invitation/editinvitation";
    [ZLHTTPSessionManager requestDataWithUrlPath:[NSString stringWithFormat:@"http://www.boyihunjia.com/%@",path] Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self editTemplateModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 图片换地址（千牛）
+ (void)imageUrlWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    NSString *dataString = [infoModel.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    dictM[@"img"] = [@"data:image/jpeg;base64," stringByAppendingString:dataString];
    if (!infoModel.currentIndexPath.section) {
        dictM[@"type"] = @(2);
    }else {
        dictM[@"type"] = @(1);
    }
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/System/uploadimgba" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] intValue]) {
                complete(sessionErrorState,responseObject[@"message"]);
                return ;
            }
            infoModel.willChangeValue = responseObject[@"data"];
            complete(sessionErrorState,nil);
            return ;
        }
        complete(sessionErrorState,@"图片上传失败！");
        return ;
    }];
}

#pragma mark - 请柬数据解析
+ (void)editTemplateModelWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if (![dataDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if (!dataDict.count) {
        return;
    }
    infoModel.invitationId = dataDict[@"umid"];
    infoModel.shareurl = dataDict[@"shareurl"];
    infoModel.invitationUrl = dataDict[@"url"];
    NSString *jsonString = dataDict[@"appdata"];
    //解析、整理、规划
    [ZLElectronicInvitationEditTemplateNeaten editTemplateDataWithJsonString:jsonString InfoModel:infoModel];
}

#pragma mark - 将修改的内容进行替换
+ (NSString *)jsonStringWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel {
    NSMutableArray *sectionArrayM = infoModel.invitationDatas[@"bean"];
    NSMutableDictionary *sectionDictM = sectionArrayM[infoModel.currentIndexPath.section];
    NSInteger row = infoModel.currentIndexPath.row;
    NSMutableArray *rowsArrayM = sectionDictM[@"unitbean"];
    NSMutableDictionary *rowDictM = rowsArrayM[row];
    rowDictM[@"value"] = infoModel.willChangeValue;
    NSData *data = [NSJSONSerialization dataWithJSONObject:infoModel.invitationDatas options:(NSJSONWritingPrettyPrinted) error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)deleteJsonStringWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel {
    
    //生产一个可变字典进行删除页面，然后发给后台，后台删除成功后，再去删除真正的主数据（万一删除失败，不会影响主数据）
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    NSArray *allKeys = infoModel.invitationDatas.allKeys;
    for (NSInteger index = 0; index < allKeys.count; index++) {
        NSString *key = allKeys[index];
        NSMutableDictionary *value = infoModel.invitationDatas[key];
        if ([value isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *arrayM = [NSMutableArray new];
            NSMutableArray *valueArrayM = (NSMutableArray *)value;
            for (NSInteger number = 0; number < valueArrayM.count; number++) {
                NSMutableDictionary *subValue = valueArrayM[number];
                if ([subValue isKindOfClass:[NSMutableDictionary class]]) {
                    NSMutableDictionary *subDictM = [NSMutableDictionary new];
                    for (NSInteger a = 0; a < subValue.allKeys.count; a++) {
                        NSString *subKey = subValue.allKeys[a];
                        subDictM[subKey] = subValue[subKey];
                    }
                }
                [arrayM addObject:subValue];
            }
            dictM[key] = arrayM;
            continue;
        }
        dictM[key] = value;
    }
    
    NSMutableArray *sectionArrayM = dictM[@"bean"];
    [sectionArrayM removeObjectAtIndex:infoModel.willDeletePageIndex];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictM options:(NSJSONWritingPrettyPrinted) error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 修改成功后，改变控件的内容
+ (void)changeValueWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel {
    UIView *view = infoModel.units[infoModel.currentIndexPath.section][infoModel.currentIndexPath.row];
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *sender = (UIButton *)view;
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:infoModel.willChangeValue]];
    }else if ([view isKindOfClass:[UITextView class]]) {
        ZLElectronicInvitationEditTemplateTextView *textView = (ZLElectronicInvitationEditTemplateTextView *)view;
        if (textView.isShareTime) {
            infoModel.sharetime = infoModel.willChangeValue;
        }
        textView.attributedText = [[NSAttributedString alloc] initWithString:infoModel.willChangeValue attributes:textView.attributes];
        CGFloat height = [textView.attributedText.string boundingRectWithSize:CGSizeMake(textView.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textView.attributes context:nil].size.height;
        height = height + textView.textContainerInset.top;
        height = height > 20.0 ? height : 20.0;
        textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, height);
    }
}

@end
