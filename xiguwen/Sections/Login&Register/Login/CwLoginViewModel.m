//
//  CwLoginViewModel.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "CwLoginViewModel.h"

@implementation CwLoginViewModel


//登录
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, userPassword)] reduce:^id _Nullable(NSString *userName,NSString *userPassword){
            return @(userName.length == 11 && userPassword.length >= 6);
        }]
                                                      signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            @strongify(self);
            NSDictionary *dic = @{@"mobile":self.userName,@"password":self.userPassword};
            return [[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_ACCOUNT_LOGIN
                                                          method:POST
                                                          loding:nil
                                                             dic:dic];
        }];
    }
    return _refreshDataCommand;
}



@end
