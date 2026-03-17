//
//  ZLConversionDetailView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLConversionDetailModel.h"

@interface ZLConversionDetailView : UIView

///弱引用数据
@property (nonatomic,weak) ZLConversionDetailModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///查看详情
@property (nonatomic,copy) void (^lookDetail)(ZLConversionDetailModel *goodsModel);

@end
