//
//  ZLConversionDetailCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLConversionDetailModel.h"

@interface ZLConversionDetailCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLConversionDetailModel *)model;

@end
