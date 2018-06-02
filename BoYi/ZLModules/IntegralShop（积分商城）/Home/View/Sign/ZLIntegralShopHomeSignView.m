//
//  ZLIntegralShopHomeSignView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralShopHomeSignView.h"
#import "ZLIntegralShopHomeSignUnitView.h"

@interface ZLIntegralShopHomeSignView ()

///蒙版
@property (nonatomic,weak) UIView *hudView;
///单元
@property (nonatomic,weak) UIView *unitView;
///顶部图片
@property (nonatomic,weak) UIImageView *topImageView;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///确认
@property (nonatomic,weak) UIButton *sureButton;
///上部分积分
@property (nonatomic,weak) UIView *topIntegralView;
///路径
@property (nonatomic,weak) UIButton *pathButton;
///下部分积分
@property (nonatomic,weak) UIView *bottomIntegralView;

@end

@implementation ZLIntegralShopHomeSignView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //蒙版
    [self hudView];
    //单元
    [self unitView];
}

#pragma mark - Lazy
- (UIView *)hudView {
    if (!_hudView) {
        UIView *hudView = [[UIView alloc] initWithFrame:self.bounds];
        hudView.backgroundColor = UIColor.blackColor;
        hudView.alpha = 0.5;
        [self addSubview:hudView];
        _hudView = hudView;
    }
    return _hudView;
}
- (UIView *)unitView {
    if (!_unitView) {
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(65.0, (UIScreen.mainScreen.bounds.size.height - 300.0) * 0.5, UIScreen.mainScreen.bounds.size.width - 130.0, 300.0)];
        unitView.layer.cornerRadius = 5.0;
        unitView.layer.masksToBounds = YES;
        unitView.clipsToBounds = NO;
        unitView.backgroundColor = UIColor.whiteColor;
        [self addSubview:unitView];
        _unitView = unitView;
        //子视图
        [self topImageView];
        [self titleLabel];
        [self sureButton];
        [self topIntegralView];
        [self pathButton];
        [self bottomIntegralView];
    }
    return _unitView;
}
- (UIImageView *)topImageView {
    if (!_topImageView) {
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-30.0, -20.0, CGRectGetWidth(self.unitView.frame) + 60.0, 60.0)];
        topImageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"签到弹窗 顶部.png"];
        topImageView.image = [UIImage imageWithContentsOfFile:path];
        [self.unitView addSubview:topImageView];
        _topImageView = topImageView;
    }
    return _topImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.topImageView.frame), CGRectGetWidth(self.unitView.frame) - 30.0, 20.0)];
        titleLabel.text = @"连续签到3天";
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.unitView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(25.0, CGRectGetHeight(self.unitView.frame) - 60.0, CGRectGetWidth(self.unitView.frame) - 50.0, 40.0)];
        sureButton.backgroundColor = self.titleLabel.textColor;
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        sureButton.layer.cornerRadius = 3.0;
        sureButton.layer.masksToBounds = YES;
        [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.unitView addSubview:sureButton];
        _sureButton = sureButton;
    }
    return _sureButton;
}
- (UIView *)topIntegralView {
    if (!_topIntegralView) {
        UIView *topIntegralView = [[UIView alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleLabel.frame) + 10.0, CGRectGetWidth(self.unitView.frame) - 30.0, 50.0)];
        CGFloat space = (CGRectGetWidth(topIntegralView.frame) - 45.0 * 4) / 3;
        for (NSInteger index = 0; index < 4; index++) {
            ZLIntegralShopHomeSignUnitView *unitView = [[ZLIntegralShopHomeSignUnitView alloc] initWithFrame:CGRectMake((45.0 + space) * index, 0, 45.0, 50.0)];
            [topIntegralView addSubview:unitView];
        }
        [self.unitView addSubview:topIntegralView];
        _topIntegralView = topIntegralView;
    }
    return _topIntegralView;
}
- (UIButton *)pathButton {
    if (!_pathButton) {
        UIButton *pathButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.topIntegralView.frame), CGRectGetMaxY(self.topIntegralView.frame), CGRectGetWidth(self.topIntegralView.frame), 60.0)];
        pathButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.unitView addSubview:pathButton];
        _pathButton = pathButton;
    }
    return _pathButton;
}
- (UIView *)bottomIntegralView {
    if (!_bottomIntegralView) {
        UIView *bottomIntegralView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.topIntegralView.frame) + 3.0, CGRectGetMaxY(self.pathButton.frame), CGRectGetWidth(self.topIntegralView.frame) - 6.0, 50.0)];
        CGFloat space = (CGRectGetWidth(bottomIntegralView.frame) - 45.0 * 4) / 3;
        for (NSInteger index = 0; index < 3; index++) {
            ZLIntegralShopHomeSignUnitView *unitView = [[ZLIntegralShopHomeSignUnitView alloc] initWithFrame:CGRectMake(CGRectGetWidth(bottomIntegralView.frame) - 45.0 -(45.0 + space) * index, 0, 45.0, 50.0)];
            [bottomIntegralView addSubview:unitView];
        }
        [self.unitView addSubview:bottomIntegralView];
        _bottomIntegralView = bottomIntegralView;
    }
    return _bottomIntegralView;
}

#pragma mark - Set
- (void)setSignModel:(ZLIntegralShopHomeModel *)signModel {
    _signModel = signModel;
    [self giveValues];
}

#pragma mark - Separate
- (void)giveValues {
    self.titleLabel.text = [NSString stringWithFormat:@"连续签到%@天",self.signModel.ongoingSignDayNumber];
    NSInteger number = self.signModel.ongoingSignDayNumber.integerValue;
    NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"签到%ld天.png",number]];
    [self.pathButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    NSInteger count = self.signModel.ongoingSignIntegralsArray.count <= self.topIntegralView.subviews.count + self.bottomIntegralView.subviews.count ? self.signModel.ongoingSignIntegralsArray.count : self.topIntegralView.subviews.count + self.bottomIntegralView.subviews.count;
    for (NSInteger index = 0; index < count; index++) {
        if (index < 4) {
            ZLIntegralShopHomeSignUnitView *unitView = self.topIntegralView.subviews[index];
            unitView.title = self.signModel.ongoingSignIntegralsArray[index];
        }else {
            ZLIntegralShopHomeSignUnitView *unitView = self.bottomIntegralView.subviews[index - 4];
            unitView.title = self.signModel.ongoingSignIntegralsArray[index];
        }
    }
}

#pragma mark - Action
- (void)sureButtonAction {
    if (self.updateInterface) {
        self.updateInterface();
    }
    [self removeFromSuperview];
    if (self.signModel) {
        //释放数据
        self.signModel = nil;
    }
}

@end
