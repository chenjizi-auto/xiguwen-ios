//
//  ZLIntegralGoodsBasicDetailCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsDetailCell.h"

@class ZLIntegralGoodsBasicDetailCell;
@protocol ZLIntegralGoodsBasicDetailCellDelgate

///点击banner的索引
- (void)clickBannerItem:(ZLIntegralGoodsBasicDetailCell *)cell ImageView:(UIImageView *)imageView Index:(NSInteger)index;

@end

@interface ZLIntegralGoodsBasicDetailCell : ZLIntegralGoodsDetailCell

@end
