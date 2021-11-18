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
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), ScreenWidth, 0.5)];
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.lineView];
}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"婚庆",
                        @"商城"];
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
    return vc;
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    ZL_Navigation_Height(navigationHeight);
    self.lineView.frame = CGRectMake(0, navigationHeight, ScreenWidth, 0.5);
    [self.view bringSubviewToFront:self.lineView];
    return CGRectMake(leftMargin, navigationHeight, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
