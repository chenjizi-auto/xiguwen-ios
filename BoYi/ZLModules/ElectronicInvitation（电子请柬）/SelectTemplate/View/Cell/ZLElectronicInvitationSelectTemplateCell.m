//
//  ZLElectronicInvitationSelectTemplateCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLElectronicInvitationSelectTemplateCell.h"

@implementation ZLElectronicInvitationSelectTemplateCell

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) - 20.0)];
        iconButton.layer.cornerRadius = 3.0;
        iconButton.layer.masksToBounds = YES;
        iconButton.userInteractionEnabled = NO;
        iconButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, CGRectGetMaxY(self.iconButton.frame), CGRectGetWidth(self.contentView.frame) - 10.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

@end
