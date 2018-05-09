//
//  ZLShopDetailsContactWayBar.m
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsContactWayBar.h"

@interface ZLShopDetailsContactWayBar ()

//地址图标
@property (nonatomic,weak) UIButton *addressIconButton;
//地址文本
@property (nonatomic,weak) UILabel *addressTitleLabel;
//联系电话
@property (nonatomic,weak) UIButton *phoneButton;

@end

@implementation ZLShopDetailsContactWayBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //地址图标
    [self addressIconButton];
    //地址文本
    [self addressTitleLabel];
    //联系电话
    [self phoneButton];
}

//单元控件高度
CGFloat const ZLShopDetailsContactWayBarSubviewTopLineHeight = 1.0;
CGFloat const ZLShopDetailsContactWayBarSubviewHeight = 49.0;
CGFloat const ZLShopDetailsContactWayBarAddressIconButtonWidth = 40.0;
#pragma mark - Lazy
- (UIButton *)addressIconButton {
    if (!_addressIconButton) {
        UIButton *addressIconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ZLShopDetailsContactWayBarSubviewTopLineHeight, ZLShopDetailsContactWayBarAddressIconButtonWidth, ZLShopDetailsContactWayBarSubviewHeight)];
        [addressIconButton setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
        addressIconButton.backgroundColor = UIColor.whiteColor;
        addressIconButton.userInteractionEnabled = NO;
        [self addSubview:addressIconButton];
        _addressIconButton = addressIconButton;
    }
    return _addressIconButton;
}
- (UILabel *)addressTitleLabel {
    if (!_addressTitleLabel) {
        UILabel *addressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.addressIconButton.frame), ZLShopDetailsContactWayBarSubviewTopLineHeight, UIScreen.mainScreen.bounds.size.width - ZLShopDetailsContactWayBarSubviewHeight - ZLShopDetailsContactWayBarAddressIconButtonWidth, ZLShopDetailsContactWayBarSubviewHeight)];
        addressTitleLabel.font = [UIFont systemFontOfSize:14.0];
        addressTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        addressTitleLabel.numberOfLines = 2;
        addressTitleLabel.text = @"<暂无地址信息>";
        addressTitleLabel.backgroundColor = UIColor.whiteColor;
        addressTitleLabel.textColor = UIColor.lightGrayColor;
        [self addSubview:addressTitleLabel];
        _addressTitleLabel = addressTitleLabel;
    }
    return _addressTitleLabel;
}
- (UIButton *)phoneButton {
    if (!_phoneButton) {
        UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - ZLShopDetailsContactWayBarSubviewHeight, ZLShopDetailsContactWayBarSubviewTopLineHeight, ZLShopDetailsContactWayBarSubviewHeight, ZLShopDetailsContactWayBarSubviewHeight)];
        [phoneButton setImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
        phoneButton.backgroundColor = UIColor.whiteColor;
        [self addSubview:phoneButton];
        _phoneButton = phoneButton;
    }
    return _phoneButton;
}

#pragma mark - Set
- (void)setAddress:(NSString *)address {
    _address = address;
    self.addressTitleLabel.text = address;
}

@end
