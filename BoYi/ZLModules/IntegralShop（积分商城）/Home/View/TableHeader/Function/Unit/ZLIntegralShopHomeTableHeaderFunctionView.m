//
//  ZLIntegralShopHomeTableHeaderFunctionView.m
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeTableHeaderFunctionView.h"

@interface ZLIntegralShopHomeTableHeaderFunctionView ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///子标题
@property (nonatomic,weak) UILabel *subTitleLabel;

@end

@implementation ZLIntegralShopHomeTableHeaderFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///标题
    [self titleLabel];
    ///子标题
    [self subTitleLabel];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 45.0) / 2, self.bounds.size.width, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:22.0];
        titleLabel.textColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 5.0, self.bounds.size.width, 20.0)];
        subTitleLabel.font = [UIFont systemFontOfSize:14.0];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subTitleLabel];
        _subTitleLabel = subTitleLabel;
    }
    return _subTitleLabel;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}

@end
