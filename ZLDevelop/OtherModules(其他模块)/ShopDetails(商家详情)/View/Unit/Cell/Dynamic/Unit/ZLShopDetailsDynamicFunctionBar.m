//
//  ZLShopDetailsDynamicFunctionBar.m
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsDynamicFunctionBar.h"

@interface ZLShopDetailsDynamicFunctionBar ()

//顶部分割线
@property (nonatomic,weak) CALayer *topLineLayer;
//功能(承载器)
@property (nonatomic,weak) UIView *itemsView;
//底部灰色分割块
@property (nonatomic,weak) CALayer *bottomBlockLayer;

@end

@implementation ZLShopDetailsDynamicFunctionBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //顶部分割线
    [self topLineLayer];
    //功能(承载器)
    [self itemsView];
    //底部灰色分割块
    [self bottomBlockLayer];
}

#pragma mark - Lazy
- (CALayer *)topLineLayer {
    if (!_topLineLayer) {
        CALayer *topLineLayer = [[CALayer alloc] init];
        topLineLayer.frame = CGRectMake(0, -0.3, self.bounds.size.width, 0.3);
        topLineLayer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [self.layer addSublayer:topLineLayer];
        _topLineLayer = topLineLayer;
    }
    return _topLineLayer;
}
- (UIView *)itemsView {
    if (!_itemsView) {
        UIView *itemsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        itemsView.backgroundColor = ZL_ARC4RANDOM_COLOR;
        [self addSubview:itemsView];
        _itemsView = itemsView;
    }
    return _itemsView;
}
- (CALayer *)bottomBlockLayer {
    if (!_bottomBlockLayer) {
        CALayer *bottomBlockLayer = [[CALayer alloc] init];
        bottomBlockLayer.frame = CGRectMake(0, self.bounds.size.height - 5.0, self.bounds.size.width, 5.0);
        bottomBlockLayer.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0].CGColor;
        [self.layer addSublayer:bottomBlockLayer];
        _bottomBlockLayer = bottomBlockLayer;
    }
    return _bottomBlockLayer;
}

@end
