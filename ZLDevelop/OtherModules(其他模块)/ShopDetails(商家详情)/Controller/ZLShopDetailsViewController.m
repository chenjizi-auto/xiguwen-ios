//
//  ZLShopDetailsViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsViewController.h"
#import "ZLShopDetailsView.h"

@interface ZLShopDetailsViewController ()

///视图层
@property (nonatomic,weak) ZLShopDetailsView *shopDetailsView;
///数据模型
@property (nonatomic,strong) ZLShopDetailsModel *dataModel;

@end

@implementation ZLShopDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加视图
    [self addSubviews];
    //加载数据
    [self requestShopDetails];
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
    //承载子视图
    [self shopDetailsView];
    //注册事件
    [self registerEvent];
    //加载静态数据
    self.dataModel = [ZLShopDetailsModel loadStaticDataWithShopId:self.shopId];
}

#pragma mark - Set
- (void)setDataModel:(ZLShopDetailsModel *)dataModel {
    _dataModel = dataModel;
    self.shopDetailsView.dataModel = dataModel;
}

#pragma mark - RegisterEvent
- (void)registerEvent {
    __weak typeof(self)weakSelf = self;
    //加载数据
    self.shopDetailsView.loadData = ^{
        [weakSelf requestShopDetails];
    };
}

#pragma mark - Lazy
- (ZLShopDetailsView *)shopDetailsView {
    if (!_shopDetailsView) {
        ZLShopDetailsView *shopDetailsView = [[ZLShopDetailsView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:shopDetailsView];
        _shopDetailsView = shopDetailsView;
    }
    return _shopDetailsView;
}

#pragma mark - Request
- (void)requestShopDetails {
    __weak typeof(self)weakSelf = self;
    [ZLShopDetailsModel requestShopDetailsWithModel:self.dataModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.dataModel = weakSelf.dataModel;
        }
    }];
}

@end
