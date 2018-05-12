//
//  ZLShopDetailsTeamView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsTeamView.h"

@interface ZLShopDetailsTeamView ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///职业
@property (nonatomic,weak) UILabel *professionLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;

@end

@implementation ZLShopDetailsTeamView

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
    //职业
    [self professionLabel];
    //价格
    [self priceLabel];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsTeamViewTitleHeight = 20.0;
CGFloat const ZLShopDetailsTeamViewTitleFont = 14.0;
- (UIButton *)iconButton {
    if (!_iconButton) {
        CGFloat width = 50.0;
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width - width) / 2, 10.0, width, width)];
        iconButton.userInteractionEnabled = NO;
        [iconButton setImage:[UIImage imageNamed:@"占位图片"] forState:UIControlStateNormal];
        iconButton.layer.cornerRadius = width / 2;
        iconButton.layer.masksToBounds = YES;
        iconButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconButton.frame) + 5.0, self.bounds.size.width, ZLShopDetailsTeamViewTitleHeight)];
        titleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsTeamViewTitleFont weight:0.25];
        titleLabel.text = @"<暂无标题>";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)professionLabel {
    if (!_professionLabel) {
        UILabel *professionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width, ZLShopDetailsTeamViewTitleHeight)];
        professionLabel.font = [UIFont systemFontOfSize:ZLShopDetailsTeamViewTitleFont * 0.9];
        professionLabel.textColor = UIColor.lightGrayColor;
        professionLabel.textAlignment = NSTextAlignmentCenter;
        professionLabel.text = @"<暂无职业描述>";
        [self addSubview:professionLabel];
        _professionLabel = professionLabel;
    }
    return _professionLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        CGFloat width = 65.0;
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - width) / 2, CGRectGetMaxY(self.professionLabel.frame) + 10.0, width, ZLShopDetailsTeamViewTitleHeight)];
        priceLabel.font = [UIFont systemFontOfSize:ZLShopDetailsTeamViewTitleFont * 0.7];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.layer.borderColor = [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0].CGColor;
        priceLabel.layer.borderWidth = 1.0;
        priceLabel.layer.cornerRadius = 2.0;
        priceLabel.layer.masksToBounds = YES;
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0];
        priceLabel.text = @"<暂无价格>";
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}

#pragma mark - Set
- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setProfession:(NSString *)profession {
    _profession = profession;
    self.professionLabel.text = profession;
}
- (void)setPrice:(NSString *)price {
    _price = price;
    self.priceLabel.text = price;
}

#pragma mark - Action
- (void)tapAction {
    if (self.click) {
        self.click();
    }
}

@end
