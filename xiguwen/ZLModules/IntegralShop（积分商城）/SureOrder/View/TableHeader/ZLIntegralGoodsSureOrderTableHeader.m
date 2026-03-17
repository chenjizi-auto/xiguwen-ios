//
//  ZLIntegralGoodsSureOrderTableHeader.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsSureOrderTableHeader.h"

@interface ZLIntegralGoodsSureOrderTableHeader ()

///底部分割线
@property (nonatomic,weak) CALayer *bottomLineLayer;
///图标
@property (nonatomic,weak) UIButton *iconButton;
///姓名
@property (nonatomic,weak) UILabel *nameLabel;
///电话
@property (nonatomic,weak) UILabel *phoneLabel;
///地址
@property (nonatomic,weak) UILabel *siteLabel;
///箭头
@property (nonatomic,weak) UIButton *arrowsButton;

@end

@implementation ZLIntegralGoodsSureOrderTableHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)]];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self bottomLineLayer];
    [self iconButton];
    [self nameLabel];
    [self phoneLabel];
    [self siteLabel];
    [self arrowsButton];
}

#pragma mark - Lazy
- (CALayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 70.0, UIScreen.mainScreen.bounds.size.width, 10.0);
        layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        [self.layer addSublayer:layer];
        _bottomLineLayer = layer;
    }
    return _bottomLineLayer;
}
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50.0, self.bounds.size.height - 10.0)];
        iconButton.userInteractionEnabled = NO;
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"收货地址.png"];
        [iconButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame), 10.0, UIScreen.mainScreen.bounds.size.width - 200.0, 20.0)];
        nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 10.0, 100.0, 20.0)];
        phoneLabel.font = [UIFont systemFontOfSize:14.0];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
    }
    return _phoneLabel;
}
- (UILabel *)siteLabel {
    if (!_siteLabel) {
        UILabel *siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame), CGRectGetMaxY(self.nameLabel.frame) + 10.0, CGRectGetWidth(self.nameLabel.frame) + 100.0, 20.0)];
        siteLabel.numberOfLines = 0;
        siteLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:siteLabel];
        _siteLabel = siteLabel;
    }
    return _siteLabel;
}
- (UIButton *)arrowsButton {
    if (!_arrowsButton) {
        UIButton *arrowsButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 50.0, 0, 50.0, self.bounds.size.height - 10.0)];
        arrowsButton.userInteractionEnabled = NO;
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"进入下一级.png"];
        [arrowsButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self addSubview:arrowsButton];
        _arrowsButton = arrowsButton;
    }
    return _arrowsButton;
}

#pragma mark - Set
- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = _name;
}
- (void)setPhone:(NSString *)phone {
    _phone = phone;
    self.phoneLabel.text = _phone;
}
- (void)setAddress:(NSString *)address {
    _address = address;
    self.siteLabel.text = _address;
}
- (void)setAddressHeight:(CGFloat)addressHeight {
    _addressHeight = addressHeight;
    self.siteLabel.frame = CGRectMake(self.siteLabel.frame.origin.x, self.siteLabel.frame.origin.y, self.siteLabel.frame.size.width, _addressHeight);
    self.bottomLineLayer.frame = CGRectMake(self.bottomLineLayer.frame.origin.x, CGRectGetMaxY(self.siteLabel.frame) + 10.0, self.bottomLineLayer.frame.size.width, self.bottomLineLayer.frame.size.height);
    self.arrowsButton.frame = CGRectMake(self.arrowsButton.frame.origin.x, self.arrowsButton.frame.origin.y, self.arrowsButton.frame.size.width, CGRectGetMaxY(self.siteLabel.frame) + 10.0);
    self.iconButton.frame = CGRectMake(self.iconButton.frame.origin.x, self.iconButton.frame.origin.y, self.iconButton.frame.size.width, CGRectGetMaxY(self.siteLabel.frame) + 10.0);
}

#pragma mark - Action
- (void)tapGestureRecognizerAction {
    if (self.clickAddress) {
        self.clickAddress();
    }
}

@end
