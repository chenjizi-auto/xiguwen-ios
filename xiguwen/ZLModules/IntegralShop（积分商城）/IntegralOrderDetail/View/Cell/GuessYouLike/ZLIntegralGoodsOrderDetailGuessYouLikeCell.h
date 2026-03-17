//
//  ZLIntegralGoodsOrderDetailGuessYouLikeCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsOrderDetailModel.h"

@protocol ZLIntegralGoodsOrderDetailGuessYouLikeCellDelgate

///查看详情
- (void)lookDetailWithModel:(ZLIntegralGoodsOrderDetailModel *)model;

@end

@interface ZLIntegralGoodsOrderDetailGuessYouLikeCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLIntegralGoodsOrderDetailModel *)model;

@end
