//
//  ZLIntegralShopHomeSignUnitView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeSignUnitView.h"

@interface ZLIntegralShopHomeSignUnitView ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ZLIntegralShopHomeSignUnitView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45.0, 30.0)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"积分.png"];
        iconButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [iconButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.iconButton.frame), 45.0, 20.0)];
        titleLabel.textColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
