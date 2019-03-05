//
//  ZLAddBankCardAViewController.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/31.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLAddBankCardAViewController.h"
#import "ZLAddBankCardAView.h"
#import "ZLNavBar.h"
#import "ZLKeyboardBar.h"
#import "ZLAddBankCardCViewController.h"

@interface ZLAddBankCardAViewController ()

///主视图
@property (nonatomic,strong) ZLAddBankCardAView *mainView;
///导航条
@property (nonatomic,strong) ZLNavBar *navBar;

@end

@implementation ZLAddBankCardAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainView];
    [self navBar];
    self.mainView.infoModel = [ZLAddBankCardAModel loadModel];
    [self registerAction];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ZLKeyboardBar.shared showInView:self.view];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [ZLKeyboardBar.shared showInView:nil];
}

#pragma mark - Register
- (void)registerAction {
    __weak typeof(self)weakSelf = self;
    self.navBar.leftItemAction = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.mainView.infoModel.next = ^{
        ZLAddBankCardCViewController *addBankCardCVc = [ZLAddBankCardCViewController new];
        addBankCardCVc.number = weakSelf.mainView.infoModel.number;
        addBankCardCVc.name = weakSelf.mainView.infoModel.name;
        addBankCardCVc.starPhone = weakSelf.starPhone;
        addBankCardCVc.phone = weakSelf.phone;
        [weakSelf.navigationController pushViewController:addBankCardCVc animated:YES];
    };
}

#pragma mark - Lazy
- (ZLAddBankCardAView *)mainView {
    if (!_mainView) {
        ZLAddBankCardAView *mainView = [[ZLAddBankCardAView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:mainView];
        _mainView = mainView;
    }
    return _mainView;
}
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.showGoBack = YES;
        navBar.title = @"添加账户";
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

@end
