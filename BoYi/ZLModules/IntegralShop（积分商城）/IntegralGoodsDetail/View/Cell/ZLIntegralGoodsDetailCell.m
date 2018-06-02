//
//  ZLIntegralGoodsDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsDetailCell.h"

@implementation ZLIntegralGoodsDetailCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLIntegralGoodsDetailModel *)model {
    NSArray *className = @[@"ZLIntegralGoodsBasicDetailCell",
                           @"ZLIntegralGoodsImageTextDetailCell",
                           @"ZLIntegralGoodsGuessYouLikeCell"];
    return [NSClassFromString(className[indexPath.section]) reuseCellWithTableView:tableView IndexPath:indexPath Delegate:delegate Model:model];
}

@end
