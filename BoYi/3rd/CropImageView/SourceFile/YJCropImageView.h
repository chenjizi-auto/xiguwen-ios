//
//  YJCropImageView.h
//  Base
//
//  Created by junzong on 2016/9/22.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+YJAdditions.h"

@class YJCropImageMaskView;
@interface YJCropImageView : UIView <UIScrollViewDelegate> {
@private
    UIScrollView        *_scrollView;
    UIImageView         *_imageView;
    YJCropImageMaskView *_imageMaskView;
    UIImage             *_image;
    UIEdgeInsets        _imageInset;
    CGSize              _cropSize;
    NSString            *_jpgOrPng;
}

- (void)setImage:(UIImage *)image jpgOrPng:(NSString *)jpgOrPng;
- (void)setCropSize:(CGSize)size;

- (UIImage *)cropImage;

@end

@interface YJCropImageMaskView : UIView {
@private
    CGRect  _cropRect;
}
- (void)setCropSize:(CGSize)size;
- (CGSize)cropSize;
@end