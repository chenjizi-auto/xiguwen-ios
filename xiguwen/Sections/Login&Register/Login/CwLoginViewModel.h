//
//  CwLoginViewModel.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CwLoginViewModel : NSObject

//手机号
@property (nonatomic, strong) NSString *userName;
//验证码
@property (nonatomic, strong) NSString *userPassword;
//地区code号
@property (nonatomic, strong) NSString *code;
//手机号码验证
@property (nonatomic, strong) RACSignal *isPhoneSignal;

//验证码验证
@property (nonatomic, strong) RACSignal *isCodeRightSignal;


//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;



@end
