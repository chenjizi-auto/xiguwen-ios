//
//  ZLIntegralGoodsDetailViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralGoodsDetailViewController.h"
#import "ZLIntegralGoodsDetailView.h"
#import "ZLIntegralGoodsSureOrderViewController.h"

@interface ZLIntegralGoodsDetailViewController ()

///
@property (nonatomic,weak) ZLIntegralGoodsDetailView *integralGoodsDetailView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLIntegralGoodsDetailModel *infoModel;
///
@property (nonatomic,unsafe_unretained) BOOL hiddenStatusBar;

@end

@implementation ZLIntegralGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self integralGoodsDetailData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - Add
- (void)addSubviews {
    ZLIntegralGoodsDetailView *integralGoodsDetailView = [[ZLIntegralGoodsDetailView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:integralGoodsDetailView];
    self.integralGoodsDetailView = integralGoodsDetailView;
    //初始化模型
    ZLIntegralGoodsDetailModel *infoModel = [ZLIntegralGoodsDetailModel new];
    infoModel.keyId = self.keyId;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //马上兑换
    __weak typeof(self)weakSelf = self;
    integralGoodsDetailView.clickFunctionBar = ^{
        ZLIntegralGoodsSureOrderViewController *integralGoodsSureOrderVc = [ZLIntegralGoodsSureOrderViewController new];
        integralGoodsSureOrderVc.keyId = weakSelf.keyId;
        integralGoodsSureOrderVc.userId = weakSelf.userId;
        integralGoodsSureOrderVc.token = weakSelf.token;
        [weakSelf.navigationController pushViewController:integralGoodsSureOrderVc animated:YES];
    };
    //查看猜你喜欢详情
    integralGoodsDetailView.lookGuessYouLikeDetail = ^(ZLIntegralGoodsDetailModel *model) {
        ZLIntegralGoodsDetailViewController *integralGoodsDetailVc = [ZLIntegralGoodsDetailViewController new];
        integralGoodsDetailVc.keyId = model.keyId;
        [weakSelf.navigationController pushViewController:integralGoodsDetailVc animated:YES];
    };
    //隐藏状态栏
    integralGoodsDetailView.hiddeStatusBar = ^(BOOL ishidden) {
        weakSelf.hiddenStatusBar = ishidden;
    };
}

#pragma mark - Lazy
- (UIButton *)leftBarButtonItem {
    if (!_leftBarButtonItem) {
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0, 40.0)];
        [sender setImage:[UIImage imageNamed:@"goback_pink"] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(leftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        [sender.titleLabel sizeToFit];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
        _leftBarButtonItem = sender;
    }
    return _leftBarButtonItem;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralGoodsDetailModel *)infoModel {
    _infoModel = infoModel;
    self.integralGoodsDetailView.infoModel = infoModel;
}
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setStatusBar];
}

#pragma mark - Separate
- (void)setStatusBar {
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
}
- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)integralGoodsDetailData {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsDetailModel integralGoodsDetailWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
