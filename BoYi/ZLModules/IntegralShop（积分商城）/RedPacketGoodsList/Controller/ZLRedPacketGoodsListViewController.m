//
//  ZLRedPacketGoodsListViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsListViewController.h"
#import "ZLRedPacketGoodsListView.h"
#import "ZLRedPacketGoodsDetailViewController.h"

@interface ZLRedPacketGoodsListViewController ()

///
@property (nonatomic,weak) ZLRedPacketGoodsListView *redPacketGoodsListView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLRedPacketGoodsListModel *infoModel;

@end

@implementation ZLRedPacketGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"红包商品";
    [self addSubviews];
    [self redPacketGoodsListData];
}

#pragma mark - Add
- (void)addSubviews {
    ZLRedPacketGoodsListView *redPacketGoodsListView = [[ZLRedPacketGoodsListView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:redPacketGoodsListView];
    self.redPacketGoodsListView = redPacketGoodsListView;
    //初始化模型
    ZLRedPacketGoodsListModel *infoModel = [ZLRedPacketGoodsListModel new];
    infoModel.page = 1;
    infoModel.count = [[UIApplication sharedApplication] statusBarFrame].size.height == 20.0 ? 6 : 8;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //加载数据
    __weak typeof(self)weakSelf = self;
    redPacketGoodsListView.loadData = ^() {
        [weakSelf redPacketGoodsListData];
    };
    //查看详情
    redPacketGoodsListView.lookDetail = ^(ZLRedPacketGoodsListModel *model) {
        ZLRedPacketGoodsDetailViewController *redPacketGoodsDetailVc = [ZLRedPacketGoodsDetailViewController new];
        redPacketGoodsDetailVc.keyId = model.keyId;
        redPacketGoodsDetailVc.userId = weakSelf.userId;
        redPacketGoodsDetailVc.token = weakSelf.token;
        redPacketGoodsDetailVc.didExpenseIntegral = ^(NSInteger expenseNumber) {
            if (weakSelf.didExpenseIntegral) {
                weakSelf.didExpenseIntegral(expenseNumber);
            }
        };
        [weakSelf.navigationController pushViewController:redPacketGoodsDetailVc animated:YES];
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
- (void)setInfoModel:(ZLRedPacketGoodsListModel *)infoModel {
    _infoModel = infoModel;
    self.redPacketGoodsListView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)redPacketGoodsListData {
    __weak typeof(self)weakSelf = self;
    [ZLRedPacketGoodsListModel redPacketGoodsListWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
