//
//  ZLStaticPage.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/8/17.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLStaticPage.h"

@interface ZLStaticPage ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///事件按钮
@property (nonatomic,weak) UIButton *button;

@end

@implementation ZLStaticPage

#pragma mark - Set
- (void)setTitle:(NSMutableAttributedString *)title {
    _title = title;
    [self updateValues];
}
- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    [self updateValues];
}
- (void)setTopInset:(CGFloat)topInset {
    _topInset = topInset;
    [self updateValues];
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.userInteractionEnabled = NO;
        [self addSubview:button];
        _iconButton = button;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14.0];
        label.numberOfLines = 2;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UIButton *)button {
    if (!_button) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button addTarget:self action:@selector(gotoItemAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button = button;
    }
    return _button;
}

#pragma mark - Private
- (void)updateValues {
    if (self.iconName) {
        [self.iconButton setImage:[UIImage imageNamed:self.iconName] forState:UIControlStateNormal];
    }
    if (self.title) {
        self.titleLabel.attributedText = self.title;
    }
    if (self.topInset) {
        CGSize size = [self.title.string boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.iconButton.frame),MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
        CGFloat height = size.height > 40.0 ? 40.0 : size.height;
        self.iconButton.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width - 200.0) / 2, self.topInset, 200.0, 200.0);
        self.titleLabel.frame = CGRectMake(CGRectGetMinX(self.iconButton.frame), CGRectGetMaxY(self.iconButton.frame) + 20.0, CGRectGetWidth(self.iconButton.frame), height);
    }
    if (self.buttonTitle) {
        self.button.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10.0, CGRectGetWidth(self.titleLabel.frame), 25.0);
        [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
    }
}
- (void)gotoItemAction {
    if (self.gotoAction) {
        self.gotoAction();
    }
}

@end
