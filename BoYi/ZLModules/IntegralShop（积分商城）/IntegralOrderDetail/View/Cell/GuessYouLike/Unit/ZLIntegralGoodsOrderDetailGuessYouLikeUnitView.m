//
//  ZLIntegralGoodsOrderDetailGuessYouLikeUnitView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailGuessYouLikeUnitView.h"
#import <UIButton+AFNetworking.h>

@interface ZLIntegralGoodsOrderDetailGuessYouLikeUnitView ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///数量
@property (nonatomic,weak) UILabel *numberLabel;

@end

@implementation ZLIntegralGoodsOrderDetailGuessYouLikeUnitView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///图标
    [self iconButton];
    ///标题
    [self titleLabel];
    ///价格
    [self priceLabel];
    ///数量
    [self numberLabel];
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        iconButton.userInteractionEnabled = NO;
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.iconButton.frame) + 10.0, self.frame.size.width - 10.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.text = @"<暂无标题>";
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.titleLabel.frame) + 8.0, self.frame.size.width - 70.0, 20.0)];
        priceLabel.text = @"0积分";
        priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:134/255.0 alpha:1.0];
        priceLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 65.0, CGRectGetMinY(self.priceLabel.frame), 60.0, 20.0)];
        numberLabel.textColor = UIColor.lightGrayColor;
        numberLabel.text = @"已兑 0";
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = [UIFont systemFontOfSize:11.0];
        [self addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}

#pragma mark - Set
- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    [self.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imagePath] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}
- (void)setPrice:(NSString *)price {
    _price = price;
    self.priceLabel.text = _price;
}
- (void)setNumber:(NSString *)number {
    _number = number;
    self.numberLabel.text = _number;
}

#pragma mark - Action
- (void)tapAction {
    if (self.click) {
        self.click();
    }
}

@end
