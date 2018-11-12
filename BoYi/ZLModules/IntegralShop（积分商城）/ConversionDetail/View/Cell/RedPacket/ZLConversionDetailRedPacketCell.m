//
//  ZLConversionDetailRedPacketCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailRedPacketCell.h"
#import <UIButton+AFNetworking.h>

@interface ZLConversionDetailRedPacketCell ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///时间
@property (nonatomic,weak) UILabel *timeLabel;
///积分
@property (nonatomic,weak) UILabel *integralLabel;
///状态
@property (nonatomic,weak) UILabel *stateLabel;

@end

@implementation ZLConversionDetailRedPacketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///图标
    [self iconButton];
    ///标题
    [self titleLabel];
    ///时间
    [self timeLabel];
    ///积分
    [self integralLabel];
    ///状态
    [self stateLabel];
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 15.0, 85.0, 85.0)];
        iconButton.userInteractionEnabled = NO;
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, 15.0, UIScreen.mainScreen.bounds.size.width - CGRectGetMaxX(self.iconButton.frame) - 90.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.text = @"<暂无标题>";
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)integralLabel {
    if (!_integralLabel) {
        UILabel *integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10.0, CGRectGetWidth(self.titleLabel.frame), 20.0)];
        integralLabel.font = [UIFont systemFontOfSize:14.0];
        integralLabel.text = @"<暂无积分>";
        [self.contentView addSubview:integralLabel];
        _integralLabel = integralLabel;
    }
    return _integralLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.integralLabel.frame) + 10.0, CGRectGetWidth(self.titleLabel.frame), 20.0)];
        timeLabel.textColor = UIColor.lightGrayColor;
        timeLabel.font = [UIFont systemFontOfSize:12.0];
        timeLabel.text = @"<暂无时间>";
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 80.0, 0, 80.0, 115.0)];
        stateLabel.text = @"兑换成功";
        stateLabel.font = [UIFont systemFontOfSize:14.0];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:stateLabel];
        _stateLabel = stateLabel;
    }
    return _stateLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLConversionDetailModel *)model {
    ZLConversionDetailRedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLConversionDetailRedPacketCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLConversionDetailRedPacketCell class])];
    }
    model = model.redPacketModel.redPacketModelsArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.stateLabel.textColor = model.stateColor;
    cell.stateLabel.text = model.state;
    cell.timeLabel.text = model.time;
    cell.integralLabel.text = model.integral;
    [cell.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"square_placeholder_ small"]];
    return cell;
}

@end
