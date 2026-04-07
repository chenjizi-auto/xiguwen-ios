//
//  ShangjiaNewHeaderView.m
//  BoYi
//
//  Created by heng on 2017/12/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaNewHeaderView.h"

static NSInteger const kMerchantDetailTabCount = 7;
static NSInteger const kMerchantDetailTabContainerTagBase = 100;
static NSInteger const kMerchantDetailTabButtonTag = 200;
static NSInteger const kMerchantDetailTabIndicatorTag = 201;
@implementation ShangjiaNewHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    
    for (NSInteger i = 0; i < kMerchantDetailTabCount; i++) {
        UIView *containerView = [self tabContainerAtIndex:i];
        UIButton *button = [self tabButtonAtIndex:i];
        if (!containerView || !button) {
            continue;
        }
        containerView.userInteractionEnabled = YES;
        containerView.exclusiveTouch = YES;
        for (UIGestureRecognizer *gesture in [containerView.gestureRecognizers copy]) {
            [containerView removeGestureRecognizer:gesture];
        }
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabContainerTapAction:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.cancelsTouchesInView = YES;
        [containerView addGestureRecognizer:tapGesture];
        button.tag = i;
        button.userInteractionEnabled = NO;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button removeTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)tabContainerTapAction:(UITapGestureRecognizer *)gesture {
    [self selectTabAtIndex:[self tabIndexForView:gesture.view]];
}

- (void)tabButtonAction:(UIButton *)sender {
    [self selectTabAtIndex:sender.tag];
}

- (void)setMarkType:(NSInteger)markType{
    _markType = markType;
    for (NSInteger j = 0; j < kMerchantDetailTabCount; j++) {
        UIView *indicatorView = [self tabIndicatorAtIndex:j];
        UIButton *button = [self tabButtonAtIndex:j];
        if (markType == j) {
            [button setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            indicatorView.hidden = NO;
        }else {
            [button setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            indicatorView.hidden = YES;
        }
    }
}

- (UIView *)tabContainerAtIndex:(NSInteger)index {
    return [self viewWithTag:kMerchantDetailTabContainerTagBase + index];
}

- (UIButton *)tabButtonAtIndex:(NSInteger)index {
    UIView *containerView = [self tabContainerAtIndex:index];
    return (UIButton *)[containerView viewWithTag:kMerchantDetailTabButtonTag];
}

- (UIView *)tabIndicatorAtIndex:(NSInteger)index {
    UIView *containerView = [self tabContainerAtIndex:index];
    return [containerView viewWithTag:kMerchantDetailTabIndicatorTag];
}

- (NSInteger)tabIndexForView:(UIView *)view {
    NSInteger index = view.tag - kMerchantDetailTabContainerTagBase;
    return index;
}

- (void)selectTabAtIndex:(NSInteger)index {
    if (index < 0 || index >= kMerchantDetailTabCount) {
        return;
    }
    self.markType = index;
    [self.gotoNextVc sendNext:@(index)];
}

- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

@end
