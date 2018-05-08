//
//  RegisterViewModel.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel



//获取验证码
- (RACCommand *)getCodeCommand {
    
    if (!_getCodeCommand) {
        

        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
            return [[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_ACCOUNT_GETSMSCODE
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _getCodeCommand;
}


//登录
- (RACCommand *)LoginCommand {
    
    if (!_LoginCommand) {
        
        _LoginCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, userPassword)] reduce:^id _Nullable(NSString *userName,NSString *userPassword){
            return @(userName.length == 11 && userPassword.length >= 6);
        }]
                                                      signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
                                                          return [[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_ACCOUNT_REGISTER
                                                                                                        method:POST
                                                                                                        loding:nil
                                                                                                           dic:input];
                                                      }];
    }
    return _LoginCommand;
}

@end
