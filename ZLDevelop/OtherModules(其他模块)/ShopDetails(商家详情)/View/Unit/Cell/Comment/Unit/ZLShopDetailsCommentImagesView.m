//
//  ZLShopDetailsCommentImagesView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsCommentImagesView.h"
#import <UIButton+AFNetworking.h>

@interface ZLShopDetailsCommentImagesView ()

//图片（承载器）
@property (nonatomic,weak) UIView *imagesView;

@end

@implementation ZLShopDetailsCommentImagesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //图片（承载器）
    [self imagesView];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsCommentImagesViewImagesHeight = 110.0;
- (UIView *)imagesView {
    if (!_imagesView) {
        UIView *imagesView = [[UIView alloc] initWithFrame:self.bounds];
        CGFloat width = (self.bounds.size.width - 20.0) / 3;
        for (NSInteger index = 0; index < 9; index++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((width + 10.0) * (index % 3), (ZLShopDetailsCommentImagesViewImagesHeight + 10.0) * (index / 3), width, ZLShopDetailsCommentImagesViewImagesHeight)];
            [button setImage:[UIImage imageNamed:@"占位图片"] forState:UIControlStateNormal];
            button.imageView.contentMode = UIViewContentModeScaleAspectFill;
            button.hidden = YES;
            [imagesView addSubview:button];
        }
        [self addSubview:imagesView];
        _imagesView = imagesView;
    }
    return _imagesView;
}

#pragma mark - Separate
- (void)setImagesWithArray:(NSArray *)array MaxY:(CGFloat)maxY {
    [self changeImageHidden:NO MaxY:maxY imagesArray:array];
}
- (void)resetWithMaxY:(CGFloat)maxY {
    [self changeImageHidden:NO MaxY:maxY imagesArray:nil];
}
- (void)changeImageHidden:(BOOL)isHidden MaxY:(CGFloat)maxY imagesArray:(NSArray *)array {
    NSInteger count = array ? array.count : self.imagesView.subviews.count;
    for (NSInteger index = 0; index < count; index++) {
        UIButton *iconButton = self.imagesView.subviews[index];
        iconButton.hidden = isHidden;
        if (!isHidden) {
            [iconButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:array[index]] placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }
        if (index == count - 1) {
            self.imagesView.frame = CGRectMake(self.imagesView.frame.origin.x, 0, self.imagesView.frame.size.width, CGRectGetMaxY(iconButton.frame));
            self.frame = CGRectMake(self.frame.origin.x, maxY, self.frame.size.width, CGRectGetMaxY(self.imagesView.frame));
        }
    }
}

@end
