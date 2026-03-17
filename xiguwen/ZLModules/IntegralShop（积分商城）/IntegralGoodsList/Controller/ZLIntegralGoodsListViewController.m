//
//  ZLIntegralGoodsListViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsListViewController.h"
#import "ZLIntegralGoodsListView.h"
#import "ZLIntegralGoodsDetailViewController.h"

@interface ZLIntegralGoodsListViewController ()

///
@property (nonatomic,weak) ZLIntegralGoodsListView *integralGoodsListView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLIntegralGoodsListModel *infoModel;

@end

@implementation ZLIntegralGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"积分商品";
    [self addSubviews];
    [self integralGoodsListData];
}

#pragma mark - Add
- (void)addSubviews {
    ZLIntegralGoodsListView *integralGoodsListView = [[ZLIntegralGoodsListView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:integralGoodsListView];
    self.integralGoodsListView = integralGoodsListView;
    //初始化模型
    ZLIntegralGoodsListModel *infoModel = [ZLIntegralGoodsListModel new];
    infoModel.page = 1;
    infoModel.count = [[UIApplication sharedApplication] statusBarFrame].size.height == 20.0 ? 6 : 8;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //加载数据
    __weak typeof(self)weakSelf = self;
    integralGoodsListView.loadData = ^() {
        [weakSelf integralGoodsListData];
    };
    //查看详情
    integralGoodsListView.lookDetail = ^(ZLIntegralGoodsListModel *model) {
        ZLIntegralGoodsDetailViewController *integralGoodsDetailVc = [ZLIntegralGoodsDetailViewController new];
        integralGoodsDetailVc.keyId = model.keyId;
        integralGoodsDetailVc.userId = weakSelf.userId;
        integralGoodsDetailVc.token = weakSelf.token;
        [weakSelf.navigationController pushViewController:integralGoodsDetailVc animated:YES];
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
- (void)setInfoModel:(ZLIntegralGoodsListModel *)infoModel {
    _infoModel = infoModel;
    self.integralGoodsListView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)integralGoodsListData {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsListModel integralGoodsListWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
