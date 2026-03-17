//
//  ZLIntegralShopHomeAreaHeadView.m
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeAreaHeadView.h"

@interface ZLIntegralShopHomeAreaHeadView ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///查看全部
@property (nonatomic,weak) UIButton *lookAllButton;

@end

@implementation ZLIntegralShopHomeAreaHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///标题
    [self titleLabel];
    ///查看全部
    [self lookAllButton];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat height = 50.0;
        CGFloat width = UIScreen.mainScreen.bounds.size.width - 110.0;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, width, height)];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UIButton *)lookAllButton {
    if (!_lookAllButton) {
        UIButton *lookAllButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, 80.0, CGRectGetHeight(self.titleLabel.frame))];
        lookAllButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        lookAllButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [lookAllButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [lookAllButton addTarget:self action:@selector(lookAllButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lookAllButton];
        _lookAllButton = lookAllButton;
    }
    return _lookAllButton;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    [self.lookAllButton setTitle:subTitle forState:UIControlStateNormal];
}

#pragma mark - Action
- (void)lookAllButtonAction {
    if (self.lookAll) {
        self.lookAll();
    }
}

@end
