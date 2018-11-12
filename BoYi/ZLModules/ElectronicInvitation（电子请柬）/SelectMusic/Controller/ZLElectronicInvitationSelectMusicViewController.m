//
//  ZLElectronicInvitationSelectMusicViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectMusicViewController.h"
#import "ZLElectronicInvitationSelectMusicView.h"
#import "ZLNavBar.h"

@interface ZLElectronicInvitationSelectMusicViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationSelectMusicView *selectMusicView;
///持有数据
@property (nonatomic,strong) ZLElectronicInvitationSelectMusicModel *infoModel;
///导航条（自定义）
@property (nonatomic,weak) ZLNavBar *navBar;

@end

@implementation ZLElectronicInvitationSelectMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
    [self selectMusicData];
    [self navBar];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationSelectMusicView *selectMusicView = [[ZLElectronicInvitationSelectMusicView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:selectMusicView];
    self.selectMusicView = selectMusicView;
    //初始化模型
    ZLElectronicInvitationSelectMusicModel *infoModel = [ZLElectronicInvitationSelectMusicModel new];
    infoModel.currenMusicModel = self.musicModel;
    infoModel.keyId = self.keyId;
    infoModel.userId = self.userId;
    infoModel.token = self.token;
    self.infoModel = infoModel;
    //加载数据
    __weak typeof(self)weakSelf = self;
    selectMusicView.loadData = ^{
        [weakSelf selectMusicData];
    };
}

#pragma mark - Lazy
- (ZLNavBar *)navBar {
    if (!_navBar) {
        ZLNavBar *navBar = [[ZLNavBar alloc] init];
        navBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        navBar.titleLabel.text = @"选择音乐";
        [navBar.goBackButton setImage:[UIImage imageNamed:@"goback_white"] forState:UIControlStateNormal];
        __weak typeof(self)weakSelf = self;
        navBar.goBack = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [navBar.rightButton setTitle:@"保存" forState:UIControlStateNormal];
        navBar.rightAction = ^{
            [weakSelf rightBarButtonItemAction];
        };
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel {
    _infoModel = infoModel;
    self.selectMusicView.infoModel = infoModel;
}

#pragma mark - Action
- (void)rightBarButtonItemAction {
    if (!self.infoModel.currenMusicModel) {
        self.selectMusicView.errorMessage = @"请先选择音乐";
        return;
    }
    self.selectMusicView.showHud = YES;
    [self saveMusicData];
}

#pragma mark - Request
- (void)selectMusicData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationSelectMusicModel selectMusicDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}
- (void)saveMusicData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationSelectMusicModel saveMusicDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        weakSelf.selectMusicView.showHud = NO;
        if (errorMessage) {
            weakSelf.selectMusicView.errorMessage = errorMessage;
            return;
        }
        if (!sessionErrorState) {
            if (weakSelf.clickRow) {
                weakSelf.clickRow(weakSelf.infoModel.currenMusicModel);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

@end
