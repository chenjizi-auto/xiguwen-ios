//
//  ZLIntegralGoodsOrderDetailView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsOrderDetailModel.h"

@interface ZLIntegralGoodsOrderDetailView : UIView

///弱引用数据
@property (nonatomic,weak) ZLIntegralGoodsOrderDetailModel *infoModel;
///查看猜你喜欢详情
@property (nonatomic,copy) void (^lookGuessYouLikeDetail)(ZLIntegralGoodsOrderDetailModel *model);

///停掉定时器
- (void)stopTimer;

@end
