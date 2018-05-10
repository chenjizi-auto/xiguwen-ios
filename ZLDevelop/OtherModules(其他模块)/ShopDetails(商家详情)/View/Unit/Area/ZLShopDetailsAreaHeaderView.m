//
//  ZLShopDetailsAreaHeaderView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsAreaHeaderView.h"

@interface ZLShopDetailsAreaHeaderView ()

//标题
@property (nonatomic,weak) UILabel *titleLabel;
//分割线
@property (nonatomic,weak) CALayer *topLineLayer;
//分割线
@property (nonatomic,weak) CALayer *bottomLineLayer;

@end

@implementation ZLShopDetailsAreaHeaderView

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
    //标题
    [self titleLabel];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, UIScreen.mainScreen.bounds.size.width - 20.0, self.frame.size.height)];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
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
        bottomLineLayer.frame = CGRectMake(0, self.frame.size.height - 0.3, self.frame.size.width, 0.3);
        bottomLineLayer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [self.layer addSublayer:bottomLineLayer];
        _bottomLineLayer = bottomLineLayer;
    }
    return _bottomLineLayer;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
