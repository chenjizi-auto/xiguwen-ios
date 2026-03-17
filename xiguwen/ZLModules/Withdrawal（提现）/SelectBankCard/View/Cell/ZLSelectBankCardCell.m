//
//  ZLSelectBankCardCell.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/31.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLSelectBankCardCell.h"

@implementation ZLSelectBankCardCell

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 12.5, 50.0, 50.0)];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.layer.cornerRadius = 6.0;
        button.layer.masksToBounds = YES;
        [self.contentView addSubview:button];
        _iconButton = button;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, 12.5, UIScreen.mainScreen.bounds.size.width - CGRectGetMaxX(self.iconButton.frame) - 60.0, 20.0)];
        label.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, CGRectGetMaxY(self.iconButton.frame) - 20.0, CGRectGetWidth(self.titleLabel.frame), 20.0)];
        label.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:label];
        _subTitleLabel = label;
    }
    return _subTitleLabel;
}
- (UIButton *)markButton {
    if (!_markButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 50.0, 0, 50.0, 75.0)];
        [self.contentView addSubview:button];
        _markButton = button;
    }
    return _markButton;
}
- (CALayer *)bottomLine {
    if (!_bottomLine) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(15.0, 75.5, UIScreen.mainScreen.bounds.size.width - 15.0, 0.5);
        layer.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0].CGColor;
        [self.contentView.layer addSublayer:layer];
        _bottomLine = layer;
    }
    return _bottomLine;
}

#pragma mark - Reuse
+ (instancetype)reuseCell:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    ZLSelectBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLSelectBankCardCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLSelectBankCardCell class])];
    }
    cell.bottomLine.hidden = YES;
    [cell.markButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    return cell;
}

@end
