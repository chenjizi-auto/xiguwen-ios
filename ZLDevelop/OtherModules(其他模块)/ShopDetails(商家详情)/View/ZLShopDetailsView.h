//
//  ZLShopDetailsView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLShopDetailsModel.h"

@interface ZLShopDetailsView : UIView

///加载数据
@property (nonatomic,copy) void (^loadData)();
///数据模型
@property (nonatomic,weak) ZLShopDetailsModel *dataModel;

@end
