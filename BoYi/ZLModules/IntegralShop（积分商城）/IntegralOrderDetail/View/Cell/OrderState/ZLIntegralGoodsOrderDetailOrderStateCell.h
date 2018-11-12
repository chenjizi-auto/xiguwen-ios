//
//  ZLIntegralGoodsOrderDetailOrderStateCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLIntegralGoodsOrderDetailModel.h"

@interface ZLIntegralGoodsOrderDetailOrderStateCell : UITableViewCell

///当前倒计时
@property (nonatomic,unsafe_unretained) int currentCountdown;

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model;

@end
