//
//  ZLIntegralShopHomeSignView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralShopHomeModel.h"

@interface ZLIntegralShopHomeSignView : UIView

///签到数据
@property (nonatomic,strong) ZLIntegralShopHomeModel *signModel;
///更新界面
@property (nonatomic,copy) void (^updateInterface)(void);

@end
