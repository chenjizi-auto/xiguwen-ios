//
//  ShopNewCarSubViewController.m
//  BoYi
//
//  Created by heng on 2018/3/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShopNewCarSubViewController.h"
#import "ShopNewCarViewController.h"
@interface ShopNewCarSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ShopNewCarSubViewController

- (BOOL)shouldHideMenuView {
    return self.titleNames.count <= 1;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.lineView.hidden = YES;
    [self.view addSubview:self.lineView];
    self.showOnNavigationBar = NO;
    self.menuView.hidden = [self shouldHideMenuView];
}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"婚庆"];
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
    
    ShopNewCarViewController *vc = [[ShopNewCarViewController alloc] init];
    vc.index = index;
    vc.hidesBottomBarWhenPushed = NO;
    return vc;
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    ZL_Discern_Bang_Device(isBangDevice);
    CGFloat menuTop = isBangDevice ? 52.0 : 34.0;
    CGFloat menuHeight = [self shouldHideMenuView] ? 0.0 : 44.0;
    return CGRectMake(0.0, menuTop, CGRectGetWidth(self.view.bounds), menuHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    CGFloat availableHeight = MAX(CGRectGetHeight(self.view.bounds) - originY, 0.0);
    return CGRectMake(0.0, originY, CGRectGetWidth(self.view.bounds), availableHeight);
}

@end
