//
//  GuanzhuSubNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanzhuSubNewViewController.h"
#import "GuanzhuShangpinViewController.h"
#import "GuanzhuAnlieViewController.h"
#import "GuanzhuShangjiaViewController.h"
#import "GuanzhuUserAndShangjiaViewController.h"
@interface GuanzhuSubNewViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation GuanzhuSubNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    [self addPopBackBtn];
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"商家",
                        @"案例",
                        @"商品"];
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
    
    GuanzhuShangjiaViewController *shangjia = [[GuanzhuShangjiaViewController alloc] init];
//    GuanzhuUserAndShangjiaViewController *yonghu = [[GuanzhuUserAndShangjiaViewController alloc] init];
    GuanzhuAnlieViewController *anlie = [[GuanzhuAnlieViewController alloc] init];
    GuanzhuShangpinViewController *shangpin = [[GuanzhuShangpinViewController alloc] init];

    if (index == 0) {
        return shangjia;
    }
//	else if (index == 1) {
//        return yonghu;
//    }
	else if (index == 1) {
        return anlie;
    }else {
        return shangpin;
    }
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat height = isIPhoneX ? 82 : 64;
    return CGRectMake(leftMargin, height, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
