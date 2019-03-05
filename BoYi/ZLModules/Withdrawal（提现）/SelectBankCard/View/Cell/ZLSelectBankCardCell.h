//
//  ZLSelectBankCardCell.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/31.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLSelectBankCardCell : UITableViewCell

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///子标题
@property (nonatomic,weak) UILabel *subTitleLabel;
///标记
@property (nonatomic,weak) UIButton *markButton;
///底部分割线
@property (nonatomic,weak) CALayer *bottomLine;


///Reuse
+ (instancetype)reuseCell:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end
