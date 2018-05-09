//
//  ZLShopDetailsDynamicSuspendBar.m
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//ZLShopDetailsContactWayBar

#import "ZLShopDetailsDynamicSuspendBar.h"

@interface ZLShopDetailsDynamicSuspendBar ()

//透视层
@property (nonatomic,weak) UIVisualEffectView *visualEffectView;
//单元按钮的父视图
@property (nonatomic,weak) UIView *itemSuperview;
//跟踪条
@property (nonatomic,weak) UIView *trackBar;
//点击的item
@property (nonatomic,weak) UIButton *didClickButton;

@end

@implementation ZLShopDetailsDynamicSuspendBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //透视层
    [self visualEffectView];
    //单元按钮的父视图
    [self itemSuperview];
}

//单元控件高度
CGFloat const ZLShopDetailsDynamicSuspendTrackBarWidthIndentation = 5.0;
#pragma mark - Lazy
- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        _visualEffectView = effectView;
        //线条
        CALayer *layer = [CALayer new];
        CGFloat lineHeight = 0.25;
        layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        layer.frame = CGRectMake(0, self.frame.size.height - lineHeight, UIScreen.mainScreen.bounds.size.width, lineHeight);
        [effectView.layer addSublayer:layer];
    }
    return _visualEffectView;
}
- (UIView *)itemSuperview {
    if (!_itemSuperview) {
        UIView *itemSuperview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:itemSuperview];
        _itemSuperview = itemSuperview;
    }
    return _itemSuperview;
}
- (UIView *)trackBar {
    if (!_trackBar) {
        UIButton *button = self.itemSuperview.subviews[0];
        CGRect frame = [self.itemSuperview convertRect:button.frame toView:self];
        UIView *trackBar = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x + ZLShopDetailsDynamicSuspendTrackBarWidthIndentation, frame.size.height - 2.0, frame.size.width - ZLShopDetailsDynamicSuspendTrackBarWidthIndentation * 2, 2.0)];
        trackBar.backgroundColor = [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0];
        [self addSubview:trackBar];
        _trackBar = trackBar;
    }
    return _trackBar;
}

#pragma mark - Set
- (void)setTitlesArray:(NSArray<NSString *> *)titlesArray {
    _titlesArray = titlesArray;
    //展示按钮
    [self showItems];
}

#pragma mark - separate
- (void)showItems {
    //创建items
    CGFloat width = UIScreen.mainScreen.bounds.size.width / _titlesArray.count;
    for (NSInteger index = 0; index < _titlesArray.count; index++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * index, 0, width, CGRectGetHeight(self.itemSuperview.frame))];
        [button setTitle:_titlesArray[index] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0] forState:(UIControlStateSelected)];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button addTarget:self action:@selector(itemsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemSuperview addSubview:button];
        //tag 从1递增
        button.tag = index + 1;
        //响应第一个item
        if (!index) {
            button.selected = YES;
            self.didClickButton = button;
            [self itemsAction:button];
        }
    }
    //创建跟踪条
    [self trackBar];
}

#pragma mark - Action
- (void)itemsAction:(UIButton *)sender {//tag 从1递增
    //跟随
    CGRect frame = [self.itemSuperview convertRect:sender.frame toView:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.trackBar.frame = CGRectMake(frame.origin.x + ZLShopDetailsDynamicSuspendTrackBarWidthIndentation, frame.size.height - 2.0, frame.size.width - ZLShopDetailsDynamicSuspendTrackBarWidthIndentation * 2, 2.0);
    }];
    //改变状态，重新记录点击的item
    self.didClickButton.selected = !self.didClickButton.selected;
    sender.selected = !sender.selected;
    self.didClickButton = sender;
    //传达上下文
    if (self.itemsClick) {
        self.itemsClick(sender.tag - 1);
    }
}

@end
