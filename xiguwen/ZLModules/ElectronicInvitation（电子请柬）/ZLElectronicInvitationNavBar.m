//
//  ZLNavBar.m
//  BoYi
//
//  Created by zhaolei on 2018/6/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLElectronicInvitationNavBar.h"

@implementation ZLElectronicInvitationNavBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, statusBarHeight + 44.0);
    }
    return self;
}

- (UIButton *)goBackButton {
    if (!_goBackButton) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        UIButton *goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(5.0, statusBarHeight, 40.0, 40.0)];
        [goBackButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goBackButton];
        _goBackButton = goBackButton;
    }
    return _goBackButton;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 45.0, CGRectGetMinY(self.goBackButton.frame), 40.0, 40.0)];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [rightButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        _rightButton = rightButton;
    }
    return _rightButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 80.0) / 2, CGRectGetMinY(self.goBackButton.frame), 80.0, 40.0)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17.0];
        titleLabel.textColor = UIColor.whiteColor;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

#pragma mark - Action
- (void)goBackAction {
    if (self.goBack) {
        self.goBack();
    }
}
- (void)rightButtonAction {
    if (self.rightAction) {
        self.rightAction();
    }
}

@end
