//
//  ZLIntegralGoodsSureOrderView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsSureOrderModel.h"

@interface ZLIntegralGoodsSureOrderView : UIView

///选择地址
@property (nonatomic,copy) void (^clickAddress)(void);
///提交订单
@property (nonatomic,copy) void (^clickFunctionBar)(void);
///弱引用数据
@property (nonatomic,weak) ZLIntegralGoodsSureOrderModel *infoModel;
///后台错误信息
@property (nonatomic,strong) NSString *errorMessage;

@end
