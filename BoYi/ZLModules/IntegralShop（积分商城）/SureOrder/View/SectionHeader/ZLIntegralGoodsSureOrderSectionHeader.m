//
//  ZLIntegralGoodsSureOrderSectionHeader.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsSureOrderSectionHeader.h"

@interface ZLIntegralGoodsSureOrderSectionHeader ()

///标题
@property (nonatomic,weak) UIButton *titleButton;

@end

@implementation ZLIntegralGoodsSureOrderSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self titleButton];
}

#pragma mark - Lazy
- (UIButton *)titleButton {
    if (!_titleButton) {
        UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, self.bounds.size.height)];
        [titleButton setTitle:@"  博艺婚嫁" forState:UIControlStateNormal];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"商家.png"];
        [titleButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:titleButton];
        _titleButton = titleButton;
    }
    return _titleButton;
}

@end
