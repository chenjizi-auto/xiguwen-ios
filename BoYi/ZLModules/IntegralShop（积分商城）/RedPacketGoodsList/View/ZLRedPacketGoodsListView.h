//
//  ZLRedPacketGoodsListView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRedPacketGoodsListModel.h"

@interface ZLRedPacketGoodsListView : UIView

///弱引用数据
@property (nonatomic,weak) ZLRedPacketGoodsListModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///查看详情
@property (nonatomic,copy) void (^lookDetail)(ZLRedPacketGoodsListModel *model);

@end
