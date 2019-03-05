//
//  ZLAddBankCardCViewController.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/11/1.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLAddBankCardCViewController.h"
#import "ZLAddBankCardCView.h"
#import "ZLNavBar.h"
#import "ZLKeyboardBar.h"

@interface ZLAddBankCardCViewController ()

///主视图
@property (nonatomic,strong) ZLAddBankCardCView *mainView;
///导航条
@property (nonatomic,strong) ZLNavBar *navBar;

@end

@implementation ZLAddBankCardCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainView];
    [self navBar];
    self.mainView.infoModel = [ZLAddBankCardCModel loadModel];
    self.mainView.infoModel.starPhone = self.starPhone;
    self.mainView.infoModel.number = self.number;
    self.mainView.infoModel.name = self.name;
    self.mainView.infoModel.phone = self.phone;
    if (self.mainView.infoModel.load) {
        self.mainView.infoModel.load();
    }
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
    self.mainView.infoModel.goBackList = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLAddBankCardResult" object:nil];
        NSInteger index = [weakSelf.navigationController.viewControllers indexOfObject:weakSelf];
        [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[index - 2] animated:YES];
    };
}

#pragma mark - Lazy
- (ZLAddBankCardCView *)mainView {
    if (!_mainView) {
        ZLAddBankCardCView *mainView = [[ZLAddBankCardCView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:mainView];
        _mainView = mainView;
    }
    return _mainView;
}
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.showGoBack = YES;
        navBar.title = @"身份验证";
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

@end
