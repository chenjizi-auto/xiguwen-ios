//
//  ZLIntegralGoodsBasicDetailBanner.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/30.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsBasicDetailBanner.h"
#import <UIImageView+AFNetworking.h>

@interface ZLIntegralGoodsBasicDetailBanner ()<UIScrollViewDelegate>

///默认图片
@property (nonatomic,weak) UIImageView *defaultImageView;
///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;
///单元父视图
@property (nonatomic,weak) UIView *unitViews;
///页面定位点
@property (nonatomic,weak) UIPageControl *pageConrol;

@end

@implementation ZLIntegralGoodsBasicDetailBanner

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self defaultImageView];
}

#pragma mark - Lazy
- (UIImageView *)defaultImageView {
    if (!_defaultImageView) {
        UIImageView *defaultImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        defaultImageView.image = [UIImage imageNamed:@"square_placeholder_ big"];
        [self addSubview:defaultImageView];
        _defaultImageView = defaultImageView;
    }
    return _defaultImageView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (UIView *)unitViews {
    if (!_unitViews) {
        UIView *unitViews = [[UIView alloc] initWithFrame:self.scrollView.bounds];
        [self.scrollView addSubview:unitViews];
        _unitViews = unitViews;
    }
    return _unitViews;
}
- (UIPageControl *)pageConrol {
    if (!_pageConrol) {
        UIPageControl *pageConrol = [[UIPageControl alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.scrollView.frame) - 20.0, CGRectGetWidth(self.scrollView.frame) - 30.0, 20.0)];
        pageConrol.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self addSubview:pageConrol];
        _pageConrol = pageConrol;
    }
    return _pageConrol;
}

#pragma mark - Set
- (void)setImageUrlsArray:(NSArray *)imageUrlsArray {
    _imageUrlsArray = imageUrlsArray;
    self.defaultImageView.hidden = _imageUrlsArray.count ? YES : NO;
    self.unitViews.subviews.count
        ? [self updateItems]
        : [self showItems];
}

#pragma mark - Separate
- (void)showItems {
    for (NSInteger index = 0; index < self.imageUrlsArray.count; index++) {
        UIImageView *unitView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width * index, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        unitView.userInteractionEnabled = YES;
        [unitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)]];
        [unitView setImageWithURL:[NSURL URLWithString:self.imageUrlsArray[index]] placeholderImage:[UIImage imageNamed:@"square_placeholder_ big"]];
        [self.unitViews addSubview:unitView];
        if (index == self.imageUrlsArray.count - 1) {
            self.unitViews.frame = CGRectMake(self.unitViews.frame.origin.x, self.unitViews.frame.origin.y, CGRectGetMaxX(unitView.frame), self.unitViews.frame.size.height);
            self.scrollView.contentSize = CGSizeMake(self.unitViews.frame.size.width, self.unitViews.frame.size.height);
            self.pageConrol.numberOfPages = self.imageUrlsArray.count;
            self.pageConrol.currentPage = 0;
        }
    }
}
- (void)updateItems {
    //如果单元不足，先补齐，并调整滑动视图相关属性
    if (self.imageUrlsArray.count > self.unitViews.subviews.count) {
        //补齐不足
        NSInteger count = self.imageUrlsArray.count - self.unitViews.subviews.count;
        UIImageView *lastImageView = self.unitViews.subviews.lastObject;
        for (NSInteger index = 0; index < count; index++) {
            UIImageView *unitView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lastImageView.frame) + self.scrollView.bounds.size.width * index, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
            [unitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)]];
            unitView.userInteractionEnabled = YES;
            [self.unitViews addSubview:unitView];
            if (index == count - 1) {
                self.unitViews.frame = CGRectMake(self.unitViews.frame.origin.x, self.unitViews.frame.origin.y, CGRectGetMaxX(unitView.frame), self.unitViews.frame.size.height);
                self.scrollView.contentSize = CGSizeMake(self.unitViews.frame.size.width, self.unitViews.frame.size.height);
                self.pageConrol.numberOfPages = self.imageUrlsArray.count;
                self.pageConrol.currentPage = 0;
            }
        }
        //重新赋值
        for (NSInteger index = 0; index < self.imageUrlsArray.count; index++) {
            UIImageView *imageView = self.unitViews.subviews[index];
            imageView.hidden = NO;
            [imageView setImageWithURL:[NSURL URLWithString:self.imageUrlsArray[index]] placeholderImage:[UIImage imageNamed:@"square_placeholder_ big"]];
        }
        
    //如果数据源多余单元，则调整滑动视图相关属性
    }else if (self.imageUrlsArray.count < self.unitViews.subviews.count) {
        for (NSInteger index = 0; index < self.unitViews.subviews.count; index++) {
            UIImageView *imageView = self.unitViews.subviews[index];
            if (index < self.imageUrlsArray.count) {
                [imageView setImageWithURL:[NSURL URLWithString:self.imageUrlsArray[index]] placeholderImage:[UIImage imageNamed:@"square_placeholder_ big"]];
                if (index == self.imageUrlsArray.count - 1) {
                    self.unitViews.frame = CGRectMake(self.unitViews.frame.origin.x, self.unitViews.frame.origin.y, CGRectGetMaxX(imageView.frame), self.unitViews.frame.size.height);
                    self.scrollView.contentSize = CGSizeMake(self.unitViews.frame.size.width, self.unitViews.frame.size.height);
                    self.pageConrol.numberOfPages = self.imageUrlsArray.count;
                    self.pageConrol.currentPage = 0;
                }
            }else {
                imageView.hidden = YES;
            }
        }
        
    //数量相等，就重新给item赋值图片资源
    }else {
        for (NSInteger index = 0; index < self.imageUrlsArray.count; index++) {
            UIImageView *imageView = self.unitViews.subviews[index];
            imageView.hidden = NO;
            [imageView setImageWithURL:[NSURL URLWithString:self.imageUrlsArray[index]] placeholderImage:[UIImage imageNamed:@"square_placeholder_ big"]];
        }
    }
    
}

#pragma mark - Action
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap {
    if (self.clickItem) {
        self.clickItem((UIImageView *)tap.view, self.pageConrol.currentPage);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageConrol.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
