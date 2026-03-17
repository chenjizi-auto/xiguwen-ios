//
//  ZLAddBankCardCModel.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/11/1.
//  Copyright © 2018年   . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLAddBankCardCModel : NSObject

///验证码令牌
@property (nonatomic,strong) NSString *token;
///验证码
@property (nonatomic,strong) NSString *code;
///姓名
@property (nonatomic,strong) NSString *name;
///卡号
@property (nonatomic,strong) NSString *number;
///手机号
@property (nonatomic,strong) NSString *starPhone;
///手机号
@property (nonatomic,strong) NSString *phone;

///发送验证码
@property (nonatomic,copy) void (^load)(void);
///处理结果
@property (nonatomic,copy) void (^results)(void);
///确认添加
@property (nonatomic,copy) void (^done)(void);
///返回
@property (nonatomic,copy) void (^goBackList)(void);

///加载模型
+ (instancetype)loadModel;

@end
