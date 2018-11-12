//
//  ZLElectronicInvitationCashGiftSectionHeader.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationCashGiftSectionHeader.h"

@interface ZLElectronicInvitationCashGiftSectionHeader ()

///动画视图
@property (nonatomic,weak) UIActivityIndicatorView *activityIndicatorView;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///背景
@property (nonatomic,weak) UIView *bgView;

@end

@implementation ZLElectronicInvitationCashGiftSectionHeader

#pragma mark - Set
- (void)setShowAnimation:(BOOL)showAnimation {
    _showAnimation = showAnimation;
    _showAnimation
    ? [self.activityIndicatorView startAnimating]
    : [self.activityIndicatorView stopAnimating];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size.width;
    self.titleLabel.frame = CGRectMake((CGRectGetWidth(self.bgView.frame) - width) / 2, 0, width, CGRectGetHeight(self.bgView.frame));
    self.activityIndicatorView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame) - CGRectGetWidth(self.activityIndicatorView.frame), 0, CGRectGetWidth(self.activityIndicatorView.frame), CGRectGetHeight(self.bgView.frame));
}

#pragma mark - Lazy
- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 7.7, UIScreen.mainScreen.bounds.size.width, 50.0)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}
- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        activityIndicatorView.color = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        [self.bgView addSubview:activityIndicatorView];
        activityIndicatorView.center = self.center;
        _activityIndicatorView = activityIndicatorView;
    }
    return _activityIndicatorView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        titleLabel.backgroundColor = UIColor.whiteColor;
        [self.bgView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

@end
