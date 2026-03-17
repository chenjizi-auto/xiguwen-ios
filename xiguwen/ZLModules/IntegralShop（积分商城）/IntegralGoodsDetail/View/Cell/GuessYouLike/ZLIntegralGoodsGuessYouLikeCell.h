//
//  ZLIntegralGoodsGuessYouLikeCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralGoodsDetailCell.h"

@protocol ZLIntegralGoodsGuessYouLikeCellDelgate

///查看详情
- (void)lookDetailWithModel:(ZLIntegralGoodsDetailModel *)model;

@end

@interface ZLIntegralGoodsGuessYouLikeCell : ZLIntegralGoodsDetailCell

@end
