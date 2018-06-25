//
//  ZLElectronicInvitationCashGiftViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationCashGiftViewController.h"
#import "ZLElectronicInvitationCashGiftView.h"
#import "ZLNavBar.h"

@interface ZLElectronicInvitationCashGiftViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationCashGiftView *homeView;
///持有数据
@property (nonatomic,strong) ZLElectronicInvitationCashGiftModel *infoModel;
///导航条（自定义）
@property (nonatomic,weak) ZLNavBar *navBar;

@end

@implementation ZLElectronicInvitationCashGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self cashGiftData];
    [self navBar];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationCashGiftView *homeView = [[ZLElectronicInvitationCashGiftView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:homeView];
    self.homeView = homeView;
    //初始化模型
    ZLElectronicInvitationCashGiftModel *infoModel = [ZLElectronicInvitationCashGiftModel new];
    infoModel.userId = self.userId;
    infoModel.token = self.token;
    infoModel.keyId = self.keyId;
    infoModel.page = 1;
    infoModel.count = 9;
    self.infoModel = infoModel;
    //加载数据
    __weak typeof(self)weakSelf = self;
    homeView.loadData = ^{
        [weakSelf cashGiftData];
    };
}

#pragma mark - Lazy
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.titleLabel.text = @"礼金";
        [navBar.goBackButton setImage:[UIImage imageNamed:@"goback_white"] forState:UIControlStateNormal];
        __weak typeof(self)weakSelf = self;
        navBar.goBack = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationCashGiftModel *)infoModel {
    _infoModel = infoModel;
    self.homeView.infoModel = infoModel;
}

#pragma mark - Request
- (void)cashGiftData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationCashGiftModel cashGiftDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}

@end
