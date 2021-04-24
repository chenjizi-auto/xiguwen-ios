//
//  ZLSelectBankCardModel.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/30.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLSelectBankCardModel.h"
#import "ZLHTTPSessionManager.h"

@implementation ZLSelectBankCardModel

///实例模型
+ (instancetype)loadModel {
    ZLSelectBankCardModel *model = [ZLSelectBankCardModel new];
    model.page = 1;
    model.size = 100;
    
    __weak typeof(model)weakModel = model;
    model.load = ^{
        [weakModel requestBankCardList];
    };
    
    return model;
}

///删除银行卡
- (void)deleteBankCardAction {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = self.keyId;
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/Bankroll/del_ali_pay" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                if (weakSelf.deleteBankCardResults) {
                    weakSelf.deleteBankCardResults();
                }
                return;
            }
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:responseObject[@"message"]];
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败，请检查您的网络设置。"];
    }];
}

///银行卡列表
- (void)requestBankCardList {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"p"] = @(self.page);
    dictM[@"rows"] = @(self.size);
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/Bankroll/ali_list" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                [weakSelf modelWithDictionary:responseObject];
                if (weakSelf.results) {
                    weakSelf.results();
                }
                return;
            }
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:responseObject[@"message"]];
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败，请检查您的网络设置。"];
    }];
}

///解析模型
- (void)modelWithDictionary:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if (![dataDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if (!dataDict.count) {
        return;
    }
    
    NSArray *dataArray = dataDict[@"list"];
    if (![dataArray isKindOfClass:[NSArray class]]) {
        return;
    }
    if (!dataArray.count) {
        return;
    }
    
    //准备容器
    NSMutableArray *unitModels = [NSMutableArray new];
    
    for (NSInteger index = 0; index < dataArray.count; index++) {
        NSDictionary *unitDict = dataArray[index];
        ZLSelectBankCardModel *model = [[ZLSelectBankCardModel alloc] init];
        model.keyId = [NSString stringWithFormat:@"%@",unitDict[@"id"]];
        model.keyTitle = unitDict[@"ali_name"];
        model.subTitle = [NSString stringWithFormat:@"%@",unitDict[@"name"]];
        
        __weak typeof(model)weakModel = model;
        model.deleteBankCard = ^{
            [weakModel deleteBankCardAction];
        };
        
        [unitModels addObject:model];
    }
    
    //整理结构
    if (unitModels.count < self.size) {
        self.noMore = YES;
    }
    if (!self.unitModels) {
        self.unitModels = unitModels;
    }else {
        if (self.loadMore) {
            [self.unitModels addObjectsFromArray:unitModels];
        }else {
            self.unitModels = unitModels;
        }
    }
}

@end
