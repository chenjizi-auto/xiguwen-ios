//
//  ZLShopDetailsTimeUnitView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsTimeUnitView.h"

@interface ZLShopDetailsTimeUnitView ()

//标题
@property (nonatomic,weak) UILabel *titleLabel;
//子标题
@property (nonatomic,weak) UILabel *subTitleLabel;

@end

@implementation ZLShopDetailsTimeUnitView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //标题
    [self titleLabel];
    //子标题
    [self subTitleLabel];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsTimeUnitViewFont = 14.0;
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2)];
        titleLabel.text = @"00日";
        titleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsTimeUnitViewFont];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2)];
        subTitleLabel.text = @"上午";
        subTitleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsTimeUnitViewFont * 0.8];
        subTitleLabel.textColor = UIColor.lightGrayColor;
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subTitleLabel];
        _subTitleLabel = subTitleLabel;
    }
    return _subTitleLabel;
}

@end
