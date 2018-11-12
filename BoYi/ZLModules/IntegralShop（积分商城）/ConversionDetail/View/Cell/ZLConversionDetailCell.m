//
//  ZLConversionDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailCell.h"

@implementation ZLConversionDetailCell

#pragma mark - 单元格
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLConversionDetailModel *)model {
    NSString *className = model.conversionType == ZLConversionTypeGoods ? @"ZLConversionDetailGoodsCell" : @"ZLConversionDetailRedPacketCell";
    return [NSClassFromString(className) reuseCellWithTableView:tableView IndexPath:indexPath Model:model];
}

@end
