//
//  ZLConversionDetailFunctionBar.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailFunctionBar.h"

@interface ZLConversionDetailFunctionBar ()

///单元视图
@property (nonatomic,weak) UIView *unitView;
///跟踪条
@property (nonatomic,weak) UIView *trackBar;
///标记被点击的item
@property (nonatomic,weak) UIButton *lastButton;
///毛玻璃效果
@property (nonatomic,weak) UIVisualEffectView *frostedGlassView;
///底部分割线
@property (nonatomic,weak) CALayer *bottomLineLayer;

@end

@implementation ZLConversionDetailFunctionBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self frostedGlassView];
    [self bottomLineLayer];
    [self unitView];
}

#pragma mark - Lazy
- (UIVisualEffectView *)frostedGlassView {
    if (!_frostedGlassView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        _frostedGlassView = effectView;
    }
    return _frostedGlassView;
}
- (CALayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, CGRectGetHeight(self.frostedGlassView.frame) - 0.5, UIScreen.mainScreen.bounds.size.width, 0.5);
        layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [self.frostedGlassView.layer addSublayer:layer];
        _bottomLineLayer = layer;
    }
    return _bottomLineLayer;
}
- (UIView *)unitView {
    if (!_unitView) {
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        [self addSubview:unitView];
        _unitView = unitView;
    }
    return _unitView;
}
- (UIView *)trackBar {
    if (!_trackBar) {
        UIView *trackBar = [[UIView alloc] init];
        trackBar.backgroundColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
        [self.unitView addSubview:trackBar];
        _trackBar = trackBar;
    }
    return _trackBar;
}


#pragma mark - Set
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self giveValues];
}

#pragma mark - Separate
- (void)giveValues {
    CGFloat width = 80.0;
    CGFloat space = (CGRectGetWidth(self.unitView.frame) - width * self.titles.count) / (self.titles.count + 1);
    for (NSInteger index = 0; index < self.titles.count; index++) {
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(space + (width + space) * index, 0, width, CGRectGetHeight(self.unitView.frame))];
        sender.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [sender setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0] forState:UIControlStateSelected];
        [sender setTitle:self.titles[index] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        sender.tag = index + 1;
        [self.unitView addSubview:sender];
        if (!index) {
            sender.selected = YES;
            self.trackBar.frame = CGRectMake(CGRectGetMinX(sender.frame), CGRectGetHeight(self.unitView.frame) - 2.0, width, 2.0);
            self.lastButton = sender;
        }
    }
}

#pragma mark - Action
- (void)buttonAction:(UIButton *)sender {
    if (sender != self.lastButton) {
        self.lastButton.selected = !self.lastButton.selected;
        sender.selected = !sender.selected;
        [UIView animateWithDuration:0.25 animations:^{
            self.trackBar.frame = CGRectMake(CGRectGetMinX(sender.frame), CGRectGetHeight(self.unitView.frame) - 2.0, CGRectGetWidth(sender.frame), 2.0);
        }];
        if (self.clickItem) {
            self.clickItem(sender.tag);
        }
        self.lastButton = sender;
    }
}

@end
