//
//  ZLRedPacketGoodsDetailView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRedPacketGoodsDetailModel.h"

@interface ZLRedPacketGoodsDetailView : UIView

///马上兑换
@property (nonatomic,copy) void (^clickFunctionBar)(void);
///弱引用数据
@property (nonatomic,weak) ZLRedPacketGoodsDetailModel *infoModel;
///查看猜你喜欢详情
@property (nonatomic,copy) void (^lookGuessYouLikeDetail)(ZLRedPacketGoodsDetailModel *model);
///后台错误信息
@property (nonatomic,strong) NSString *errorMessage;

@end
