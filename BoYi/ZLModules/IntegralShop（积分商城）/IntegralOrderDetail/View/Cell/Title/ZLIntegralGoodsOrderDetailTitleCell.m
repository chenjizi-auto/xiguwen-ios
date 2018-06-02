//
//  ZLIntegralGoodsOrderDetailTitleCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailTitleCell.h"

@interface ZLIntegralGoodsOrderDetailTitleCell ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ZLIntegralGoodsOrderDetailTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self titleLabel];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        titleLabel.text = @"猜你喜欢";
        titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = UIColor.lightGrayColor;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    ZLIntegralGoodsOrderDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailTitleCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailTitleCell class])];
    }
    return cell;
}

@end
