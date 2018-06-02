//
//  ZLIntegralDetailCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralDetailCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(id)model;

@end
