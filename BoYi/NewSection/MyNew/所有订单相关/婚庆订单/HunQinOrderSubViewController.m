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
- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
    
    placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    [backBtn setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(searchAction)forControlEvents:UIControlEventTouchUpInside];
    bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = bar;
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

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat height = isIPhoneX ? 82 : 64;
    return CGRectMake(leftMargin, height, self.view.frame.size.width, self.searchString ? 0 : 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
