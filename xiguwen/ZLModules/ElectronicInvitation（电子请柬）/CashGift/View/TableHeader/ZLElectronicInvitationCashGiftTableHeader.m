//
//  ZLElectronicInvitationCashGiftTableHeader.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationCashGiftTableHeader.h"

@interface ZLElectronicInvitationCashGiftTableHeader ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///背景
@property (nonatomic,weak) UIImageView *bgImageView;
//背景大图的原始frame（缩放时用到）
@property (nonatomic,unsafe_unretained) CGRect iconImageOriginalFrame;

@end

@implementation ZLElectronicInvitationCashGiftTableHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bgImageView];
        [self titleLabel];
    }
    return self;
}

#pragma mark - Lazy
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"礼金 背景图.png"];
        bgImageView.image = [UIImage imageWithContentsOfFile:path];
        self.iconImageOriginalFrame = bgImageView.frame;
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, self.frame.size.height - 105, 110.0, 20.0)];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.text = @"总计收到（元）";
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)amountLabel {
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, self.frame.size.height - 70.0, 200.0, 50.0)];
        amountLabel.textColor = [UIColor whiteColor];
        amountLabel.font = [UIFont systemFontOfSize:36.0];
        amountLabel.text = @"0";
        [self addSubview:amountLabel];
        _amountLabel = amountLabel;
    }
    return _amountLabel;
}

- (void)imageZoomWithOffsetY:(CGFloat)offsetY {
    if (offsetY < 0) {
        //水平缩放比例值
        CGFloat horizontalMagnifyValue = -offsetY / self.bgImageView.frame.size.height * self.bgImageView.frame.size.width;
        //更新frame
        self.bgImageView.frame = CGRectMake(-horizontalMagnifyValue, offsetY * 2, self.iconImageOriginalFrame.size.width + horizontalMagnifyValue * 2, self.iconImageOriginalFrame.size.height + (-offsetY) * 2);
    }
}

@end
