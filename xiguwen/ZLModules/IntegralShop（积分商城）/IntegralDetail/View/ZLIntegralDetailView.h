//
//  ZLIntegralDetailView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralDetailModel.h"

@interface ZLIntegralDetailView : UIView

///弱引用数据
@property (nonatomic,weak) ZLIntegralDetailModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);

@end
