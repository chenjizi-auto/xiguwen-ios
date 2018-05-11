//
//  ZLShopDetailsTimeView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsTimeView.h"
#import "ZLShopDetailsTimeUnitView.h"

@interface ZLShopDetailsTimeView ()

//时间（承载）
@property (nonatomic,weak) UIView *unitBlockView;

@end

@implementation ZLShopDetailsTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //时间单元
    [self unitBlockView];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsTimeViewHeight = 40.0;
CGFloat const ZLShopDetailsTimeViewWidth = 40.0;
- (UIView *)unitBlockView {
    if (!_unitBlockView) {
        UIView *unitBlockView = [[UIView alloc] initWithFrame:CGRectMake(15, 5.0, self.bounds.size.width - 30.0, self.bounds.size.height - 10.0)];
        //动态计算每行展示的个数
        NSInteger count = (int)(floor((unitBlockView.bounds.size.width - 5.0) / (ZLShopDetailsTimeViewHeight + 5.0)));
        //动态计算每个间隔的宽度
        CGFloat space = (unitBlockView.bounds.size.width - ZLShopDetailsTimeViewHeight * count) / (count - 1);
        //根据个数和间隔创建时间块对象
        for (NSInteger index = 0; index < count; index++) {
            ZLShopDetailsTimeUnitView *unitView = [[ZLShopDetailsTimeUnitView alloc] initWithFrame:CGRectMake((ZLShopDetailsTimeViewWidth + space) * (index % count), 0, ZLShopDetailsTimeViewWidth, ZLShopDetailsTimeViewHeight)];
            [unitBlockView addSubview:unitView];
        }
        [self addSubview:unitBlockView];
        _unitBlockView = unitBlockView;
    }
    return _unitBlockView;
}

@end
