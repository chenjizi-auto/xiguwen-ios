//
//  ZLElectronicInvitationSelectTemplateViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectTemplateViewController.h"
#import "ZLElectronicInvitationSelectTemplateView.h"
#import "ZLElectronicInvitationPreviewTemplateViewController.h"
#import "ZLNavBar.h"

@interface ZLElectronicInvitationSelectTemplateViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationSelectTemplateView *selectTemplateView;
///持有数据
@property (nonatomic,strong) ZLElectronicInvitationSelectTemplateModel *infoModel;
///导航条（自定义）
@property (nonatomic,weak) ZLNavBar *navBar;

@end

@implementation ZLElectronicInvitationSelectTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
    [self selectTemplateData];
    [self navBar];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationSelectTemplateView *selectTemplateView = [[ZLElectronicInvitationSelectTemplateView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:selectTemplateView];
    self.selectTemplateView = selectTemplateView;
    //初始化模型
    [self configBasicsModel];
    //加载数据
    __weak typeof(self)weakSelf = self;
    selectTemplateView.loadData = ^{
        [weakSelf selectTemplateData];
    };
    //查看详情
    selectTemplateView.lookDetail = ^(ZLElectronicInvitationSelectTemplateModel *model) {
        ZLElectronicInvitationPreviewTemplateViewController *electronicInvitationPreviewInvitationVc = [ZLElectronicInvitationPreviewTemplateViewController new];
        electronicInvitationPreviewInvitationVc.userId = weakSelf.userId;
        electronicInvitationPreviewInvitationVc.token = weakSelf.token;
        electronicInvitationPreviewInvitationVc.keyId = model.keyId;
        electronicInvitationPreviewInvitationVc.htmlUrl = model.htmlUrl;
        [weakSelf.navigationController pushViewController:electronicInvitationPreviewInvitationVc animated:YES];
    };
}

#pragma mark - Separate
- (void)configBasicsModel {
    ZLElectronicInvitationSelectTemplateModel *infoModel = [ZLElectronicInvitationSelectTemplateModel new];
    infoModel.userId = self.userId;
    infoModel.token = self.token;
    self.infoModel = infoModel;
}

#pragma mark - Lazy
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        navBar.titleLabel.text = @"选择模板";
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
- (void)setInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel {
    _infoModel = infoModel;
    self.selectTemplateView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)selectTemplateData {//积分商城首页
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationSelectTemplateModel selectTemplateDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}

@end
