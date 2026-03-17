//
//  ZLElectronicInvitationGuestsReplyCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationGuestsReplyCell.h"

@interface ZLElectronicInvitationGuestsReplyCell ()

///姓名
@property (nonatomic,weak) UILabel *nameLabel;
///时间
@property (nonatomic,weak) UILabel *timeLabel;
///内容
@property (nonatomic,weak) UIButton *contentButton;
///状态
@property (nonatomic,weak) UILabel *stateLabel;

@end

@implementation ZLElectronicInvitationGuestsReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
    }
    return self;
}

#pragma mark - Lazy
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.font = [UIFont systemFontOfSize:16.0];
        nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.textColor = UIColor.lightGrayColor;
        timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (UIButton *)contentButton {
    if (!_contentButton) {
        UIButton *contentButton = [[UIButton alloc] initWithFrame:CGRectZero];
        contentButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        contentButton.titleLabel.numberOfLines = 0;
        contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [contentButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [contentButton setTitleColor:UIColor.blueColor forState:UIControlStateSelected];
        [contentButton addTarget:self action:@selector(contentButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:contentButton];
        _contentButton = contentButton;
    }
    return _contentButton;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        stateLabel.font = [UIFont systemFontOfSize:15.0];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:stateLabel];
        _stateLabel = stateLabel;
    }
    return _stateLabel;
}

#pragma mark - Action
- (void)contentButtonAction {
    if ([self.contentButton.titleLabel.text integerValue] > 999) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", self.contentButton.titleLabel.text];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath InfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel {
    ZLElectronicInvitationGuestsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLElectronicInvitationGuestsReplyCell" forIndexPath:indexPath];
    ZLElectronicInvitationGuestsReplyModel *sectionModel = infoModel.sectionModels[infoModel.currentSection];
    ZLElectronicInvitationGuestsReplyModel *unitModel = sectionModel.unitModels[indexPath.row];
    cell.nameLabel.text = unitModel.title;
    cell.nameLabel.frame = CGRectMake(15.0, 15.0, unitModel.titleWidth, 20.0);
    cell.timeLabel.text = unitModel.time;
    cell.timeLabel.frame = CGRectMake(CGRectGetMaxX(cell.nameLabel.frame) + 20.0, 15.0, 130.0, 20.0);
    [cell.contentButton setTitle:unitModel.content forState:UIControlStateNormal];
    cell.stateLabel.frame = CGRectZero;
    cell.stateLabel.attributedText = nil;
    if (!infoModel.currentSection) {//祝福
        cell.contentButton.frame = CGRectMake(15.0, CGRectGetMaxY(cell.nameLabel.frame) + 10.0, UIScreen.mainScreen.bounds.size.width - 30.0, unitModel.contentHeight);
        cell.contentButton.selected = NO;
    }else if (infoModel.currentSection == 1) {//赴宴
        cell.contentButton.frame = CGRectMake(15.0, CGRectGetMaxY(cell.nameLabel.frame) + 10.0, UIScreen.mainScreen.bounds.size.width - 100.0, 20.0);
        cell.contentButton.selected = YES;
        cell.stateLabel.frame = CGRectMake(CGRectGetMaxX(cell.contentButton.frame), 0, 70.0, unitModel.cellHeight);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld人赴宴",unitModel.value]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0] range:NSMakeRange(0, [NSString stringWithFormat:@"%ld",unitModel.value].length)];
        cell.stateLabel.attributedText = attributedString;
    }else if (infoModel.currentSection == 2) {//待定
        cell.contentButton.frame = CGRectMake(15.0, CGRectGetMaxY(cell.nameLabel.frame) + 10.0, UIScreen.mainScreen.bounds.size.width - 100.0, 20.0);
        cell.contentButton.selected = YES;
        cell.stateLabel.frame = CGRectMake(CGRectGetMaxX(cell.contentButton.frame), 0, 70.0, unitModel.cellHeight);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"待定"];
        cell.stateLabel.attributedText = attributedString;
    }
    return cell;
}

@end
