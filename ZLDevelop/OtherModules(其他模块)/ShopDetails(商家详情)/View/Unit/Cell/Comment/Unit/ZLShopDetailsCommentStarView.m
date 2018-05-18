//
//  ZLShopDetailsCommentStarView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//星 未满

#import "ZLShopDetailsCommentStarView.h"

@interface ZLShopDetailsCommentStarView ()

//星星
@property (nonatomic,weak) UIView *starView;
//分数
@property (nonatomic,weak) UILabel *scoreLabel;

@end

@implementation ZLShopDetailsCommentStarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //星星
    [self starView];
    //分数
    [self scoreLabel];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsCommentStarViewHeight = 25.0;
- (UIView *)starView {
    if (!_starView) {
        UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZLShopDetailsCommentStarViewHeight * 0.7 * 5, ZLShopDetailsCommentStarViewHeight)];
        for (NSInteger index = 0; index < 5; index++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ZLShopDetailsCommentStarViewHeight * 0.7 * index, 0, ZLShopDetailsCommentStarViewHeight * 0.7, ZLShopDetailsCommentStarViewHeight)];
            [button setImage:[UIImage imageNamed:@"星 未满"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"星 满"] forState:UIControlStateSelected];
            [starView addSubview:button];
        }
        [self addSubview:starView];
        _starView = starView;
    }
    return _starView;
}
- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starView.frame), 0, ZLShopDetailsCommentStarViewHeight * 2, ZLShopDetailsCommentStarViewHeight)];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.text = @"0分";
        [self addSubview:scoreLabel];
        _scoreLabel = scoreLabel;
    }
    return _scoreLabel;
}

#pragma mark - Set
- (void)setScore:(NSString *)score {
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",score];
    [self showScoreStar];
}

#pragma mark - Public
- (void)showScoreStar {
    [self changeStarState:YES Count:[_score intValue]];
}
- (void)resetScoreStar {
    [self changeStarState:NO Count:self.starView.subviews.count];
}
- (void)changeStarState:(BOOL)isSelected Count:(NSInteger)count {
    for (NSInteger index = 0; index < count; index++) {
        ((UIButton *)self.starView.subviews[index]).selected = isSelected;
    }
}

@end
