//
//  ZLIntegralShopBannerUnitModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/27.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeModel.h"

@interface ZLIntegralShopBannerUnitModel : ZLIntegralShopHomeModel

///积分商品解析
+ (void)integralShopBannerUnitModelWithArray:(NSArray *)array Model:(ZLIntegralShopHomeModel *)model;

@end
