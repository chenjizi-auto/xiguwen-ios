//
//  ZLIntegralGoodsOrderDetailAddressCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailAddressCell.h"

@interface ZLIntegralGoodsOrderDetailAddressCell ()

///底部分割线
@property (nonatomic,weak) CALayer *bottomLineLayer;
///图标
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *nameLabel;
///电话
@property (nonatomic,weak) UILabel *phoneLabel;
///地址
@property (nonatomic,weak) UILabel *addressLabel;
///标题
@property (nonatomic,weak) UIButton *titleButton;

@end

@implementation ZLIntegralGoodsOrderDetailAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self iconButton];
    [self nameLabel];
    [self phoneLabel];
    [self addressLabel];
    [self bottomLineLayer];
    [self titleButton];
}

#pragma mark - Lazy
- (CALayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, CGRectGetMaxY(self.addressLabel.frame) + 20.0, UIScreen.mainScreen.bounds.size.width, 10.0);
        layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        [self.contentView.layer addSublayer:layer];
        _bottomLineLayer = layer;
    }
    return _bottomLineLayer;
}
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50.0, 80.0)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"收货地址.png"];
        [iconButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame), 20.0, UIScreen.mainScreen.bounds.size.width - CGRectGetMaxX(self.iconButton.frame) - 115.0, 20.0)];
        nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 20.0, 100.0, 20.0)];
        phoneLabel.font = [UIFont systemFontOfSize:14.0];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame), CGRectGetMaxY(self.nameLabel.frame) + 10.0, CGRectGetWidth(self.nameLabel.frame) + 100.0, 40.0)];
        addressLabel.numberOfLines = 0;
        addressLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:addressLabel];
        _addressLabel = addressLabel;
    }
    return _addressLabel;
}
- (UIButton *)titleButton {
    if (!_titleButton) {
        UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.bottomLineLayer.frame), UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"商家.png"];
        [titleButton setTitle:@"  喜GO" forState:UIControlStateNormal];
        titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:titleButton];
        _titleButton = titleButton;
    }
    return _titleButton;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLIntegralGoodsOrderDetailModel *)model {
    ZLIntegralGoodsOrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailAddressCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailAddressCell class])];
    }
    cell.nameLabel.text = model.name;
    cell.addressLabel.text = model.address;
    cell.phoneLabel.text = model.phone;
    cell.addressLabel.frame = CGRectMake(cell.addressLabel.frame.origin.x, cell.addressLabel.frame.origin.y, cell.addressLabel.frame.size.width, model.addressHeight);
    cell.bottomLineLayer.frame = CGRectMake(cell.bottomLineLayer.frame.origin.x, CGRectGetMaxY(cell.addressLabel.frame) + 20.0, cell.bottomLineLayer.frame.size.width, cell.bottomLineLayer.frame.size.height);
    cell.titleButton.frame = CGRectMake(cell.titleButton.frame.origin.x, CGRectGetMaxY(cell.bottomLineLayer.frame), cell.titleButton.frame.size.width, cell.titleButton.frame.size.height);
    cell.iconButton.frame = CGRectMake(cell.iconButton.frame.origin.x, cell.iconButton.frame.origin.y, cell.iconButton.frame.size.width, CGRectGetMinY(cell.bottomLineLayer.frame));
    return cell;
}

@end
