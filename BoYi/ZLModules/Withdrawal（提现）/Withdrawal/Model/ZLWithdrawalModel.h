//
//  ZLWithdrawalModel.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/29.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHUD.h"

@interface ZLWithdrawalModel : NSObject

///有问题
@property (nonatomic,unsafe_unretained) BOOL error;

///银行名称
@property (nonatomic,strong) NSString *keyTitle;
///银行卡id
@property (nonatomic,strong) NSString *keyId;
///卡号
@property (nonatomic,strong) NSString *subTitle;
///余额
@property (nonatomic,strong) NSString *balance;
///时间
@property (nonatomic,strong) NSString *time;
///提现金额
@property (nonatomic,strong) NSString *money;
///支付密码
@property (nonatomic,strong) NSString *payPassword;
///手机号
@property (nonatomic,strong) NSString *starPhone;
///手机号
@property (nonatomic,strong) NSString *phone;

///下拉刷新、上拉加载
@property (nonatomic,copy) void (^load)(void);
///处理结果
@property (nonatomic,copy) void (^results)(void);
///选择银行卡
@property (nonatomic,copy) void (^selectBankCard)(void);
///提现
@property (nonatomic,copy) void (^withdrawal)(ZLHUD *hud);
///提现
@property (nonatomic,copy) void (^withdrawalResults)(void);
///查询支付密码状态
@property (nonatomic,copy) void (^queryPayState)(ZLHUD *hud);
///查询支付密码的结果
@property (nonatomic,copy) void (^payStateResults)(BOOL didSetup);
///设置支付密码
@property (nonatomic,copy) void (^setupPayPassword)(void);

///加载模型
+ (instancetype)loadModel;

@end
