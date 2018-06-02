//
//  ZLIntegralGoodsOrderDetailGoodsCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailGoodsCell.h"
#import <UIButton+AFNetworking.h>

@interface ZLIntegralGoodsOrderDetailGoodsCell ()
///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///数量
@property (nonatomic,weak) UILabel *numberLabel;

@end

@implementation ZLIntegralGoodsOrderDetailGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self iconButton];
    [self titleLabel];
    [self priceLabel];
    [self numberLabel];
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 5.0, 90.0, 90.0)];
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, 10.0, UIScreen.mainScreen.bounds.size.width - CGRectGetMaxX(self.iconButton.frame) - 25.0, 20.0)];
        titleLabel.numberOfLines = 3;
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10.0, CGRectGetWidth(self.titleLabel.frame) - 40.0, 20.0)];
        priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:134/255.0 alpha:1.0];
        priceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame), CGRectGetMaxY(self.iconButton.frame) - 20.0, 40.0, 20.0)];
        numberLabel.font = [UIFont systemFontOfSize:14.0];
        numberLabel.text = @"X1";
        numberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model {
    ZLIntegralGoodsOrderDetailGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailGoodsCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailGoodsCell class])];
    }
    [cell.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.goodsUrl] placeholderImage:[UIImage imageNamed:@"square_placeholder_ small"]];
    cell.titleLabel.text = model.goodsName;
    cell.priceLabel.text = model.goodsPrice;
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, model.goodsNameHeight);
    cell.priceLabel.frame = CGRectMake(cell.priceLabel.frame.origin.x, CGRectGetMaxY(cell.titleLabel.frame) + 10.0, cell.priceLabel.frame.size.width, cell.priceLabel.frame.size.height);
    return cell;
}

@end
