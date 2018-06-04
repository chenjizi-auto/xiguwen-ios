//
//  ZLIntegralGoodsDetailLookImageView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/30.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsDetailLookImageView.h"
#import <UIImageView+AFNetworking.h>

@interface ZLIntegralGoodsDetailLookImageView ()<UIScrollViewDelegate>

///
@property (nonatomic,weak) UIScrollView *scrollView;
///单元数据
@property (nonatomic,weak) NSMutableArray <UIScrollView *>*unitViews;
///记录上次查看的位置
@property (nonatomic,unsafe_unretained) CGPoint lastOffset;
///始、终做缩放动画的视图
@property (nonatomic,weak) UIImageView *animatImageView;
///页面定位点
@property (nonatomic,weak) UIPageControl *pageConrol;
///返回
@property (nonatomic,weak) UIButton *goBackButton;
///
@property (nonatomic,weak) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ZLIntegralGoodsDetailLookImageView

#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = UIColor.blackColor;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView.alpha = 0;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (UIImageView *)animatImageView {
    if (!_animatImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:imageView];
        _animatImageView = imageView;
    }
    return _animatImageView;
}
- (UIPageControl *)pageConrol {
    if (!_pageConrol) {
        UIPageControl *pageConrol = [[UIPageControl alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.frame) - 40.0, CGRectGetWidth(self.frame) - 30.0, 20.0)];
        pageConrol.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self addSubview:pageConrol];
        _pageConrol = pageConrol;
    }
    return _pageConrol;
}
- (UIButton *)goBackButton {
    if (!_goBackButton) {
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 20.0, 30.0, 40.0)];
        [sender setImage:[UIImage imageNamed:@"goback_pink"] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sender];
        _goBackButton = sender;
    }
    return _goBackButton;
}
- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        activityIndicatorView.color = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        [self addSubview:activityIndicatorView];
        activityIndicatorView.center = self.center;
        _activityIndicatorView = activityIndicatorView;
    }
    return _activityIndicatorView;
}

- (void)showImagesWithFrame:(CGRect)frame Image:(UIImage *)image ImageUrls:(NSArray *)imageUrls CurrentIndex:(NSInteger)index {
    //提前加载滑动视图，使其放在最下面
    [self scrollView];
    //赋值
    self.animatImageView.frame = frame;
    self.animatImageView.image = image;
    //配置返回按钮
    [self goBackButton];
    
    //执行等待动画
    [self.activityIndicatorView startAnimating];
    
    //动画展示图片
    [UIView animateWithDuration:0.25 animations:^{
        self.animatImageView.frame = [self changeFrameWithImageSize:image.size];
        self.scrollView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.animatImageView.hidden = YES;
        for (NSInteger number = 0; number < imageUrls.count; number++) {
            //创建内部滑动视图，用来控制缩放
            UIScrollView *miniScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * number, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [self.scrollView addSubview:miniScrollView];
            miniScrollView.tag = 100 + number;
            miniScrollView.maximumZoomScale = 10;
            miniScrollView.minimumZoomScale = 1;
            miniScrollView.delegate = self;
            //创建单元图片视图
            NSString *imageUrl = imageUrls[number];
            CGSize size = [self imageSizeWithURL:[NSURL URLWithString:imageUrl]];
            size = CGSizeMake(size.width / UIScreen.mainScreen.scale, size.height / UIScreen.mainScreen.scale);
            UIImageView *showImageView = [[UIImageView alloc] initWithFrame:[self changeFrameWithImageSize:size]];
            showImageView.tag = 50;
            [miniScrollView addSubview:showImageView];
            UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapGobackAction:)];
            [showImageView addGestureRecognizer:oneTap];
            UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoTapGobackAction:)];
            twoTap.numberOfTapsRequired = 2;
            [showImageView addGestureRecognizer:twoTap];
            [oneTap requireGestureRecognizerToFail:twoTap];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
            longPress.minimumPressDuration = 2.0;
            [showImageView addGestureRecognizer:longPress];
            showImageView.userInteractionEnabled = YES;
            //对图片进行等比例缩放，确保和 UIImageView 等宽或等高。
            showImageView.contentMode = UIViewContentModeScaleAspectFit;
            [showImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        }
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * imageUrls.count, CGRectGetHeight(self.frame));
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.frame) * index, 0);
        self.lastOffset = self.scrollView.contentOffset;
        self.pageConrol.numberOfPages = imageUrls.count;
        self.pageConrol.currentPage = index;
        
        //关闭等待动画
        [self.activityIndicatorView stopAnimating];
    }];
}

#pragma mark - Separate
///计算位置、处理超过屏幕宽的图片
- (CGRect)changeFrameWithImageSize:(CGSize)size {
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    if (size.width >= CGRectGetWidth(self.frame) && size.height <= CGRectGetHeight(self.frame)) {//宽比屏幕大
        width = CGRectGetWidth(self.frame);
        CGFloat widthScale = CGRectGetWidth(self.frame) / size.width;
        height = size.height * widthScale;
        y = (CGRectGetHeight(self.frame) - height) / 2;
    }else if (size.height >= CGRectGetHeight(self.frame) && size.width <= CGRectGetWidth(self.frame)) {//高比屏幕大
        height = CGRectGetHeight(self.frame);
        CGFloat heightScale = CGRectGetHeight(self.frame) / size.height;
        width = size.width * heightScale;
        x = (CGRectGetWidth(self.frame) - width) / 2;
    }else if (size.width <= CGRectGetWidth(self.frame) && size.height <= CGRectGetHeight(self.frame)) {//宽高比屏幕小
        width = size.width;
        height = size.height;
        x = (CGRectGetWidth(self.frame) - width) / 2;
        y = (CGRectGetHeight(self.frame) - height) / 2;
    }else{//宽高比屏幕大
        width = CGRectGetWidth(self.frame);
        CGFloat widthScale = CGRectGetWidth(self.frame) / size.width;
        height = size.height * widthScale;
        y = (CGRectGetHeight(self.frame) - height) / 2;
    }
    return CGRectMake(x, y, width, height);
}
///根据图片url获取图片尺寸
- (CGSize)imageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

#pragma mark Action
- (void)oneTapGobackAction:(UITapGestureRecognizer *)tap {//单击返回事件
    [self goBackAction];
}
- (void)twoTapGobackAction:(UITapGestureRecognizer *)tap {//双击缩放
    UIScrollView *scrollView = (UIScrollView *)tap.view.superview;
    static BOOL isZoom;
    isZoom = !isZoom;
    [UIView animateWithDuration:0.5 animations:^{
        scrollView.zoomScale = (isZoom) ? 5 : 1;
    }];
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {//长按保存
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIImageWriteToSavedPhotosAlbum(((UIImageView *)longPress.view).image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {//保存成功后HUD提示
    if (!error) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - CGRectGetWidth(self.frame) * 0.4) / 2, CGRectGetHeight(self.frame) - CGRectGetHeight(self.frame) * 0.1, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame) / 20)];
        bgView.tag = 888;
        [self addSubview:bgView];
        UIView *HUDView = [[UIView alloc] initWithFrame:bgView.bounds];
        HUDView.alpha = 0.3;
        HUDView.backgroundColor = [UIColor blackColor];
        [bgView addSubview:HUDView];
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:bgView.bounds];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.text = @"保存成功！";
        [bgView addSubview:messageLabel];
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0];
    }
}
- (void)delayMethod {//消除HUD
    UIView *bgView = (UILabel *)[self viewWithTag:888];
    [bgView removeFromSuperview];
}

#pragma mark UIScrollViewDelegate
- (UIView* )viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.scrollView != scrollView) {
        //设置需要缩放的视图
        UIImageView *imageView = [scrollView viewWithTag:50];
        return imageView;
    }
    return nil;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.scrollView != scrollView) {
        //修改imageView缩放后的中心点位置
        UIImageView *imageView = [scrollView viewWithTag: 50];
        if (imageView.frame.size.width > scrollView.frame.size.width && imageView.frame.size.height > scrollView.frame.size.height) {
            imageView.center = CGPointMake(scrollView.contentSize.width / 2, scrollView.contentSize.height / 2);
        }else if (imageView.frame.size.width > scrollView.frame.size.width && imageView.frame.size.height <= scrollView.frame.size.height){
            imageView.center = CGPointMake(scrollView.contentSize.width / 2, CGRectGetHeight(self.frame) / 2);
        }else if (imageView.frame.size.height > scrollView.frame.size.height && imageView.frame.size.width<=scrollView.frame.size.width){
            imageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, scrollView.contentSize.height / 2);
        }else{
            imageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scrollView == scrollView) {
        if (self.lastOffset.x != scrollView.contentOffset.x) {
            //重置上次查看的图片位置及大小，重置scrollView的缩放倍数
            UIScrollView *miniScrollView = [scrollView viewWithTag:self.lastOffset.x / CGRectGetWidth(self.frame) + 100];
            UIImageView *imageView = [miniScrollView viewWithTag:50];
            miniScrollView.zoomScale = 1.0f;
            imageView.frame = [self changeFrameWithImageSize:imageView.image.size];
            miniScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            self.lastOffset = scrollView.contentOffset;
            self.pageConrol.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
        }
    }
}

#pragma mark - Action
- (void)goBackAction {
    self.backgroundColor = [UIColor clearColor];
    NSInteger index = self.scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    UIScrollView *miniScrollView = [self.scrollView viewWithTag:100 + index];
    UIImageView *imageView = [miniScrollView viewWithTag: 50];
    imageView.hidden = YES;
    CGRect frame = [imageView.superview convertRect:imageView.frame toView:self.animatImageView.superview];
    self.animatImageView.hidden = NO;
    self.animatImageView.frame = frame;
    self.animatImageView.image = imageView.image;
    CGRect originalFrame = CGRectMake(frame.origin.x - frame.size.width * 1.5, frame.origin.y - frame.size.height * 1.5, frame.size.width * 4, frame.size.height * 4);
    [UIView animateWithDuration:0.5 animations:^{
        self.animatImageView.frame = originalFrame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.animatImageView removeFromSuperview];
        if (self.willDismiss) {
            self.willDismiss();
        }
    }];
}

@end
