//
//  ZLIntegralShopHomeTableHeaderFunctionBar.m
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeTableHeaderFunctionBar.h"
#import "ZLIntegralShopHomeTableHeaderFunctionView.h"

@interface ZLIntegralShopHomeTableHeaderFunctionBar ()

///单元父视图
@property (nonatomic,weak) UIView *unitsView;
///加分动画
@property (nonatomic,weak) UILabel *animationLabel;

@end

@implementation ZLIntegralShopHomeTableHeaderFunctionBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        self.clipsToBounds = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //单元父视图
    [self unitsView];
}

#pragma mark - Lazy
- (UIView *)unitsView {
    if (!_unitsView) {
        UIView *unitsView = [[UIView alloc] initWithFrame:CGRectMake(50.0, 0, UIScreen.mainScreen.bounds.size.width - 100.0, self.bounds.size.height)];
        [self addSubview:unitsView];
        _unitsView = unitsView;
    }
    return _unitsView;
}
- (UILabel *)animationLabel {
    if (!_animationLabel) {
        UILabel *animationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        animationLabel.alpha = 0;
        animationLabel.font = [UIFont boldSystemFontOfSize:0];
        animationLabel.textColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
        [self addSubview:animationLabel];
        _animationLabel = animationLabel;
    }
    return _animationLabel;
}

#pragma mark - Set
- (void)setSubTitlesArray:(NSArray *)subTitlesArray {
    _subTitlesArray = subTitlesArray;
    //展示
    [self showItems];
}
- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
    //赋值
    [self giveValues];
}

#pragma mark - Action
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap {
    if (self.function) {
        BOOL isIntegral = tap.view == self.unitsView.subviews[0] ? YES : NO;
        self.function(isIntegral);
    }
}

#pragma mark - Separate
- (void)showItems {
    CGFloat width = self.unitsView.frame.size.width / _subTitlesArray.count;
    CGFloat count = _subTitlesArray.count;
    if (!self.unitsView.subviews.count) {
        for (NSInteger index = 0; index < count; index++) {
            ZLIntegralShopHomeTableHeaderFunctionView *unitView = [[ZLIntegralShopHomeTableHeaderFunctionView alloc] initWithFrame:CGRectMake(width * index, 10.0, width, self.unitsView.frame.size.height - 20.0)];
            unitView.subTitle = _subTitlesArray[index];
            [unitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)]];
            [self.unitsView addSubview:unitView];
            if (index < count - 1) {
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(CGRectGetMaxX(unitView.frame), 15.0, 1.0, self.unitsView.bounds.size.height - 30.0);
                layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
                [self.unitsView.layer addSublayer:layer];
            }
        }
    }
}
- (void)giveValues {
    for (NSInteger index = 0; index < _titlesArray.count; index++) {
        ((ZLIntegralShopHomeTableHeaderFunctionView *)self.unitsView.subviews[index]).title = _titlesArray[index];
    }
}

#pragma mark - Public
- (void)showAnimationLabelWithTodayObtainIntegralNumber:(NSString *)number {
    //整理数据
    self.animationLabel.text = [NSString stringWithFormat:@"+%@",number];
    CGSize size = [self.animationLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:30.0]} context:nil].size;
    CGRect frame = [self.unitsView convertRect:self.unitsView.subviews[0].frame toView:self];
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat x = CGRectGetMaxX(frame) - width;
    self.animationLabel.frame = CGRectMake(x, frame.origin.y + height * 0.4, 0, 0);
    //先在原处渐大渐显
    [UIView animateWithDuration:0.25 animations:^{
        self.animationLabel.font = [UIFont boldSystemFontOfSize:30.0];
        self.animationLabel.alpha = 1;
        CGRect frame = [self.unitsView convertRect:self.unitsView.subviews[0].frame toView:self];
        self.animationLabel.frame = CGRectMake(x, frame.origin.y - height * 0.1, width, height);
    } completion:^(BOOL finished) {
        //移至上方降低可见度
        [UIView animateWithDuration:0.5 animations:^{
            self.animationLabel.frame = CGRectMake(x, frame.origin.y - height * 0.1 - 40.0, width, height);
            self.animationLabel.alpha = 0;
        } completion:^(BOOL finished) {
            //移除控件
            [self.animationLabel removeFromSuperview];
            //更新界面
            ZLIntegralShopHomeTableHeaderFunctionView *unitView = self.unitsView.subviews[0];
            unitView.title = [NSString stringWithFormat:@"%ld",[unitView.title integerValue] + [number integerValue]];
        }];
    }];
}

@end
