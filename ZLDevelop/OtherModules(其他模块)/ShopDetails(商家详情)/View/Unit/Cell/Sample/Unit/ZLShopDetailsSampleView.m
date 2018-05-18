//
//  ZLShopDetailsSampleView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsSampleView.h"
#import <UIButton+AFNetworking.h>

@interface ZLShopDetailsSampleView ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///简介
@property (nonatomic,weak) UILabel *introLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///浏览
@property (nonatomic,weak) UIButton *browseButton;

@end

@implementation ZLShopDetailsSampleView

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
    //简介
    [self introLabel];
    //价格
    [self priceLabel];
    //浏览
    [self browseButton];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsSampleViewIconHeight = 120.0;
CGFloat const ZLShopDetailsSampleViewTitleHeight = 25.0;
CGFloat const ZLShopDetailsSampleViewIntroHeight = 30.0;
CGFloat const ZLShopDetailsSampleViewPriceHeight = 40.0;
CGFloat const ZLShopDetailsSampleViewTitleFont = 14.0;
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ZLShopDetailsSampleViewIconHeight)];
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
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.iconButton.frame), self.bounds.size.width - 10.0, ZLShopDetailsSampleViewTitleHeight)];
        titleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsSampleViewTitleFont];
        titleLabel.text = @"<暂无标题>";
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)introLabel {
    if (!_introLabel) {
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 10.0, ZLShopDetailsSampleViewIntroHeight)];
        introLabel.font = [UIFont systemFontOfSize:ZLShopDetailsSampleViewTitleFont * 0.8];
        introLabel.textColor = UIColor.lightGrayColor;
        introLabel.numberOfLines = 2;
        introLabel.text = @"<暂无简介>";
        [self addSubview:introLabel];
        _introLabel = introLabel;
    }
    return _introLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.introLabel.frame), self.bounds.size.width * 0.6 - 5.0, ZLShopDetailsSampleViewPriceHeight)];
        priceLabel.font = [UIFont systemFontOfSize:ZLShopDetailsSampleViewTitleFont * 1.1];
        priceLabel.textColor = [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0];
        priceLabel.text = @"<暂无价格>";
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UIButton *)browseButton {
    if (!_browseButton) {
        UIButton *browseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.6, CGRectGetMaxY(self.introLabel.frame), self.bounds.size.width * 0.4 - 5.0, ZLShopDetailsSampleViewPriceHeight)];
        browseButton.userInteractionEnabled = NO;
        [browseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        browseButton.titleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsSampleViewTitleFont * 0.8];
        browseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [browseButton setTitle:@"<暂无流量>" forState:UIControlStateNormal];
        [self addSubview:browseButton];
        _browseButton = browseButton;
    }
    return _browseButton;
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
- (void)setIntro:(NSString *)intro {
    _intro = intro;
    self.introLabel.text = intro;
}
- (void)setPrice:(NSString *)price {
    _price = price;
    self.priceLabel.text = price;
}
- (void)setBrowse:(NSString *)browse {
    _browse = browse;
    [self.browseButton setTitle:[NSString stringWithFormat:@" %@",browse] forState:UIControlStateNormal];
    if (!self.browseButton.imageView.image) {
        [self.browseButton setImage:[UIImage imageNamed:@"浏览"] forState:UIControlStateNormal];
    }
}

#pragma mark - Action
- (void)tapAction {
    if (self.click) {
        self.click();
    }
}

@end
