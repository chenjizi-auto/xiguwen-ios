//
//  HunQinOrderSubViewController.m
//  BoYi
//
//  Created by heng on 2018/1/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunQinOrderSubViewController.h"
#import "HunQinOrderViewController.h"
#import "OYCountDownManager.h"
#import "IQKeyboardManager.h"
#import "ZLSearchOrderViewController.h"

@interface HunQinOrderSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation HunQinOrderSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"婚庆订单";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftItemsSupplementBackButton = NO;
    [self addPopBackBtn];
    self.titleColorSelected = MAINCOLOR;
    self.selectIndex = (int)self.statusFlag;
    if (self.searchString) {
        self.menuView.hidden = YES;
    }else {
        self.menuView.hidden = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self clearNavigationButtonBackgrounds];
}

- (void)addPopBackBtn {
    UIButton * backBtn = [self navigationButtonWithImageNamed:@"返回(red)"
                                                       frame:CGRectMake(0, 0, 44, 44)
                                                  imageInsets:UIEdgeInsetsMake(0, -8, 0, 0)
                                       horizontalAlignment:UIControlContentHorizontalAlignmentLeft
                                                      action:@selector(popViewConDelay)];
    self.navigationItem.leftBarButtonItem = [self navigationBarButtonItemWithCustomView:backBtn];

    backBtn = [self navigationButtonWithImageNamed:@"sousuo"
                                             frame:CGRectMake(0, 0, 44, 44)
                                        imageInsets:UIEdgeInsetsMake(0, 0, 0, -8)
                             horizontalAlignment:UIControlContentHorizontalAlignmentRight
                                            action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = [self navigationBarButtonItemWithCustomView:backBtn];
}

- (UIButton *)navigationButtonWithImageNamed:(NSString *)imageName
                                       frame:(CGRect)frame
                                  imageInsets:(UIEdgeInsets)imageInsets
                       horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                                      action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    button.imageEdgeInsets = imageInsets;
    button.contentHorizontalAlignment = horizontalAlignment;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.adjustsImageWhenHighlighted = NO;
    if (@available(iOS 15.0, *)) {
        button.configuration = nil;
    }
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIBarButtonItem *)navigationBarButtonItemWithCustomView:(UIView *)customView {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (@available(iOS 26.0, *)) {
        item.hidesSharedBackground = YES;
        item.sharesBackground = NO;
    }
    return item;
}
- (void)searchAction {
    ZLSearchOrderViewController *searchOrderVc = [ZLSearchOrderViewController new];
    [self.navigationController pushViewController:searchOrderVc animated:YES];
}
- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (NSArray *)titleNames {
    return self.searchString ? @[@"全部"] : @[@"全部",@"待付款",@"待接单",@"待服务",@"已服务",@"待评价",@"已完成"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.searchString ? 1 : self.titleNames.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleNames[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    HunQinOrderViewController *Order = [[HunQinOrderViewController alloc] init];
    NSInteger type;
    if (index == 0) {
        type = 0;
    }else if (index == 1){
        type = 10;
    }else if (index == 2){
        type = 60;
    }else if (index == 3){
        type = 70;
    }else if (index == 4){
        type = 79;
    }else if (index == 5){
        type = 80;
    }else {
        type = 90;
    }
    Order.statusFlag = type;
    Order.searchString = self.searchString;
    return Order;
    
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
    return CGRectMake(leftMargin, originY, CGRectGetWidth(self.view.bounds), self.searchString ? 0.0 : 44.0);
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
