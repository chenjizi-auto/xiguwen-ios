//
//  ZLWithdrawalModel.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/29.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLWithdrawalModel.h"
#import "ZLHTTPSessionManager.h"

@implementation ZLWithdrawalModel

///实例模型
+ (instancetype)loadModel {
    ZLWithdrawalModel *model = [ZLWithdrawalModel new];
    
    __weak typeof(model)weakModel = model;
    model.load = ^{
        [weakModel pullWithdrawalInfo];
    };
    
    model.queryPayState = ^(ZLHUD *hud) {
        [weakModel queryPayState:hud];
    };
    
    model.withdrawal = ^(ZLHUD *hud) {
        [weakModel withdrawalAction:hud];
    };
    
    model.load();
    
    return model;
}

///提现
- (void)withdrawalAction:(ZLHUD *)hud {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    dictM[@"pwd"] = self.payPassword;
    dictM[@"money"] = self.money;
    dictM[@"yid"] = self.keyId;
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/Bankroll/apply_put_forward_ali" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        [ZLHUD HideHUD:hud];
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                if (weakSelf.withdrawalResults) {
                    weakSelf.withdrawalResults();
                }
                return;
            }
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:responseObject[@"message"]];
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败，请检查您的网络设置。"];
    }];
}

///查询支付密码
- (void)queryPayState:(ZLHUD *)hud {
    __weak typeof(self)weakSelf = self;
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/Bankroll/is_pay_passw" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        [ZLHUD HideHUD:hud];
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                if (weakSelf.payStateResults) {
                    weakSelf.payStateResults([responseObject[@"data"] boolValue]);
                }
                return;
            }
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:responseObject[@"message"]];
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败，请检查您的网络设置。"];
    }];
}

///拉取提现信息
- (void)pullWithdrawalInfo {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
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
    self.time = dataDict[@"button"];
    self.balance = dataDict[@"money"];
    self.starPhone = dataDict[@"mobiles"];
    self.phone = dataDict[@"mobile"];
    dataDict = ((NSArray *)dataDict[@"list"]).firstObject;
    if (![dataDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if (!dataDict.count) {
        return;
    }
    self.keyId = [NSString stringWithFormat:@"%@",dataDict[@"id"]];
    self.keyTitle = dataDict[@"ali_name"];
    self.subTitle = [NSString stringWithFormat:@"%@",dataDict[@"name"]];
}

@end
