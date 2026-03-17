//
//  ZLIntegralShopHomeTableHeaderView.m
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralShopHomeTableHeaderView.h"
#import "ZLIntegralShopHomeTableHeaderFunctionBar.h"
#import "ZLIntegralShopHomeTableHeaderBanner.h"

@interface ZLIntegralShopHomeTableHeaderView ()

//头部背景大图
@property (nonatomic,weak) UIImageView *iconImageView;
//背景大图的原始frame（缩放时用到）
@property (nonatomic,unsafe_unretained) CGRect iconImageOriginalFrame;
///承载功能条和轮播
@property (nonatomic,weak) UIView *unitsView;
///头像
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///事件条
@property (nonatomic,weak) ZLIntegralShopHomeTableHeaderFunctionBar *functionBar;
///横幅
@property (nonatomic,weak) ZLIntegralShopHomeTableHeaderBanner *banner;

@end

@implementation ZLIntegralShopHomeTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
        self.allowInteraction = NO;
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //头部背景大图
    [self iconImageView];
    //承载视图
    [self unitsView];
    //事件条
    [self functionBar];
    //头像
    [self iconButton];
    //标题
    [self titleLabel];
    //横幅
    [self banner];
}

#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 190.0)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"积分商城 渐变背景.png"];
        iconImageView.image = [UIImage imageWithContentsOfFile:path];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.backgroundColor = UIColor.blueColor;
        [self addSubview:iconImageView];
        _iconImageView = iconImageView;
        self.iconImageOriginalFrame = iconImageView.frame;
    }
    return _iconImageView;
}
- (UIView *)unitsView {
    if (!_unitsView) {
        UIView *unitsView = [[UIView alloc] initWithFrame:CGRectMake(0, 190.0, UIScreen.mainScreen.bounds.size.width, 246.0)];
        unitsView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self addSubview:unitsView];
        _unitsView = unitsView;
    }
    return _unitsView;
}
- (UIButton *)iconButton {
    if (!_iconButton) {
        CGFloat width = 55;
        CGFloat navHeight = 64.0;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - width) / 2 - 5.0, navHeight + 21.0, width + 10.0, width + 10.0)];
        view.backgroundColor = UIColor.whiteColor;
        view.layer.cornerRadius = (width + 10.0) / 2;
        view.layer.masksToBounds = YES;
        view.alpha = 0.2;
        [self addSubview:view];
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - width) / 2, navHeight + 26.0, width, width)];
        [iconButton setTitle:@"签到" forState:UIControlStateNormal];
        [iconButton setTitle:@"已签" forState:UIControlStateSelected];
        [iconButton setTitleColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0] forState:UIControlStateNormal];
        iconButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        iconButton.layer.cornerRadius = width / 2;
        iconButton.layer.masksToBounds = YES;
        [iconButton addTarget:self action:@selector(iconButtonAction) forControlEvents:UIControlEventTouchUpInside];
        iconButton.backgroundColor = UIColor.whiteColor;
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconButton.frame) + 10.0, UIScreen.mainScreen.bounds.size.width, 20.0)];
        titleLabel.textColor = UIColor.whiteColor;
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (ZLIntegralShopHomeTableHeaderFunctionBar *)functionBar {
    if (!_functionBar) {
        CGFloat height = 70.0;
        ZLIntegralShopHomeTableHeaderFunctionBar *functionBar = [[ZLIntegralShopHomeTableHeaderFunctionBar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height)];
        functionBar.subTitlesArray = @[@"我的积分",@"兑换记录"];
        functionBar.titlesArray = @[@"0",@"0"];
        __weak typeof(self)weakSelf = self;
        functionBar.function = ^(BOOL isIntegral) {
            if (weakSelf.function) {
                weakSelf.function(isIntegral);
            }
        };
        [self.unitsView addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
}
- (ZLIntegralShopHomeTableHeaderBanner *)banner {
    if (!_banner) {
        CGFloat height = 155.0;
        CGFloat space = (CGRectGetHeight(self.unitsView.frame) - CGRectGetHeight(self.functionBar.frame) - height) * 0.5;
        ZLIntegralShopHomeTableHeaderBanner *banner = [ZLIntegralShopHomeTableHeaderBanner integralShopHomeTableHeaderBannerWithFrame:CGRectMake(0, CGRectGetHeight(self.functionBar.frame) + space, UIScreen.mainScreen.bounds.size.width, height) PagingFrame:CGRectMake(20.0, 0, UIScreen.mainScreen.bounds.size.width - 40.0, height) Space:6.0];
        __weak typeof(self)weakSelf = self;
        banner.unitsClick = ^(NSInteger index) {
            if (weakSelf.bannerClick) {
                weakSelf.bannerClick(index);
            }
        };
        [self.unitsView addSubview:banner];
        _banner = banner;
    }
    return _banner;
}

#pragma mark - Set
- (void)setAllowInteraction:(BOOL)allowInteraction {
    _allowInteraction = allowInteraction;
    self.iconButton.userInteractionEnabled = allowInteraction;
    self.functionBar.userInteractionEnabled = allowInteraction;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setNumbersArray:(NSArray *)numbersArray {
    _numbersArray = numbersArray;
    self.functionBar.titlesArray = _numbersArray;
}
- (void)setSignState:(BOOL)signState {
    _signState = signState;
    self.iconButton.selected = signState;
    self.iconButton.userInteractionEnabled = !signState;
}
- (void)setBannerUrlsArray:(NSArray *)bannerUrlsArray {
    _bannerUrlsArray = bannerUrlsArray;
    self.banner.imageUrlsArray = _bannerUrlsArray;
}

#pragma mark - Action
- (void)iconButtonAction {
    if (self.sign) {
        self.sign();
    }
}

#pragma mark - Public
- (void)removeTimer {
    [self.banner removeTimer];
}
- (void)startTimer {
    [self.banner startTimer];
}
- (void)stopTimer {
    [self.banner stopTimer];
}
- (void)imageZoomWithOffsetY:(CGFloat)offsetY {
    if (offsetY < 0) {
        //水平缩放比例值
        CGFloat horizontalMagnifyValue = -offsetY / self.iconImageView.frame.size.height * self.iconImageView.frame.size.width;
        //更新frame
        self.iconImageView.frame = CGRectMake(-horizontalMagnifyValue, offsetY * 2, self.iconImageOriginalFrame.size.width + horizontalMagnifyValue * 2, self.iconImageOriginalFrame.size.height + (-offsetY) * 2);
    }
}
- (void)showAnimationLabelWithTodayObtainIntegralNumber:(NSString *)number {
    [self.functionBar showAnimationLabelWithTodayObtainIntegralNumber:number];
}

@end

