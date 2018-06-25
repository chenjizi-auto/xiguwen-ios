//
//  ZLElectronicInvitationGuestsReplyViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationGuestsReplyViewController.h"
#import "ZLElectronicInvitationGuestsReplyView.h"
#import "ZLNavBar.h"

@interface ZLElectronicInvitationGuestsReplyViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationGuestsReplyView *guestsReplyView;
///持有数据
@property (nonatomic,strong) ZLElectronicInvitationGuestsReplyModel *infoModel;
///导航条（自定义）
@property (nonatomic,weak) ZLNavBar *navBar;

@end

@implementation ZLElectronicInvitationGuestsReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
    [self guestsReplyData];
    [self navBar];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationGuestsReplyView *guestsReplyView = [[ZLElectronicInvitationGuestsReplyView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:guestsReplyView];
    self.guestsReplyView = guestsReplyView;
    //初始化模型
    ZLElectronicInvitationGuestsReplyModel *infoModel = [ZLElectronicInvitationGuestsReplyModel new];
    infoModel.userId = self.userId;
    infoModel.token = self.token;
    infoModel.keyId = self.keyId;
    infoModel.currentSection = self.lookGuests;
    self.infoModel = infoModel;
    //加载数据
    __weak typeof(self)weakSelf = self;
    guestsReplyView.loadData = ^{
        [weakSelf guestsReplyData];
    };
    //删除数据
    guestsReplyView.deleteData = ^{
        [weakSelf deleteData];
    };
}

#pragma mark - Lazy
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        navBar.titleLabel.text = @"宾客回复";
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
- (void)setInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel {
    _infoModel = infoModel;
    self.guestsReplyView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)guestsReplyData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationGuestsReplyModel guestsReplyDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}
- (void)deleteData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationGuestsReplyModel dleteDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (errorMessage) {
            weakSelf.guestsReplyView.errorMessage = errorMessage;
            return;
        }
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}

@end
