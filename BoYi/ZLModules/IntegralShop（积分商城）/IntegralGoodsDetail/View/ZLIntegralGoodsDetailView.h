//
//  ZLIntegralGoodsDetailView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsDetailModel.h"

@interface ZLIntegralGoodsDetailView : UIView

///马上兑换
@property (nonatomic,copy) void (^clickFunctionBar)(void);
///弱引用数据
@property (nonatomic,weak) ZLIntegralGoodsDetailModel *infoModel;
///查看猜你喜欢详情
@property (nonatomic,copy) void (^lookGuessYouLikeDetail)(ZLIntegralGoodsDetailModel *model);
///隐藏状态栏
@property (nonatomic,copy) void (^hiddeStatusBar)(BOOL ishidden);

@end
