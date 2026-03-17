//
//  ZLRedPacketGoodsDetailCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRedPacketGoodsDetailModel.h"

@interface ZLRedPacketGoodsDetailCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLRedPacketGoodsDetailModel *)model;

@end
