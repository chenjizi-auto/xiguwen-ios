//
//  ZLIntegralGoodsOrderDetailPriceCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsOrderDetailModel.h"

@interface ZLIntegralGoodsOrderDetailPriceCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model;

@end
