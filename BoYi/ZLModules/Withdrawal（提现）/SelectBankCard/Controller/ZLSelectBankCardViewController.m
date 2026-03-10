//
//  ZLSelectBankCardViewController.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/30.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLSelectBankCardViewController.h"
#import "ZLSelectBankCardView.h"
#import "ZLNavBar.h"
#import "ZLAddBankCardAViewController.h"

@interface ZLSelectBankCardViewController ()

///主视图
@property (nonatomic,strong) ZLSelectBankCardView *mainView;
///导航条
@property (nonatomic,strong) ZLNavBar *navBar;

@end

@implementation ZLSelectBankCardViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ZLAddBankCardResult" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"ZLAddBankCardResult" object:nil];
    [self mainView];
    [self navBar];
    self.mainView.infoModel = [ZLSelectBankCardModel loadModel];
    self.mainView.infoModel.keyId = self.keyId;
    self.mainView.infoModel.load();
    [self registerAction];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Register
- (void)registerAction {
    __weak typeof(self)weakSelf = self;
    self.navBar.leftItemAction = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.navBar.rightItemAction = ^{
        ZLAddBankCardAViewController *addBankCardAVc = [ZLAddBankCardAViewController new];
        addBankCardAVc.starPhone = weakSelf.starPhone;
        addBankCardAVc.phone = weakSelf.phone;
        [weakSelf.navigationController pushViewController:addBankCardAVc animated:YES];
    };
    self.mainView.infoModel.action = ^(ZLSelectBankCardModel *unitModel) {
        if (weakSelf.didSelected) {
            weakSelf.didSelected(unitModel);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
- (void)reloadData {
    if (self.mainView.infoModel.load) {
        self.mainView.infoModel.load();
    }
}

#pragma mark - Lazy
- (ZLSelectBankCardView *)mainView {
    if (!_mainView) {
        ZLSelectBankCardView *mainView = [[ZLSelectBankCardView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:mainView];
        _mainView = mainView;
    }
    return _mainView;
}
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.showGoBack = YES;
        navBar.title = @"选择账户";
        navBar.rightItemImageName = @"添加银行卡";
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

@end
