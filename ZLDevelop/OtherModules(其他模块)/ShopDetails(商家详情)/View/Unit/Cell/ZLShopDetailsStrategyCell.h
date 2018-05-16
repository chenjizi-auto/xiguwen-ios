//
//  ZLShopDetailsStrategyCell.h
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsModel.h"

///策略模式
@interface ZLShopDetailsStrategyCell : UITableViewCell

///行数
+ (NSInteger)numberOfRowsInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model;
///单元格高度
+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model;
///单元格对象对象
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model;

@end
