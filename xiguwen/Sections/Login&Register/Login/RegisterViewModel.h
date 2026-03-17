//
//  RegisterViewModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterViewModel : NSObject

//手机号
@property (nonatomic, strong) NSString *userName;
//验证码
@property (nonatomic, strong) NSString *userPassword;
//手机号码验证
@property (nonatomic, strong) RACSignal *isPhoneSignal;
//可以获取验证码了
@property (nonatomic, strong) RACSignal *isCanGetCodeDown;
//获取验证码
@property (nonatomic, strong) RACCommand *getCodeCommand;
//登录
@property (nonatomic, strong) RACCommand *LoginCommand;
@end
