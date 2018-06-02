//
//  ZLRedPacketGoodsDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsDetailCell.h"

@implementation ZLRedPacketGoodsDetailCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLRedPacketGoodsDetailModel *)model {
    NSArray *className = @[@"ZLRedPacketGoodsBasicDetailCell",
                           @"ZLRedPacketGoodsDetailGuessYouLikeCell"];
    return [NSClassFromString(className[indexPath.section]) reuseCellWithTableView:tableView IndexPath:indexPath Delegate:delegate Model:model];
}

@end
