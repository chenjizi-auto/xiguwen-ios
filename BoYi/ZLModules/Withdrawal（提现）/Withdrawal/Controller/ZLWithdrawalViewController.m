//
//  ZLWithdrawalViewController.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/29.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLWithdrawalViewController.h"
#import "ZLWithdrawalView.h"
#import "ZLNavBar.h"
#import "ZLSelectBankCardViewController.h"

@interface ZLWithdrawalViewController ()

///主视图
@property (nonatomic,strong) ZLWithdrawalView *mainView;
///导航条
@property (nonatomic,strong) ZLNavBar *navBar;

@end

@implementation ZLWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainView];
    [self navBar];
    self.mainView.infoModel = [ZLWithdrawalModel loadModel];
    [self registerAction];
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
    self.mainView.infoModel.selectBankCard = ^{//选择银行卡
        ZLSelectBankCardViewController *selectBankCardVc = [ZLSelectBankCardViewController new];
        selectBankCardVc.keyId = weakSelf.mainView.infoModel.keyId;
        selectBankCardVc.starPhone = weakSelf.mainView.infoModel.starPhone;
        selectBankCardVc.phone = weakSelf.mainView.infoModel.phone;
        selectBankCardVc.didSelected = ^(ZLSelectBankCardModel *unitModel) {
            weakSelf.mainView.infoModel.keyId = unitModel.keyId;
            weakSelf.mainView.infoModel.keyTitle = unitModel.keyTitle;
            weakSelf.mainView.infoModel.subTitle = unitModel.subTitle;
            if (weakSelf.mainView.infoModel.results) {
                weakSelf.mainView.infoModel.results();
            }
        };
        [weakSelf.navigationController pushViewController:selectBankCardVc animated:YES];
    };
    self.mainView.infoModel.withdrawalResults = ^{//提现成功的结果
        if (weakSelf.withdrawalResults) {
            weakSelf.withdrawalResults();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.mainView.infoModel.setupPayPassword = ^{
        [ZLWarnView showErrorMessageOnView:nil Message:@"请设置支付密码后再操作"];
    };
}

#pragma mark - Lazy
- (ZLWithdrawalView *)mainView {
    if (!_mainView) {
        ZLWithdrawalView *mainView = [[ZLWithdrawalView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:mainView];
        _mainView = mainView;
    }
    return _mainView;
}
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.showGoBack = YES;
        navBar.title = @"提现";
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

@end
