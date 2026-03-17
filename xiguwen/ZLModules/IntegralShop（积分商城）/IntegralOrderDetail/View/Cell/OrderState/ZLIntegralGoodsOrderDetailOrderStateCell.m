//
//  ZLIntegralGoodsOrderDetailOrderStateCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailOrderStateCell.h"

@interface ZLIntegralGoodsOrderDetailOrderStateCell ()

///背景
@property (nonatomic,weak) UIImageView *bgImgeView;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///计时
@property (nonatomic,weak) UILabel *timeLabel;
///状态值
@property (nonatomic,strong) NSArray *orderStatesArray;

@end

@implementation ZLIntegralGoodsOrderDetailOrderStateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self bgImgeView];
    [self titleLabel];
}

#pragma mark - Lazy
- (UIImageView *)bgImgeView {
    if (!_bgImgeView) {
        UIImageView *bgImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 90.0)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"订单详情 背景图.png"];
        bgImgeView.image = [UIImage imageWithContentsOfFile:path];
        [self.contentView addSubview:bgImgeView];
        _bgImgeView = bgImgeView;
    }
    return _bgImgeView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 20.0, UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17.0];
        titleLabel.textColor = UIColor.whiteColor;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleLabel.frame) + 10.0, UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        timeLabel.font = [UIFont systemFontOfSize:13.0];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = UIColor.whiteColor;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (NSArray *)orderStatesArray {
    if (!_orderStatesArray) {
        _orderStatesArray = @[@"待付款",@"待发货",@"待收货",@"交易成功",@"交易关闭"];
    }
    return _orderStatesArray;
}

#pragma mark - Set
- (void)setCurrentCountdown:(int)currentCountdown {
    _currentCountdown = currentCountdown;
    if (!currentCountdown) {
        self.timeLabel.hidden = YES;
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, 35.0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        return;
    }
    if (self.timeLabel.hidden) {
        self.timeLabel.hidden = NO;
    }
    int minute = floor(currentCountdown / 60.0);
    int second = currentCountdown - minute * 60;
    int hours = floor(minute / 60.0);
    minute = minute - hours * 60;
    if (!hours) {
        self.timeLabel.text = [NSString stringWithFormat:@"剩余%d分%d秒自动关闭",minute,second];
    }else if (!hours && !minute) {
        self.timeLabel.text = [NSString stringWithFormat:@"剩余%d秒自动关闭",second];
    }else {
        self.timeLabel.text = [NSString stringWithFormat:@"剩余%d小时%d分%d秒自动关闭",hours,minute,second];
    }
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model {
    ZLIntegralGoodsOrderDetailOrderStateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailOrderStateCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailOrderStateCell class])];
    }
    cell.titleLabel.text = nil;
    cell.titleLabel.frame = (model.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay)
                          ? CGRectMake(cell.titleLabel.frame.origin.x, 20.0, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height)
                          : CGRectMake(cell.titleLabel.frame.origin.x, 35.0, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
    
    if (model.orderState <= cell.orderStatesArray.count && model.orderState) {
        cell.titleLabel.text = cell.orderStatesArray[model.orderState - 1];
    }
    
    if (model.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay) {
        cell.timeLabel.text = @"重新计算中……";
        cell.timeLabel.hidden = NO;
    }else {
        cell.timeLabel.hidden = YES;
    }
    return cell;
}

@end
