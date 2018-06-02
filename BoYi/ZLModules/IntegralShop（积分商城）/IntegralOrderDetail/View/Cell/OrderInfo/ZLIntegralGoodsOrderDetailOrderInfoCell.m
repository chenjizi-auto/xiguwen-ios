//
//  ZLIntegralGoodsOrderDetailOrderInfoCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailOrderInfoCell.h"

@interface ZLIntegralGoodsOrderDetailOrderInfoCell ()

///编号
@property (nonatomic,weak) UILabel *numberLabel;
///下单时间
@property (nonatomic,weak) UILabel *orderTimeLabel;
///付款时间
@property (nonatomic,weak) UILabel *payTimeLabel;

@end

@implementation ZLIntegralGoodsOrderDetailOrderInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

#pragma mark - Lazy
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        numberLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}
- (UILabel *)orderTimeLabel {
    if (!_orderTimeLabel) {
        UILabel *orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.numberLabel.frame), UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        orderTimeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:orderTimeLabel];
        _orderTimeLabel = orderTimeLabel;
    }
    return _orderTimeLabel;
}
- (UILabel *)payTimeLabel {
    if (!_payTimeLabel) {
        UILabel *payTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.orderTimeLabel.frame), UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        payTimeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:payTimeLabel];
        _payTimeLabel = payTimeLabel;
    }
    return _payTimeLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model {
    ZLIntegralGoodsOrderDetailOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailOrderInfoCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailOrderInfoCell class])];
    }
    cell.payTimeLabel.hidden = YES;
    cell.numberLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNumber];
    cell.orderTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.orderTime];
    if (model.orderState == ZLIntegralGoodsOrderDetailTypeWaitingSend
        || model.orderState == ZLIntegralGoodsOrderDetailTypeWaitingReceive
        || model.orderState == ZLIntegralGoodsOrderDetailTypeDealSuccessful) {
        cell.payTimeLabel.hidden = NO;
        cell.payTimeLabel.text = [NSString stringWithFormat:@"付款时间：%@",model.payTime];
    }
    return cell;
}

@end
