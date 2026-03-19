//
//  MyShipinSubViewController.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyShipinSubViewController.h"
#import "MyShipinViewController.h"
#import "AddShiPinViewController.h"

@interface MyShipinSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) UIView *menuBottomLineView;
@end

@implementation MyShipinSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的视频";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftItemsSupplementBackButton = NO;
    [self addPopBackBtn];
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRightBtnWithTitle:nil image:@"添加银行卡"];

    self.menuBottomLineView = [[UIView alloc] init];
    self.menuBottomLineView.backgroundColor = UIColorFromRGB(0xD9D9D9);
    [self.view addSubview:self.menuBottomLineView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self clearNavigationButtonBackgrounds];
    CGFloat lineY = [self menuTopInset] + 44.0;
    self.menuBottomLineView.frame = CGRectMake(0.0, lineY, CGRectGetWidth(self.view.bounds), 1.0 / UIScreen.mainScreen.scale);
}

- (void)addRightBtnWithTitle:(NSString *)title image:(NSString *)image {
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    [backBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    backBtn.backgroundColor = [UIColor clearColor];
    if (@available(iOS 15.0, *)) {
        backBtn.configuration = nil;
    }
    if (image) {
        [backBtn setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (title) {
        [backBtn setTitle:title forState:UIControlStateNormal];
    }
    [backBtn addTarget:self action:@selector(respondsToRightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [self navigationBarButtonItemWithCustomView:backBtn];
}
- (void)respondsToRightBtn {
    AddShiPinViewController *add = [[AddShiPinViewController alloc] init];
	add.isEdit = NO;
    [self.navigationController pushViewController:add animated:YES];
    
}
- (void)addPopBackBtn {
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[[UIImage imageNamed:@"返回(red)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (@available(iOS 15.0, *)) {
        backBtn.configuration = nil;
    }
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [self navigationBarButtonItemWithCustomView:backBtn];
}

- (UIBarButtonItem *)navigationBarButtonItemWithCustomView:(UIView *)customView {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (@available(iOS 26.0, *)) {
        item.hidesSharedBackground = YES;
        item.sharesBackground = NO;
    }
    return item;
}
- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"审核中",
                        @"审核通过",
                        @"审核未通过"];
    }
    return _titleNames;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titleNames.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleNames[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    MyShipinViewController *BaoJia = [[MyShipinViewController alloc] init];
	BaoJia.index = index + 1;
    return BaoJia;
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (void)clearNavigationButtonBackgrounds {
    [self clearNavigationButtonBackgroundForItem:self.navigationItem.leftBarButtonItem];
    [self clearNavigationButtonBackgroundForItem:self.navigationItem.rightBarButtonItem];
}

- (void)clearNavigationButtonBackgroundForItem:(UIBarButtonItem *)item {
    UIView *view = item.customView;
    NSInteger depth = 0;
    while (view && depth < 4) {
        view.backgroundColor = UIColor.clearColor;
        view.layer.cornerRadius = 0.0;
        view.layer.masksToBounds = NO;
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            control.selected = NO;
            control.highlighted = NO;
        }
        view = view.superview;
        depth++;
    }
}

- (CGFloat)menuTopInset {
    if (self.showOnNavigationBar) {
        return 0.0;
    }
    if (@available(iOS 11.0, *)) {
        CGFloat safeAreaTop = self.view.safeAreaInsets.top;
        if (safeAreaTop > 0.0) {
            return safeAreaTop;
        }
    }
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (navigationBar && !navigationBar.hidden && navigationBar.superview) {
        CGRect navFrame = [self.view convertRect:navigationBar.frame fromView:navigationBar.superview];
        if (CGRectGetMaxY(navFrame) > 0.0) {
            return CGRectGetMaxY(navFrame);
        }
    }
    CGFloat statusBarHeight = 20.0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = self.view.window.windowScene;
        if (windowScene.statusBarManager.statusBarFrame.size.height > 0.0) {
            statusBarHeight = windowScene.statusBarManager.statusBarFrame.size.height;
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
    }
    return statusBarHeight + 44.0;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = [self menuTopInset];
    return CGRectMake(leftMargin, originY, CGRectGetWidth(self.view.bounds), 44.0);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    CGFloat availableHeight = MAX(CGRectGetHeight(self.view.bounds) - originY, 0.0);
    return CGRectMake(0, originY, CGRectGetWidth(self.view.bounds), availableHeight);
}

@end
