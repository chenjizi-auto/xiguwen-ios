//
//  ZLIntegralGoodsOrderDetailViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailViewController.h"
#import "ZLIntegralGoodsOrderDetailView.h"
#import "ZLIntegralGoodsDetailViewController.h"

@interface ZLIntegralGoodsOrderDetailViewController ()

///
@property (nonatomic,weak) ZLIntegralGoodsOrderDetailView *integralGoodsOrderDetailView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLIntegralGoodsOrderDetailModel *infoModel;

@end

@implementation ZLIntegralGoodsOrderDetailViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [self addSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self integralGoodsOrderDetailData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.integralGoodsOrderDetailView stopTimer];
}

#pragma mark - Add
- (void)addSubviews {
    ZLIntegralGoodsOrderDetailView *integralGoodsOrderDetailView = [[ZLIntegralGoodsOrderDetailView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:integralGoodsOrderDetailView];
    self.integralGoodsOrderDetailView = integralGoodsOrderDetailView;
    //初始化模型
    ZLIntegralGoodsOrderDetailModel *infoModel = [ZLIntegralGoodsOrderDetailModel new];
    infoModel.keyId = self.keyId;
    infoModel.token = self.token;
    infoModel.userId = self.userId;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //查看猜你喜欢详情
    __weak typeof(self)weakSelf = self;
    integralGoodsOrderDetailView.lookGuessYouLikeDetail = ^(ZLIntegralGoodsOrderDetailModel *model) {
        ZLIntegralGoodsDetailViewController *integralGoodsDetailVc = [ZLIntegralGoodsDetailViewController new];
        integralGoodsDetailVc.keyId = model.keyId;
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
- (void)setInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel {
    _infoModel = infoModel;
    self.integralGoodsOrderDetailView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)willEnterForeground {
    [self integralGoodsOrderDetailData];
}
- (void)didEnterBackground {
    [self.integralGoodsOrderDetailView stopTimer];
}

#pragma mark - Request
- (void)integralGoodsOrderDetailData {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsOrderDetailModel integralGoodsOrderDetailWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
