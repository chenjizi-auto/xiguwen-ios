//
//  ZLElectronicInvitationCashGiftCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationCashGiftCell.h"

@implementation ZLElectronicInvitationCashGiftCell

#pragma mark - Lazy
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        CGFloat width = (UIScreen.mainScreen.bounds.size.width - 30.0) * 0.5;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, width, 20.0)];
        nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        nameLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.nameLabel.frame) + 10.0, 130.0, 20.0)];
        timeLabel.textColor = UIColor.lightGrayColor;
        timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (UILabel *)amountLabel {
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 0, CGRectGetWidth(self.nameLabel.frame), 70.0)];
        amountLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        amountLabel.font = [UIFont systemFontOfSize:16.0];
        amountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:amountLabel];
        _amountLabel = amountLabel;
    }
    return _amountLabel;
}

@end
