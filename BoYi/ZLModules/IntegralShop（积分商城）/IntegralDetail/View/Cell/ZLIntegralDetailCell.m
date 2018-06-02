//
//  ZLIntegralDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralDetailCell.h"
#import "ZLIntegralDetailModel.h"

@interface ZLIntegralDetailCell ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///时间
@property (nonatomic,weak) UILabel *timeLabel;
///分数
@property (nonatomic,weak) UILabel *scoreLabel;

@end

@implementation ZLIntegralDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///标题
    [self titleLabel];
    ///时间
    [self timeLabel];
    ///分数
    [self scoreLabel];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, UIScreen.mainScreen.bounds.size.width - 80.0, 30.0)];
        titleLabel.text = @"<暂无标题>";
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.titleLabel.frame), 20.0)];
        timeLabel.text = @"<暂无时间>";
        timeLabel.font = [UIFont systemFontOfSize:11.0];
        timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 65.0, 0, 50.0, 70.0)];
        scoreLabel.text = @"+0";
        scoreLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:scoreLabel];
        _scoreLabel = scoreLabel;
    }
    return _scoreLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(id)model {
    ZLIntegralDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralDetailCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralDetailCell class])];
    }
    ZLIntegralDetailModel *unitModel = model;
    cell.titleLabel.text = unitModel.title;
    cell.timeLabel.text = unitModel.time;
    cell.scoreLabel.text = unitModel.integral;
    return cell;
}

@end
