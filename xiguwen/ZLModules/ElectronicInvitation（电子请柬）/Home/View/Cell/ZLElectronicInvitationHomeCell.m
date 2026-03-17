//
//  ZLElectronicInvitationHomeCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationHomeCell.h"

@implementation ZLElectronicInvitationHomeCell

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame))];
        iconButton.layer.cornerRadius = 3.0;
        iconButton.layer.masksToBounds = YES;
        iconButton.userInteractionEnabled = NO;
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}

@end
