//
//  ZLRedPacketGoodsDetailNavBgView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsDetailNavBgView.h"

@interface ZLRedPacketGoodsDetailNavBgView ()

//
@property (nonatomic,weak) UIView *alphaView;
//
@property (nonatomic,weak) UIVisualEffectView *visualEffectView;
//
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ZLRedPacketGoodsDetailNavBgView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self alphaView];
}

#pragma mark - Lazy
- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        _visualEffectView = effectView;
        //线条
        CALayer *layer = [CALayer new];
        CGFloat lineHeight = 0.25;
        layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        layer.frame = CGRectMake(0, 64.0 - lineHeight, UIScreen.mainScreen.bounds.size.width, lineHeight);
        [effectView.contentView.layer addSublayer:layer];
    }
    return _visualEffectView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20.0, UIScreen.mainScreen.bounds.size.width, 44.0)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.blackColor;
        [_alphaView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UIView *)alphaView {
    if (!_alphaView) {
        UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:alphaView];
        _alphaView = alphaView;
        [self visualEffectView];
        [self titleLabel];
    }
    return _alphaView;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setAlpha:(CGFloat)alpha {
    self.visualEffectView.alpha = alpha;
    self.titleLabel.alpha = alpha;
}

@end
