//
//  ZLRedPacketGoodsListCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRedPacketGoodsListModel.h"

@protocol ZLRedPacketGoodsListCellDelgate

///查看详情
- (void)lookDetailWithModel:(ZLRedPacketGoodsListModel *)model;

@end

@interface ZLRedPacketGoodsListCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(id)model;

@end
