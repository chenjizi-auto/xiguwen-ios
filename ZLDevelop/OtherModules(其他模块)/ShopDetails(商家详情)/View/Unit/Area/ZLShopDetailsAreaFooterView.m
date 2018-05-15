//
//  ZLShopDetailsAreaFooterView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsAreaFooterView.h"

@interface ZLShopDetailsAreaFooterView ()

//更多（事件）
@property (nonatomic,weak) UIButton *moreButton;
//分割线
@property (nonatomic,weak) CALayer *topLineLayer;
//分割线
@property (nonatomic,weak) CALayer *bottomLineLayer;

@end

@implementation ZLShopDetailsAreaFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //分割线
    [self topLineLayer];
    [self bottomLineLayer];
    //更多（事件）
    [self moreButton];
}

#pragma mark - Lazy
- (UIButton *)moreButton {
    if (!_moreButton) {
        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 5.0)];
        [moreButton setTitleColor:[UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0] forState:UIControlStateNormal];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:moreButton];
        _moreButton = moreButton;
    }
    return _moreButton;
}
- (CALayer *)topLineLayer {
    if (!_topLineLayer) {
        CALayer *topLineLayer = [CALayer layer];
        topLineLayer.frame = CGRectMake(0, -0.3, self.frame.size.width, 0.3);
        topLineLayer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [self.layer addSublayer:topLineLayer];
        _topLineLayer = topLineLayer;
    }
    return _topLineLayer;
}
- (CALayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        CALayer *bottomLineLayer = [CALayer layer];
        bottomLineLayer.frame = CGRectMake(0, self.frame.size.height - 5.0, self.frame.size.width, 5.0);
        bottomLineLayer.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0].CGColor;
        [self.layer addSublayer:bottomLineLayer];
        _bottomLineLayer = bottomLineLayer;
    }
    return _bottomLineLayer;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    [self.moreButton setTitle:title forState:UIControlStateNormal];
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.moreButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor {
    _titleBackgroundColor = titleBackgroundColor;
    self.backgroundColor = titleBackgroundColor;
}

#pragma mark - Action
- (void)moreButtonAction:(UIButton *)sender {
    if (self.sectionFootersClick) {
        self.sectionFootersClick();
    }
}

@end
