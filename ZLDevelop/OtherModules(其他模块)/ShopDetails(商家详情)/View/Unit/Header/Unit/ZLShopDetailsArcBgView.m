//
//  ZLShopDetailsArcBgView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsArcBgView.h"

@interface ZLShopDetailsArcBgView ()

//头像
@property (nonatomic,weak) UIImageView *iconImageView;
//标题
@property (nonatomic,weak) UILabel *titleLabel;
//荣誉
@property (nonatomic,weak) UIView *honorView;
//职位
@property (nonatomic,weak) UILabel *positionLabel;
//等级
@property (nonatomic,weak) UIView *gradeView;
//浏览、成交、好评
@property (nonatomic,weak) UIView *toolBar;

@end

@implementation ZLShopDetailsArcBgView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"弧形 底"];
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //头像
    [self iconImageView];
    //标题
    [self titleLabel];
    //荣誉
    [self honorView];
    //职位
    [self positionLabel];
    //等级
    [self gradeView];
    //浏览、成交、好评
    [self toolBar];
}

//单元控件高度
CGFloat const ZLShopDetailsArcBgViewIconImageViewHeight = 70.0;
CGFloat const ZLShopDetailsArcBgViewTitleLabelHeight = 20.0;
CGFloat const ZLShopDetailsArcBgViewTitleLabelFont = 17.0;
#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        CGFloat centerX = UIScreen.mainScreen.bounds.size.width / 2 - ZLShopDetailsArcBgViewIconImageViewHeight / 2;
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(centerX, -ZLShopDetailsArcBgViewIconImageViewHeight / 5, ZLShopDetailsArcBgViewIconImageViewHeight, ZLShopDetailsArcBgViewIconImageViewHeight)];
        iconImageView.image = [UIImage imageNamed:@"头像"];
        iconImageView.layer.cornerRadius = ZLShopDetailsArcBgViewIconImageViewHeight / 2;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.borderWidth = 4.0;
        iconImageView.layer.borderColor = UIColor.whiteColor.CGColor;
        [self addSubview:iconImageView];
        _iconImageView = iconImageView;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:ZLShopDetailsArcBgViewTitleLabelFont];
        titleLabel.text = @"<暂无抬头>";
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        [self titleLabelCenterAlignment];
    }
    return _titleLabel;
}
- (UIView *)honorView {
    if (!_honorView) {
        UIView *honorView = [[UIView alloc] init];
        [self addSubview:honorView];
        _honorView = honorView;
    }
    return _honorView;
}
- (UILabel *)positionLabel {
    if (!_positionLabel) {
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), UIScreen.mainScreen.bounds.size.width - 30.0, 20)];
        positionLabel.textColor = UIColor.lightGrayColor;
        positionLabel.font = [UIFont systemFontOfSize:ZLShopDetailsArcBgViewTitleLabelFont * 0.7];
        [self addSubview:positionLabel];
        _positionLabel = positionLabel;
    }
    return _positionLabel;
}
- (UIView *)gradeView {
    if (!_gradeView) {
        UIView *gradeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:gradeView];
        _gradeView = gradeView;
    }
    return _gradeView;
}
- (UIView *)toolBar {
    if (!_toolBar) {
        UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:toolBar];
        _toolBar = toolBar;
    }
    return _toolBar;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self titleLabelCenterAlignment];
}
- (void)setHonorsArray:(NSArray *)honorsArray {
    _honorsArray = honorsArray;
    [self showHonorsItems];
}
- (void)setPosition:(NSString *)position {
    _position = position;
    self.positionLabel.text = position;
}

#pragma mark - Separate
- (void)titleLabelCenterAlignment {
    CGSize size = [_titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZLShopDetailsArcBgViewTitleLabelFont]} context:nil].size;
    CGFloat width = UIScreen.mainScreen.bounds.size.width / 3;
    width = size.width > width ? width : size.width;
    _titleLabel.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width - width) / 2, CGRectGetMaxY(self.iconImageView.frame), width, ZLShopDetailsArcBgViewTitleLabelHeight);
}
- (void)showHonorsItems {
    NSInteger count = _honorsArray.count > 4 ? 4 : _honorsArray.count;
    CGFloat maxX = 0;
    for (NSInteger index = 0; index < count; index++) {
        UIImage *image = [UIImage imageNamed:_honorsArray[index]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.origin = CGPointMake(maxX, (ZLShopDetailsArcBgViewTitleLabelHeight - image.size.height) / 2);
        [self.honorView addSubview:imageView];
        maxX = CGRectGetMaxX(imageView.frame) + 3.0;
    }
    self.honorView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame), maxX, ZLShopDetailsArcBgViewTitleLabelHeight);
}

@end
