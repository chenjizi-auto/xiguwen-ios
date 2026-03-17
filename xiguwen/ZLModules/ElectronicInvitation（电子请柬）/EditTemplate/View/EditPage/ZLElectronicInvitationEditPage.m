//
//  ZLElectronicInvitationEditPage.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/9.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditPage.h"
#import "ZLElectronicInvitationEditTemplateButton.h"
#import "ZLElectronicInvitationEditTemplateTextView.h"
#import "ZLElectronicInvitationEditPageImportBar.h"

@interface ZLElectronicInvitationEditPage ()<UIScrollViewDelegate,UITextViewDelegate,ZLElectronicInvitationEditPageImportBarDelegate>

///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;
///页面数组
@property (nonatomic,strong) NSMutableArray *arrayM;
///上一次的偏移值
@property (nonatomic,unsafe_unretained) CGFloat lastOffsetX;
///间距
@property (nonatomic,unsafe_unretained) CGFloat space;
///输入框
@property (nonatomic,strong) ZLElectronicInvitationEditPageImportBar *importBar;

@end

@implementation ZLElectronicInvitationEditPage

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - Set
- (void)setUnitViews:(NSArray *)unitViews {
    _unitViews = unitViews;
    [self showItems:unitViews Delete:YES];
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
        self.arrayM = [NSMutableArray new];
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (ZLElectronicInvitationEditPageImportBar *)importBar {
    if (!_importBar) {
        ZLElectronicInvitationEditPageImportBar *importBar = [[ZLElectronicInvitationEditPageImportBar alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, 0, 0)];
        importBar.delegate = self;
        [self.superview addSubview:importBar];
        _importBar = importBar;
    }
    return _importBar;
}
- (NSInteger)currentPageIndex {
    return floor(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
}

#pragma mark - Separate
- (void)showItems:(NSArray *)arrayM Delete:(BOOL)isDelete {
    NSInteger dynamicAdjustIndex = 0;
    if (isDelete) {
        if (self.currentPageIndex < self.arrayM.count - 1) {
            //最后一页之前的，删除最后一页
            UIView *view = self.arrayM.lastObject;
            [view removeFromSuperview];
            [self.arrayM removeObject:view];
            //动态调整的索引
            dynamicAdjustIndex = 100 + self.currentPageIndex;
        }else {
            //删除最后一页的，并把最后一页的坐标和大小赋值给前一个
            UIView *view = self.arrayM.lastObject;
            NSInteger count = self.arrayM.count;
            //倒数第二个
            UIView *priorView = self.arrayM[count - 2];
            priorView.frame = CGRectMake(view.frame.origin.x - self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            [view removeFromSuperview];
            [self.arrayM removeObject:view];
            //动态调整的索引
            dynamicAdjustIndex = 100 + self.currentPageIndex - 1;
        }
    }
    NSInteger count = arrayM.count;
    for (NSInteger index = 0; index < count; index++) {
        UIView *view = nil;
        if (!isDelete) {
            CGRect frame = CGRectZero;
            if (!index) {
                frame = self.scrollView.bounds;
            }else {
                frame = CGRectMake(self.space + self.scrollView.frame.size.width * index, self.space, self.scrollView.frame.size.width - self.space, self.scrollView.frame.size.height - self.space * 2);
            }
            view = [[UIView alloc] initWithFrame:frame];
            view.clipsToBounds = YES;
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shutDownKeyboard)]];
            [self.scrollView addSubview:view];
            [self.arrayM addObject:view];
        }else {
            view = self.arrayM[index];
            [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        view.backgroundColor = UIColor.whiteColor;
        NSArray *units = arrayM[index];
        for (NSInteger value = 0; value < units.count; value++) {
            UIView *subView = units[value];
            if ([subView isKindOfClass:[ZLElectronicInvitationEditTemplateButton class]]) {
                ZLElectronicInvitationEditTemplateButton *sender = (ZLElectronicInvitationEditTemplateButton *)subView;
                if (sender.backgroundPage) {
                    if (dynamicAdjustIndex) {
                        if (index == dynamicAdjustIndex - 100) {
                            sender.frame = view.bounds;
                        }
                    }
                }else {
                    [sender addTarget:self action:@selector(senderAction:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else if ([subView isKindOfClass:[ZLElectronicInvitationEditTemplateButton class]]) {
                ZLElectronicInvitationEditTemplateTextView *textView = (ZLElectronicInvitationEditTemplateTextView *)subView;
                textView.delegate = self;
            }
            [view addSubview:subView];
        }
        if (index == count - 1) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), CGRectGetHeight(self.scrollView.frame));
        }
    }
}

#pragma mark - Public
- (void)setupEditPageWithFrame:(CGRect)frame PageSize:(CGSize)pageSize Space:(CGFloat)space UnitViews:(NSArray *)unitViews {
    self.frame = frame;
    self.space = space;
    self.scrollView.frame = CGRectMake((frame.size.width - pageSize.width) * 0.5, 0, pageSize.width, pageSize.height);
    //创建视图
    [self showItems:unitViews Delete:NO];
}

#pragma mark - Action
- (void)senderAction:(ZLElectronicInvitationEditTemplateButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeImageWithIndexPath:)]) {
        [self.delegate changeImageWithIndexPath:sender.indexPath];
    }
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    [self.importBar keyboardDidChangeFrame:notification];
}
- (void)shutDownKeyboard {
    [self.importBar shutDownKeyboard];
}

#pragma mark - ZLElectronicInvitationEditPageImportBarDelegate
- (void)saveTextWithCurrentTextView:(UITextView *)currentTextView LatestText:(NSString *)value{
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveTextWithIndexPath:LatestText:)]) {
        ZLElectronicInvitationEditTemplateTextView *textView = (ZLElectronicInvitationEditTemplateTextView *)currentTextView;
        [self.delegate saveTextWithIndexPath:textView.indexPath LatestText:value];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = ceil(offsetX / scrollView.frame.size.width);
    CGFloat enlarge = (scrollView.contentOffset.x - scrollView.frame.size.width * (index - 1)) / scrollView.frame.size.width * self.space;
    //大小单位尺寸值
    CGFloat minUnitHeight = CGRectGetHeight(scrollView.frame) - self.space * 2;
    CGFloat minUnitWidth = CGRectGetWidth(scrollView.frame) - self.space;
    CGFloat maxUnitHeight = CGRectGetHeight(scrollView.frame);
    CGFloat maxUnitWidth = CGRectGetWidth(scrollView.frame);
    
    if (offsetX > self.lastOffsetX) {//向左滑动
        if (index < self.arrayM.count && index > 0) {
            CGFloat upY = self.space - enlarge;
            CGFloat upX = self.space + (CGRectGetWidth(scrollView.frame)) * index;
            //增大
            UIView *view = self.arrayM[index];
            view.frame = CGRectMake(upX - enlarge, upY, minUnitWidth + enlarge, minUnitHeight + enlarge * 2);
            if (view.subviews.count) {
                [view viewWithTag:bgTag].frame = view.bounds;
            }
            //减小
            UIView *frontView = self.arrayM[index - 1];
            frontView.frame = CGRectMake(frontView.frame.origin.x, enlarge, maxUnitWidth - enlarge, maxUnitHeight - enlarge * 2);
            if (frontView.subviews.count) {
                [frontView viewWithTag:bgTag].frame = frontView.bounds;
            }
        }
    }else {//向右滑动
        if (index < self.arrayM.count && index > 0) {
            enlarge = self.space - enlarge;
            if (enlarge > 0) {
                CGFloat upX = CGRectGetWidth(scrollView.frame) * index + enlarge;
                //减小
                UIView *view = self.arrayM[index];
                view.frame = CGRectMake(upX, enlarge, maxUnitWidth - enlarge, maxUnitHeight - enlarge * 2);
                if (view.subviews.count) {
                    [view viewWithTag:bgTag].frame = view.bounds;
                }
                //增大
                UIView *frontView = self.arrayM[index - 1];
                upX = CGRectGetWidth(scrollView.frame) * (index - 1);
                frontView.frame = CGRectMake(upX, self.space - enlarge, minUnitWidth + enlarge, minUnitHeight + enlarge * 2);
                if (frontView.subviews.count) {
                    [frontView viewWithTag:bgTag].frame = frontView.bounds;
                }
            }
        }
    }
    self.lastOffsetX = offsetX;
}

@end
