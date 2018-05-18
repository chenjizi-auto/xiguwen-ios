//
//  ZLShopDetailsCommentReplyView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsCommentReplyView.h"

@interface ZLShopDetailsCommentReplyView ()

//背景
@property (nonatomic,weak) UIImageView *bgImageView;
//内容
@property (nonatomic,weak) UILabel *contentLabel;

@end

@implementation ZLShopDetailsCommentReplyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //背景
    [self bgImageView];
    //内容
    [self contentLabel];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsCommentReplyViewContentFont = 14.0;
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        UIImage *image = [UIImage imageNamed:@"店家回复框"];
        bgImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.4, image.size.height * 0.4, image.size.height, image.size.height) resizingMode:(UIImageResizingModeStretch)];
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 15.0, self.bounds.size.width - 20.0, 20.0)];
        contentLabel.text = @"<暂无回复>";
        contentLabel.font = [UIFont systemFontOfSize:ZLShopDetailsCommentReplyViewContentFont];
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

#pragma mark - Separate
- (void)setReply:(NSString *)reply ReplyHeight:(CGFloat)replyHeight MaxY:(CGFloat)maxY {
    self.contentLabel.text = reply;
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.frame.size.width, replyHeight);
    self.frame = CGRectMake(self.frame.origin.x, maxY, self.frame.size.width, CGRectGetMaxY(self.contentLabel.frame) + 10.0);
    self.bgImageView.frame = self.bounds;
}

@end
