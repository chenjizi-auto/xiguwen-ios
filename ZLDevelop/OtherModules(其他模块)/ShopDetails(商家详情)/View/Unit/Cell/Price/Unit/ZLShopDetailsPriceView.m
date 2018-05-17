//
//  ZLShopDetailsPriceView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsPriceView.h"
#import <UIButton+AFNetworking.h>

@interface ZLShopDetailsPriceView ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///数量
@property (nonatomic,weak) UILabel *numberLabel;

@end

@implementation ZLShopDetailsPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //图标
    [self iconButton];
    //标题
    [self titleLabel];
    //价格
    [self priceLabel];
    //数量
    [self numberLabel];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsPriceViewIconHeight = 120.0;
CGFloat const ZLShopDetailsPriceViewTitleHeight = 25.0;
CGFloat const ZLShopDetailsPriceViewPriceHeight = 40.0;
CGFloat const ZLShopDetailsPriceViewTitleFont = 14.0;
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ZLShopDetailsPriceViewIconHeight)];
        iconButton.userInteractionEnabled = NO;
        [iconButton setImage:[UIImage imageNamed:@"占位图片"] forState:UIControlStateNormal];
        iconButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.iconButton.frame), self.bounds.size.width - 10.0, ZLShopDetailsPriceViewTitleHeight)];
        titleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsPriceViewTitleFont];
        titleLabel.text = @"<暂无标题>";
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width * 0.6 - 5.0, ZLShopDetailsPriceViewPriceHeight)];
        priceLabel.font = [UIFont systemFontOfSize:ZLShopDetailsPriceViewTitleFont * 1.1];
        priceLabel.textColor = [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0];
        priceLabel.text = @"<暂无价格>";
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.6, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width * 0.4 - 5.0, ZLShopDetailsPriceViewPriceHeight)];
        numberLabel.font = [UIFont systemFontOfSize:ZLShopDetailsPriceViewTitleFont * 0.8];
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.textColor = UIColor.lightGrayColor;
        numberLabel.text = @"<暂无数量>";
        [self addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}

#pragma mark - Set
- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    [self.iconButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setPrice:(NSString *)price {
    _price = price;
    self.priceLabel.text = price;
}
- (void)setNumber:(NSString *)number {
    _number = number;
    self.numberLabel.text = number;
}

#pragma mark - Action
- (void)tapAction {
    if (self.click) {
        self.click();
    }
}

@end
