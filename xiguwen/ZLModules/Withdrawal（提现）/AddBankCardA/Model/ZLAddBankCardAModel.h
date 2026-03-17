//
//  ZLAddBankCardAModel.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/31.
//  Copyright © 2018年   . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLSelectBankCardViewController.h"

@interface ZLAddBankCardAModel : NSObject

///姓名
@property (nonatomic,strong) NSString *name;
///卡号
@property (nonatomic,strong) NSString *number;

///下一步
@property (nonatomic,copy) void (^next)(void);

///加载模型
+ (instancetype)loadModel;

@end
