//
//  ZLRedPacketGoodsBasicDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsBasicDetailCell.h"
#import <UIImageView+AFNetworking.h>

@interface ZLRedPacketGoodsBasicDetailCell ()

///轮播
@property (nonatomic,weak) UIImageView *iconImageView;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///数量
@property (nonatomic,weak) UILabel *numberLabel;

@end

@implementation ZLRedPacketGoodsBasicDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///大图
    [self iconImageView];
    ///标题
    [self titleLabel];
    ///价格
    [self priceLabel];
    ///数量
    [self numberLabel];
}

#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width)];
        [self.contentView addSubview:iconImageView];
        _iconImageView = iconImageView;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.iconImageView.frame) + 10.0, UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleLabel.frame) + 20.0, UIScreen.mainScreen.bounds.size.width - 130.0, 20.0)];
        priceLabel.font = [UIFont systemFontOfSize:18.0];
        priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 115.0, CGRectGetMaxY(self.titleLabel.frame) + 20.0, 100.0, 20.0)];
        numberLabel.textColor = UIColor.lightGrayColor;
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLRedPacketGoodsDetailModel *)model {
    ZLRedPacketGoodsBasicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLRedPacketGoodsBasicDetailCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLRedPacketGoodsBasicDetailCell class])];
    }
    model = model.unitModels[0];
    model = model.unitModels[0];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"square_placeholder_ big"]];
    cell.priceLabel.text = model.integral;
    cell.numberLabel.text = model.number;
    cell.titleLabel.text = model.title;
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, model.titleHeight);
    cell.priceLabel.frame = CGRectMake(cell.priceLabel.frame.origin.x, CGRectGetMaxY(cell.titleLabel.frame) + 20.0, cell.priceLabel.frame.size.width, cell.priceLabel.frame.size.height);
    cell.numberLabel.frame = CGRectMake(cell.numberLabel.frame.origin.x, CGRectGetMaxY(cell.titleLabel.frame) + 20.0, cell.numberLabel.frame.size.width, cell.numberLabel.frame.size.height);
    return cell;
}

@end
