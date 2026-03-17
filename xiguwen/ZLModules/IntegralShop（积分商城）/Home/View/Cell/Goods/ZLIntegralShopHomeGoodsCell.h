//
//  ZLIntegralShopHomeGoodsCell.h
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralShopHomeModel.h"

@protocol ZLIntegralShopHomeGoodsCellDelgate

///查看详情
- (void)lookDetailWithModel:(ZLIntegralShopHomeModel *)model;

@end

@interface ZLIntegralShopHomeGoodsCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(id)model;

@end
