//
//  ZLElectronicInvitationHomeViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/5.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationHomeViewController.h"
#import "ZLElectronicInvitationHomeView.h"
#import "ZLElectronicInvitationSelectTemplateViewController.h"
#import "ZLElectronicInvitationPreviewInvitationViewController.h"
#import <IQKeyboardManager.h>
#import "ZLNavBar.h"

@interface ZLElectronicInvitationHomeViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationHomeView *homeView;
///持有数据
@property (nonatomic,strong) ZLElectronicInvitationHomeModel *infoModel;
///导航条（自定义）
@property (nonatomic,weak) ZLNavBar *navBar;

@end

@implementation ZLElectronicInvitationHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
    [self navBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self electronicInvitationHomeData];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = NO;
    keyboardManager.enableAutoToolbar = NO;
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationHomeView *homeView = [[ZLElectronicInvitationHomeView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:homeView];
    self.homeView = homeView;
    //初始化模型
    ZLElectronicInvitationHomeModel *infoModel = [ZLElectronicInvitationHomeModel new];
    infoModel.userId = self.userId;
    infoModel.token = self.token;
    infoModel.page = 1;
    infoModel.count = 6;
    self.infoModel = infoModel;
    //加载数据
    __weak typeof(self)weakSelf = self;
    homeView.loadData = ^{
        [weakSelf electronicInvitationHomeData];
    };
    //创建我的请柬
    homeView.createMyInvitation = ^{
        ZLElectronicInvitationSelectTemplateViewController *electronicInvitationSelectTemplateVc = [ZLElectronicInvitationSelectTemplateViewController new];
        electronicInvitationSelectTemplateVc.userId = weakSelf.userId;
        electronicInvitationSelectTemplateVc.token = weakSelf.token;
        [weakSelf.navigationController pushViewController:electronicInvitationSelectTemplateVc animated:YES];
    };
    //查看详情
    homeView.lookDetail = ^(ZLElectronicInvitationHomeModel *model) {
        ZLElectronicInvitationPreviewInvitationViewController *electronicInvitationPreviewInvitationVc = [ZLElectronicInvitationPreviewInvitationViewController new];
        electronicInvitationPreviewInvitationVc.userId = weakSelf.userId;
        electronicInvitationPreviewInvitationVc.token = weakSelf.token;
        electronicInvitationPreviewInvitationVc.keyId = model.keyId;
        electronicInvitationPreviewInvitationVc.htmlUrl = model.htmlUrl;
        electronicInvitationPreviewInvitationVc.sharetime = model.sharetime;
        electronicInvitationPreviewInvitationVc.shareurl = model.shareurl;
        electronicInvitationPreviewInvitationVc.imageUrl = model.imageUrl;
        [weakSelf.navigationController pushViewController:electronicInvitationPreviewInvitationVc animated:YES];
    };
}

#pragma mark - Lazy
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        navBar.titleLabel.text = @"电子请柬";
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
- (void)setInfoModel:(ZLElectronicInvitationHomeModel *)infoModel {
    _infoModel = infoModel;
    self.homeView.infoModel = infoModel;
}

#pragma mark - Request
- (void)electronicInvitationHomeData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationHomeModel electronicInvitationHomeDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}

@end
