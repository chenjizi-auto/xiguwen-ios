//
//  YJCropImageView.m
//  Base
//
//  Created by junzong on 2016/9/22.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "YJCropImageView.h"

@implementation YJCropImageView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self scrollView] setFrame:self.bounds];
    [[self imageMaskView] setFrame:self.bounds];
    
    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
        [self setCropSize:CGSizeMake(100, 100)];
    }
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setDelegate:self];
        [_scrollView setBounces:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [[self scrollView] addSubview:_imageView];
    }
    return _imageView;
}

- (YJCropImageMaskView *)imageMaskView {
    if (_imageMaskView == nil) {
        _imageMaskView = [[YJCropImageMaskView alloc] init];
        [_imageMaskView setBackgroundColor:[UIColor clearColor]];
        [_imageMaskView setUserInteractionEnabled:NO];
        [self addSubview:_imageMaskView];
        [self bringSubviewToFront:_imageMaskView];
    }
    return _imageMaskView;
}

- (void)setImage:(UIImage *)image jpgOrPng:(NSString *)jpgOrPng{
    if (image != _image) {
        _image = nil;
        _image = image;
    }
    if (jpgOrPng != _jpgOrPng) {
        _jpgOrPng = nil;
        _jpgOrPng = jpgOrPng;
    }
    [[self imageView] setImage:_image];
    
    [self updateZoomScale];
}

- (void)updateZoomScale {
    CGFloat width = _image.size.width;
    CGFloat height = _image.size.height;
    
    [[self imageView] setFrame:CGRectMake(0, 0, width, height)];
    
    CGFloat xScale = _cropSize.width / width;
    CGFloat yScale = _cropSize.height / height;
    
    CGFloat min = MAX(xScale, yScale);
    CGFloat max = 1.0;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        max = 1.0 / [[UIScreen mainScreen] scale];
    }
    
    if (min > max) {
        min = max;
    }
    
    [[self scrollView] setMinimumZoomScale:min];
    [[self scrollView] setMaximumZoomScale:max + 5.0f];
    
    [[self scrollView] setZoomScale:max animated:YES];
}

- (void)setCropSize:(CGSize)size {
    _cropSize = size;
    [self updateZoomScale];
    
    CGFloat width = _cropSize.width;
    CGFloat height = _cropSize.height;
    
    CGFloat x = (CGRectGetWidth(self.bounds) - width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - height) / 2;
    
    [[self imageMaskView] setCropSize:_cropSize];
    
    CGFloat top = y;
    CGFloat left = x;
    CGFloat right = CGRectGetWidth(self.bounds)- width - x;
    CGFloat bottom = CGRectGetHeight(self.bounds)- height - y;
    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
    [[self scrollView] setContentInset:_imageInset];
    
    [[self scrollView] setContentOffset:CGPointMake(0, 0)];
}

- (UIImage *)cropImage {
    
    
    CGFloat offsetX = [self scrollView].contentOffset.x;
    CGFloat offsetY = [self scrollView].contentOffset.y;
    CGFloat aX = offsetX>=0 ? offsetX+_imageInset.left : (_imageInset.left - ABS(offsetX));
    CGFloat aY = offsetY>=0 ? offsetY+_imageInset.top : (_imageInset.top - ABS(offsetY));
    
    
    
    CGFloat aWidth = 0;
    CGFloat aHeight = 0;
    //jpg格式和png格式的图片在ios上显示是不一样的，png格式图片会自动按照@2x，@3x比例缩放，jpg格式的图片比例是多少就会在ios上显示多少，所以要做以下处理
    if ([[_jpgOrPng lowercaseString] isEqualToString:@"jpg"]) {
        
        aWidth = _cropSize.width;
        aHeight = _cropSize.height;
        
    } else if ([[_jpgOrPng lowercaseString] isEqualToString:@"png"]) {
        CGFloat zoomScale = [self scrollView].zoomScale;
        
        aX = aX / zoomScale;
        aY = aY / zoomScale;
        
        aWidth =  MAX(_cropSize.width / zoomScale, _cropSize.width);
        aHeight = MAX(_cropSize.height / zoomScale, _cropSize.height);
    }
    
#ifdef DEBUG
    NSLog(@"%f--%f--%f--%f", aX, aY, aWidth, aHeight);
#endif
    
    UIImage *image = [_image cropImageWithX:aX y:aY width:aWidth height:aHeight];
    
    image = [image resizeToWidth:_cropSize.width height:_cropSize.height];
    
    return image;
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self imageView];
}

- (void)dealloc {
    _scrollView = nil;
    _imageView = nil;
    _imageMaskView = nil;
    _image = nil;
}
@end


#pragma YJCropImageMaskView

#define kMaskViewBorderWidth 2.0f

@implementation YJCropImageMaskView

- (void)setCropSize:(CGSize)size {
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    
    [self setNeedsDisplay];
}

- (CGSize)cropSize {
    return _cropRect.size;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1, 1, 1, .6);
    CGContextFillRect(ctx, self.bounds);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
    
    CGContextClearRect(ctx, _cropRect);
}

@end
