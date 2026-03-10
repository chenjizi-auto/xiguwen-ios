//
//  RechargeModel.h
//  BoYi
//
//  Created by    on 2023/2/10.
//  Copyright © 2023 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHUD.h"

@interface RechargeModel : NSObject

/// 金额
@property (nonatomic,strong) NSString *price;
/// 备注
@property (nonatomic,strong) NSString *remarks;
/// 订单编号
@property (nonatomic,strong) NSString *orderNumber;

///处理结果
@property (nonatomic,copy) void (^results)(void);
/// 下一步
@property (nonatomic,copy) void (^next)(void);

///加载模型
+ (instancetype)loadModel;

@end

