//
//  ZLAddBankCardCModel.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/11/1.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLAddBankCardCModel.h"
#import "ZLHTTPSessionManager.h"

@implementation ZLAddBankCardCModel

///实例模型
+ (instancetype)loadModel {
    ZLAddBankCardCModel *model = [ZLAddBankCardCModel new];
    
    __weak typeof(model)weakModel = model;
    model.load = ^{
        [weakModel sendAuthCode];
    };
    
    model.done = ^{
        [weakModel commitInfo];
    };
    
    return model;
}

///添加银行卡A步
- (void)sendAuthCode {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"mobile"] = self.phone;
    dictM[@"type"] = @"findpwd";
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/index/getverifycode" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                weakSelf.token = responseObject[@"data"];
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

///确认添加
- (void)commitInfo {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"mobile"] = self.phone;
    dictM[@"verifycode"] = self.code;
    dictM[@"ali_name"] = self.name;
    dictM[@"name"] = self.number;
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/Bankroll/add_ali_pay" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                if (weakSelf.goBackList) {
                    weakSelf.goBackList();
                }
                return;
            }
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:responseObject[@"message"]];
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败，请检查您的网络设置。"];
    }];
}

@end
