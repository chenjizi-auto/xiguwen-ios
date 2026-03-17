//
//  ZLIntegralGoodsListUnitView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsListUnitView.h"
#import <UIButton+AFNetworking.h>

@interface ZLIntegralGoodsListUnitView ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///兑换
@property (nonatomic,weak) UILabel *conversionLabel;

@end

@implementation ZLIntegralGoodsListUnitView

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
    //兑换
    [self conversionLabel];
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width - 100.0) * 0.5, 0, 100.0, 100.0)];
        iconButton.userInteractionEnabled = NO;
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconButton.frame) + 10.0, self.bounds.size.width, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.text = @"<暂无标题>";
        titleLabel.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1.0];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 5.0, self.bounds.size.width, 20.0)];
        priceLabel.font = [UIFont systemFontOfSize:13.0];
        priceLabel.attributedText = [[NSMutableAttributedString alloc]initWithString:@"<暂无价格>"];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UILabel *)conversionLabel {
    if (!_conversionLabel) {
        UILabel *conversionLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - 80.0) / 2, self.bounds.size.height - 25.0, 80.0, 25.0)];
        conversionLabel.font = [UIFont systemFontOfSize:13.0];
        conversionLabel.textAlignment = NSTextAlignmentCenter;
        conversionLabel.textColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        conversionLabel.text = @"马上兑换";
        conversionLabel.layer.cornerRadius = 3.0;
        conversionLabel.layer.masksToBounds = YES;
        conversionLabel.layer.borderColor = conversionLabel.textColor.CGColor;
        conversionLabel.layer.borderWidth = 1.0;
        [self addSubview:conversionLabel];
        _conversionLabel = conversionLabel;
    }
    return _conversionLabel;
}

#pragma mark - Set
- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    [self.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setPrice:(NSString *)price {
    _price = price;
    if ([price rangeOfString:@","].location != NSNotFound) {
        NSArray *valuesArray = [price componentsSeparatedByString:@","];
        NSString *firstValue = valuesArray.firstObject;
        NSString *lastValue = valuesArray.lastObject;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@积分+%@元",firstValue,lastValue]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:85/255.0 blue:134/255.0 alpha:1.0] range:NSMakeRange(0, firstValue.length)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:85/255.0 blue:134/255.0 alpha:1.0] range:NSMakeRange(firstValue.length + 2, lastValue.length + 1)];
        self.priceLabel.attributedText = AttributedStr;
    }else {
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@积分",price]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:85/255.0 blue:134/255.0 alpha:1.0] range:NSMakeRange(0, AttributedStr.length - 2)];
        self.priceLabel.attributedText = AttributedStr;
    }
}

#pragma mark - Action
- (void)tapAction {
    if (self.click) {
        self.click();
    }
}

@end
