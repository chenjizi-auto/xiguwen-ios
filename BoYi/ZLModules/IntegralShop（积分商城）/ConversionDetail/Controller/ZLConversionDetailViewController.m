//
//  ZLConversionDetailViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLConversionDetailViewController.h"
#import "ZLConversionDetailView.h"
#import "ZLIntegralGoodsOrderDetailViewController.h"

@interface ZLConversionDetailViewController ()

///
@property (nonatomic,weak) ZLConversionDetailView *conversionDetailView;
///
@property (nonatomic,strong) UIView *titleView;
///持有数据
@property (nonatomic,strong) ZLConversionDetailModel *infoModel;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;

@end

@implementation ZLConversionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"兑换记录";
    [self addSubviews];
    [self conversionDetailData];
}

#pragma mark - Add
- (void)addSubviews {
    ZLConversionDetailView *conversionDetailView = [[ZLConversionDetailView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:conversionDetailView];
    self.conversionDetailView = conversionDetailView;
    //初始化模型
    ZLConversionDetailModel *infoModel = [ZLConversionDetailModel new];
    infoModel.token = self.token;
    infoModel.userId = self.userId;
    infoModel.conversionType = ZLConversionTypeGoods;
    infoModel.count = 6;
    ZLConversionDetailModel *goodsModel = [ZLConversionDetailModel new];
    goodsModel.page = 1;
    ZLConversionDetailModel *redPacketModel = [ZLConversionDetailModel new];
    redPacketModel.page = 1;
    infoModel.goodsModel = goodsModel;
    infoModel.redPacketModel = redPacketModel;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //加载数据
    __weak typeof(self)weakSelf = self;
    conversionDetailView.loadData = ^() {
        [weakSelf conversionDetailData];
    };
    //查看详情
    conversionDetailView.lookDetail = ^(ZLConversionDetailModel *goodsModel) {
        ZLIntegralGoodsOrderDetailViewController *integralGoodsOrderDetailVc = [ZLIntegralGoodsOrderDetailViewController new];
        integralGoodsOrderDetailVc.keyId = goodsModel.keyId;
        integralGoodsOrderDetailVc.userId = weakSelf.userId;
        integralGoodsOrderDetailVc.token = weakSelf.token;
        [weakSelf.navigationController pushViewController:integralGoodsOrderDetailVc animated:YES];
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
- (void)setInfoModel:(ZLConversionDetailModel *)infoModel {
    _infoModel = infoModel;
    self.conversionDetailView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)conversionDetailData {//积分商城首页
    __weak typeof(self)weakSelf = self;
    [ZLConversionDetailModel conversionDetailWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
