//
//  ZLIntegralGoodsImageTextDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralGoodsImageTextDetailCell.h"
#import <UIButton+AFNetworking.h>
#import "ZLIntegralGoodsDetailModel.h"

@interface ZLIntegralGoodsImageTextDetailCell ()

@end

@implementation ZLIntegralGoodsImageTextDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self iconButton];
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectZero];
        iconButton.userInteractionEnabled = NO;
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLIntegralGoodsDetailModel *)model {
    ZLIntegralGoodsImageTextDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsImageTextDetailCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsImageTextDetailCell class])];
    }
    model = model.unitModels[indexPath.section];
    model = model.unitModels[indexPath.row];
    [cell.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
    cell.iconButton.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, model.cellHeight);
    return cell;
}

@end
