//
//  RechargeViewController.m
//  BoYi
//
//  Created by 赵磊 on 2023/2/9.
//  Copyright © 2023 hengwu. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeView.h"
#import "ZLNavBar.h"
#import "ShouyinTaiViewController.h"

@interface RechargeViewController ()

///主视图
@property (nonatomic,strong) RechargeView *mainView;
///导航条
@property (nonatomic,strong) ZLNavBar *navBar;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainView];
    [self navBar];
    self.mainView.infoModel = [RechargeModel loadModel];
    [self registerAction];
    self.mainView.infoModel.results();
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - Register
- (void)registerAction {
    __weak typeof(self)weakSelf = self;
    self.navBar.leftItemAction = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.mainView.infoModel.next = ^{// 去付款
        weakSelf.navigationController.navigationBar.hidden = NO;
        ShouyinTaiViewController *shouyinTaiVc = [ShouyinTaiViewController new];
        shouyinTaiVc.price = weakSelf.mainView.infoModel.price;
        shouyinTaiVc.remarks = weakSelf.mainView.infoModel.remarks;
        shouyinTaiVc.type = 9;
        [weakSelf.navigationController pushViewController:shouyinTaiVc animated:YES];
    };
}

#pragma mark - Lazy
- (RechargeView *)mainView {
    if (!_mainView) {
        RechargeView *mainView = [[RechargeView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:mainView];
        _mainView = mainView;
    }
    return _mainView;
}
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.showGoBack = YES;
        navBar.title = @"充值";
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

@end
