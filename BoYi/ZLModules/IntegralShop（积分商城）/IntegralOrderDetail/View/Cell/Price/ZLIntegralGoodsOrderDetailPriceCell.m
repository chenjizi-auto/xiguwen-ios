//
//  ZLIntegralGoodsOrderDetailPriceCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailPriceCell.h"

@interface ZLIntegralGoodsOrderDetailPriceCell ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///底部分割线
@property (nonatomic,weak) CALayer *bottomLineLayer;

@end

@implementation ZLIntegralGoodsOrderDetailPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self titleLabel];
    [self priceLabel];
    [self bottomLineLayer];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        titleLabel.text = @"实际支付";
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), 0, CGRectGetWidth(self.titleLabel.frame), 50.0)];
        priceLabel.font = [UIFont systemFontOfSize:14.0];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:134/255.0 alpha:1.0];
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (CALayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), UIScreen.mainScreen.bounds.size.width, 10.0);
        layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        [self.contentView.layer addSublayer:layer];
        _bottomLineLayer = layer;
    }
    return _bottomLineLayer;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model {
    ZLIntegralGoodsOrderDetailPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailPriceCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailPriceCell class])];
    }
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.payPrice];
    return cell;
}

@end
