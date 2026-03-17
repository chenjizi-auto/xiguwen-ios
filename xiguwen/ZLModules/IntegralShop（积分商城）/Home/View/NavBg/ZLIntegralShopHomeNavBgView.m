//
//  ZLIntegralShopHomeNavBgView.m
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeNavBgView.h"

@interface ZLIntegralShopHomeNavBgView ()

//
@property (nonatomic,weak) UIView *alphaView;
//
@property (nonatomic,weak) UIVisualEffectView *visualEffectView;
//
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ZLIntegralShopHomeNavBgView

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
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        layer.frame = CGRectMake(0, statusBarHeight + 44.0 - lineHeight, UIScreen.mainScreen.bounds.size.width, lineHeight);
        [effectView.contentView.layer addSublayer:layer];
    }
    return _visualEffectView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, statusBarHeight, UIScreen.mainScreen.bounds.size.width, 44.0)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.whiteColor;
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
    self.titleLabel.textColor = (alpha >= 1.0) ? UIColor.blackColor : UIColor.whiteColor;
}

@end
