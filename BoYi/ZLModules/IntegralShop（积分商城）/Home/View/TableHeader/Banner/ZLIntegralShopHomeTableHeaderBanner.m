//
//  ZLIntegralShopHomeTableHeaderBanner.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopHomeTableHeaderBanner.h"
#import <UIButton+AFNetworking.h>

CGFloat const ZLIntegralShopHomeTableHeaderBannerTime = 10.0;

@interface ZLIntegralShopHomeSeamlessScrollView : ZLIntegralShopHomeTableHeaderBanner <UIScrollViewDelegate>

{
    NSArray *_imageUrls;
}

///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;
///页面数组
@property (nonatomic,strong) NSMutableArray *pageArrayM;
///上一次的偏移值
@property (nonatomic,unsafe_unretained) CGFloat lastOffsetX;
///间距
@property (nonatomic,unsafe_unretained) CGFloat space;
///定时器
@property (nonatomic,strong) NSTimer *timer;
///页数索引
@property (nonatomic,unsafe_unretained) NSInteger pageIndex;
///单元点击
@property (nonatomic,copy) void (^unitClick)(NSInteger index);

@end

@implementation ZLIntegralShopHomeSeamlessScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self scrollView];
    }
    return self;
}

#pragma mark - Add
- (void)addTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:ZLIntegralShopHomeTableHeaderBannerTime target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:(NSRunLoopCommonModes)];
    self.timer = timer;
}

#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        scrollView.pagingEnabled = YES;
        scrollView.clipsToBounds = NO;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.alwaysBounceHorizontal = YES;
        self.pageArrayM = [NSMutableArray new];
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - Set
- (void)setImageUrlsArray:(NSArray *)imageUrlsArray {
    _imageUrls = imageUrlsArray;
    if (!self.pageArrayM.count) {
        [self showItems];
    }
}

#pragma mark - Action
- (void)timerAction {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 3, 0) animated:YES];
    [self changeOffsetWithScroll:self.scrollView];
}
- (void)clickAction {
    if (self.unitClick) {
        self.unitClick(self.pageIndex);
    }
}

#pragma mark - Separate
+ (instancetype)seamlessBannerViewWithPagingFrame:(CGRect)pagingFrame Space:(CGFloat)space Object:(ZLIntegralShopHomeSeamlessScrollView *)object {
    //赋值
    object.scrollView.frame = pagingFrame;
    object.space = space;
    return object;
}
- (void)zoomSizeWithScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    //计算出当前页数索引
    NSInteger index = ceil(offsetX / scrollView.frame.size.width);
    //计算出当前的缩放量
    CGFloat enlarge = (scrollView.contentOffset.x - scrollView.frame.size.width * (index - 1)) / scrollView.frame.size.width * self.space;
    //大小单位尺寸值
    CGFloat minUnitHeight = CGRectGetHeight(scrollView.frame) - self.space * 2;
    CGFloat minUnitWidth = CGRectGetWidth(scrollView.frame) - self.space;
    CGFloat maxUnitHeight = CGRectGetHeight(scrollView.frame);
    CGFloat maxUnitWidth = CGRectGetWidth(scrollView.frame);
    
    if (offsetX > self.lastOffsetX) {//向左滑动
        if (index < self.pageArrayM.count && index > 0) {
            CGFloat upY = self.space - enlarge;
            CGFloat upX = self.space + (CGRectGetWidth(scrollView.frame)) * index;
            //增大
            UIView *view = self.pageArrayM[index];
            view.frame = CGRectMake(upX - enlarge, upY, minUnitWidth + enlarge, minUnitHeight + enlarge * 2);
            if (view.subviews.count) {
                view.subviews[0].frame = view.bounds;
            }
            //减小
            UIView *frontView = self.pageArrayM[index - 1];
            frontView.frame = CGRectMake(frontView.frame.origin.x, enlarge, maxUnitWidth - enlarge, maxUnitHeight - enlarge * 2);
            if (frontView.subviews.count) {
                frontView.subviews[0].frame = frontView.bounds;
            }
        }
    }else {//向右滑动
        if (index < self.pageArrayM.count && index > 0) {
            enlarge = self.space - enlarge;
            if (enlarge > 0) {
                CGFloat upX = CGRectGetWidth(scrollView.frame) * index + enlarge;
                //减小
                UIView *view = self.pageArrayM[index];
                view.frame = CGRectMake(upX, enlarge, maxUnitWidth - enlarge, maxUnitHeight - enlarge * 2);
                if (view.subviews.count) {
                    view.subviews[0].frame = view.bounds;
                }
                //增大
                UIView *frontView = self.pageArrayM[index - 1];
                upX = CGRectGetWidth(scrollView.frame) * (index - 1);
                frontView.frame = CGRectMake(upX, self.space - enlarge, minUnitWidth + enlarge, minUnitHeight + enlarge * 2);
                if (frontView.subviews.count) {
                    frontView.subviews[0].frame = frontView.bounds;
                }
            }
        }
    }
    self.lastOffsetX = offsetX;
}
- (void)changeOffsetWithScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX == scrollView.frame.size.width) {
        self.pageIndex--;
        if (self.pageIndex < 0) {
            self.pageIndex = _imageUrls.count - 1;
        }
        UIButton *sender = self.pageArrayM[2];
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[self.pageIndex]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        
        sender = self.pageArrayM[1];
        NSInteger index = self.pageIndex - 1 < 0 ? _imageUrls.count - 1 : self.pageIndex - 1;
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[index]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        
        sender = self.pageArrayM[3];
        index = self.pageIndex + 1 >= _imageUrls.count ? 0 : self.pageIndex + 1;
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[index]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * 2, 0) animated:NO];
    }else if (offsetX == scrollView.frame.size.width * 3) {
        self.pageIndex++;
        if (self.pageIndex >= _imageUrls.count) {
            self.pageIndex = 0;
        }
        UIButton *sender = self.pageArrayM[2];
        sender.frame = CGRectMake(scrollView.frame.size.width * 2, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[self.pageIndex]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        
        sender = self.pageArrayM[1];
        NSInteger index = self.pageIndex - 1 < 0 ? _imageUrls.count - 1 : self.pageIndex - 1;
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[index]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        
        sender = self.pageArrayM[3];
        index = self.pageIndex + 1 >= _imageUrls.count ? 0 : self.pageIndex + 1;
        sender.frame = CGRectMake(scrollView.frame.size.width * 3 + self.space, self.space, scrollView.frame.size.width - self.space, scrollView.frame.size.height - self.space * 2);
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[index]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * 2, 0) animated:NO];
    }
}
- (void)showItems {
    //视图个数
    NSInteger count = _imageUrls.count > 3
                    ? 5
                    : _imageUrls.count;
    //图片的初始位置
    NSArray *indexArray = _imageUrls.count > 3
                        ? @[@(_imageUrls.count - 2),@(_imageUrls.count - 1),@(0),@(1),@(2)]
                        : @[@(0),@(1),@(2)];
    for (NSInteger index = 0; index < count; index++) {
        CGRect frame = CGRectZero;
        if (!index) {
            frame = self.scrollView.bounds;
        }else {
            frame = CGRectMake(self.space + self.scrollView.frame.size.width * index, self.space, self.scrollView.frame.size.width - self.space, self.scrollView.frame.size.height - self.space * 2);
        }
        UIButton *sender = [[UIButton alloc] initWithFrame:frame];
        sender.layer.cornerRadius = 5.0;
        sender.layer.masksToBounds = YES;
        [sender addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [sender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imageUrls[[indexArray[index] integerValue]]] placeholderImage:[UIImage imageNamed:@"rectangle_ placeholder"]];
        sender.backgroundColor = UIColor.whiteColor;
        [self.scrollView addSubview:sender];
        [self.pageArrayM addObject:sender];
        if (index == count - 1) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(sender.frame), CGRectGetHeight(self.scrollView.frame));
            //大于3个图偏移两个图
            if (_imageUrls.count > 3) {
                //修改前两个控件的坐标位置
                for (NSInteger value = 0; value < 2; value++) {
                    UIButton *sender = self.pageArrayM[value];
                    sender.frame = CGRectMake(self.scrollView.frame.size.width * value, self.space, self.scrollView.frame.size.width - self.space, self.scrollView.frame.size.height - self.space * 2);
                }
                self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * 2, 0);
                self.pageIndex = 0;
                //开启定时器
                if (!self.timer) {
                    [self addTimer];
                }
            }else {
                //大于3个图偏移两个图
                if (_imageUrls.count > 2) {
                    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
                    self.pageIndex = 1;
                }else {
                    self.scrollView.contentOffset = CGPointMake(0, 0);
                    self.pageIndex = 0;
                }
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //缩放大小控制
    [self zoomSizeWithScroll:scrollView];
    
    if (_imageUrls.count > 3) {
        //越界处理
        if (scrollView.contentOffset.x < scrollView.frame.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
            [self changeOffsetWithScroll:scrollView];
        }else if (scrollView.contentOffset.x > scrollView.frame.size.width * 3) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * 3, 0);
            [self changeOffsetWithScroll:scrollView];
        }
        
        //改变偏移量
        if (_imageUrls.count > 3) {
            [self changeOffsetWithScroll:scrollView];
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.timer.fireDate = [NSDate distantFuture];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:ZLIntegralShopHomeTableHeaderBannerTime];
}

@end

@interface ZLIntegralShopHomeTableHeaderBanner ()

///内容视图
@property (nonatomic,weak) ZLIntegralShopHomeSeamlessScrollView *seamlessScrollView;

@end

@implementation ZLIntegralShopHomeTableHeaderBanner

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - Add
- (ZLIntegralShopHomeSeamlessScrollView *)seamlessScrollView {
    if (!_seamlessScrollView) {
        ZLIntegralShopHomeSeamlessScrollView *seamlessScrollView = [[ZLIntegralShopHomeSeamlessScrollView alloc] initWithFrame:self.bounds];
        __weak typeof(self)weakSelf = self;
        seamlessScrollView.unitClick = ^(NSInteger index) {
            if (weakSelf.unitsClick) {
                weakSelf.unitsClick(index);
            }
        };
        [self addSubview:seamlessScrollView];
        _seamlessScrollView = seamlessScrollView;
    }
    return _seamlessScrollView;
}
- (void)setImageUrlsArray:(NSArray *)imageUrlsArray {
    _imageUrlsArray = imageUrlsArray;
    self.seamlessScrollView.imageUrlsArray = _imageUrlsArray;
}

#pragma mark - Separate
+ (instancetype)integralShopHomeTableHeaderBannerWithFrame:(CGRect)frame PagingFrame:(CGRect)pagingFrame Space:(CGFloat)space  {
    ZLIntegralShopHomeTableHeaderBanner *view = [[self alloc] initWithFrame:frame];
    [ZLIntegralShopHomeSeamlessScrollView seamlessBannerViewWithPagingFrame:pagingFrame Space:space Object:view.seamlessScrollView];
    return view;
}
- (void)removeTimer {
    if (self.seamlessScrollView.timer) {
        [self.seamlessScrollView.timer invalidate];
        self.seamlessScrollView.timer = nil;
    }
}
- (void)startTimer {
    self.seamlessScrollView.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:ZLIntegralShopHomeTableHeaderBannerTime];
}
- (void)stopTimer {
    self.seamlessScrollView.timer.fireDate = [NSDate distantFuture];
}

@end
