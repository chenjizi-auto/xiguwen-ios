//
//  ZLConversionDetailCommodityCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailGoodsCell.h"
#import <UIButton+AFNetworking.h>

@interface ZLConversionDetailGoodsCell ()

///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///状态
@property (nonatomic,weak) UILabel *stateLabel;
///角标
@property (nonatomic,weak) UIButton *boultButton;

@end

@implementation ZLConversionDetailGoodsCell

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
    ///状态
    [self stateLabel];
    ///角标
    [self boultButton];
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
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, 15.0, UIScreen.mainScreen.bounds.size.width - CGRectGetMaxX(self.iconButton.frame) - 55.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.text = @"<暂无标题>";
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10.0, CGRectGetWidth(self.titleLabel.frame), 20.0)];
        stateLabel.font = [UIFont systemFontOfSize:13.0];
        stateLabel.text = @"交易状态";
        [self.contentView addSubview:stateLabel];
        _stateLabel = stateLabel;
    }
    return _stateLabel;
}
- (UIButton *)boultButton {
    if (!_boultButton) {
        UIButton *boultButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 35.0, 0, 20, 115.0)];
        [boultButton setImage:[UIImage imageNamed:@"进入下一级"] forState:UIControlStateNormal];
        [self.contentView addSubview:boultButton];
        _boultButton = boultButton;
    }
    return _boultButton;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLConversionDetailModel *)model {
    ZLConversionDetailGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLConversionDetailGoodsCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLConversionDetailGoodsCell class])];
    }
    model = model.goodsModel.goodsModelsArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.stateLabel.textColor = model.stateColor;
    cell.stateLabel.text = model.state;
    [cell.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"square_placeholder_ small"]];
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, model.titleHeight);
    cell.stateLabel.frame = CGRectMake(cell.stateLabel.frame.origin.x, CGRectGetMaxY(cell.titleLabel.frame) + 10.0, cell.stateLabel.frame.size.width, cell.stateLabel.frame.size.height);
    return cell;
}

@end
