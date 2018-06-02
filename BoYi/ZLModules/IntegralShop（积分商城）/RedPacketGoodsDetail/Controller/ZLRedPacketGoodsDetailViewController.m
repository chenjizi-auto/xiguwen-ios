//
//  ZLRedPacketGoodsDetailViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsDetailViewController.h"
#import "ZLRedPacketGoodsDetailView.h"

@interface ZLRedPacketGoodsDetailViewController ()

///
@property (nonatomic,weak) ZLRedPacketGoodsDetailView *redPacketGoodsDetailView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLRedPacketGoodsDetailModel *infoModel;

@end

@implementation ZLRedPacketGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.userId);
    [self addSubviews];
    [self redPacketGoodsDetailData];
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
    ZLRedPacketGoodsDetailView *redPacketGoodsDetailView = [[ZLRedPacketGoodsDetailView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:redPacketGoodsDetailView];
    self.redPacketGoodsDetailView = redPacketGoodsDetailView;
    //初始化模型
    ZLRedPacketGoodsDetailModel *infoModel = [ZLRedPacketGoodsDetailModel new];
    infoModel.keyId = self.keyId;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //马上兑换
    __weak typeof(self)weakSelf = self;
    redPacketGoodsDetailView.clickFunctionBar = ^{
#warning 发起支付待交互
    };
    //查看猜你喜欢详情
    redPacketGoodsDetailView.lookGuessYouLikeDetail = ^(ZLRedPacketGoodsDetailModel *model) {
        ZLRedPacketGoodsDetailViewController *redPacketGoodsDetailVc = [ZLRedPacketGoodsDetailViewController new];
        redPacketGoodsDetailVc.keyId = model.keyId;
        redPacketGoodsDetailVc.userId = weakSelf.userId;
        redPacketGoodsDetailVc.token = weakSelf.token;
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
- (void)setInfoModel:(ZLRedPacketGoodsDetailModel *)infoModel {
    _infoModel = infoModel;
    self.redPacketGoodsDetailView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)redPacketGoodsDetailData {
    __weak typeof(self)weakSelf = self;
    [ZLRedPacketGoodsDetailModel redPacketGoodsDetailWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
