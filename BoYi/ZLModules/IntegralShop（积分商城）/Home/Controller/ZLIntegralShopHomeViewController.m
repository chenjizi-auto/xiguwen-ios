//
//  ZLIntegralShopHomeViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
// 

#import "ZLIntegralShopHomeViewController.h"
#import "ZLIntegralShopHomeView.h"
#import "ZLIntegralDetailViewController.h"
#import "ZLConversionDetailViewController.h"
#import "ZLIntegralGoodsDetailViewController.h"
#import "ZLRedPacketGoodsDetailViewController.h"
#import "ZLIntegralGoodsListViewController.h"
#import "ZLRedPacketGoodsListViewController.h"
#import "ZLIntegralShopH5PageViewController.h"

@interface ZLIntegralShopHomeViewController ()

///
@property (nonatomic,weak) ZLIntegralShopHomeView *integralShopHomeView;
///
@property (nonatomic,weak) UIButton *rightBarButtonItem;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLIntegralShopHomeModel *infoModel;

@end

@implementation ZLIntegralShopHomeViewController

- (void)dealloc {
    [self.integralShopHomeView removeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
    [self integralShopHomeData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.integralShopHomeView startTimer];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.integralShopHomeView stopTimer];
}

#pragma mark - Add
- (void)addSubviews {
    //子视图
    ZLIntegralShopHomeView *integralShopHomeView = [[ZLIntegralShopHomeView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:integralShopHomeView];
    self.integralShopHomeView = integralShopHomeView;
    //初始化模型
    ZLIntegralShopHomeModel *infoModel = [ZLIntegralShopHomeModel new];
    infoModel.token = self.token;
    infoModel.userId = self.userId;
    self.infoModel = infoModel;
    //注册事件
    [self registerEvent];
    //导航项
    [self leftBarButtonItem];
    [self rightBarButtonItem];
}

#pragma mark - RegisterEvent
- (void)registerEvent {
    __weak typeof(self)weakSelf = self;
    //改变导航按钮颜色
    self.integralShopHomeView.changeNavItemColor = ^(CGFloat alpha) {
        alpha == 1.0 ? [weakSelf.leftBarButtonItem setImage:[UIImage imageNamed:@"goback_pink"] forState:UIControlStateNormal] : [weakSelf.leftBarButtonItem setImage:[UIImage imageNamed:@"goback_white"] forState:UIControlStateNormal];;
        [weakSelf.rightBarButtonItem setTitleColor:alpha == 1.0 ? UIColor.blackColor : UIColor.whiteColor forState:UIControlStateNormal];
    };
    //我的积分、兑换记录
    self.integralShopHomeView.function = ^(BOOL isIntegral) {
        isIntegral
        ? [weakSelf rightBarButtonItemAction]
        : [weakSelf gotoConversionDetailViewController];
    };
    //查看详情
    self.integralShopHomeView.lookDetail = ^(ZLIntegralShopHomeModel *model) {
        //商品详情
        if (model.goodsType == ZLIntegralShopHomeGoodsTypeGoods) {
            ZLIntegralGoodsDetailViewController *integralGoodsDetailVc = [ZLIntegralGoodsDetailViewController new];
            integralGoodsDetailVc.keyId = model.keyId;
            integralGoodsDetailVc.userId = weakSelf.userId;
            integralGoodsDetailVc.token = weakSelf.token;
            [weakSelf.navigationController pushViewController:integralGoodsDetailVc animated:YES];
            return;
        }
        //红包详情
        ZLRedPacketGoodsDetailViewController *redPacketGoodsDetailVc = [ZLRedPacketGoodsDetailViewController new];
        redPacketGoodsDetailVc.keyId = model.keyId;
        redPacketGoodsDetailVc.userId = weakSelf.userId;
        redPacketGoodsDetailVc.token = weakSelf.token;
        //首页查看详情时积分被消费的处理
        redPacketGoodsDetailVc.didExpenseIntegral = ^(NSInteger expenseNumber) {
            [weakSelf didExpenseIntegral:expenseNumber];
        };
        [weakSelf.navigationController pushViewController:redPacketGoodsDetailVc animated:YES];
    };
    //区头 - 查看全部
    self.integralShopHomeView.lookAll = ^(NSInteger index) {
        if (!index) {//积分兑换
            ZLIntegralGoodsListViewController *integralGoodsListVc = [ZLIntegralGoodsListViewController new];
            integralGoodsListVc.userId = weakSelf.userId;
            integralGoodsListVc.token = weakSelf.token;
            [weakSelf.navigationController pushViewController:integralGoodsListVc animated:YES];
        }else if (index == 1) {//红包兑换
            ZLRedPacketGoodsListViewController *redPacketGoodsListVc = [ZLRedPacketGoodsListViewController new];
            redPacketGoodsListVc.userId = weakSelf.userId;
            redPacketGoodsListVc.token = weakSelf.token;
            //通过列表进入详情后，查看详情时积分被消费的处理
            redPacketGoodsListVc.didExpenseIntegral = ^(NSInteger expenseNumber) {
                [weakSelf didExpenseIntegral:expenseNumber];
            };
            [weakSelf.navigationController pushViewController:redPacketGoodsListVc animated:YES];
        }
    };
    //签到
    self.integralShopHomeView.sign = ^{
        [weakSelf sign];
    };
    //轮播
    self.integralShopHomeView.bannerClick = ^(ZLIntegralShopHomeModel *model) {
        if (model.bannerSrc) {//h5资源
            ZLIntegralShopH5PageViewController *integralShopH5PageVc = [ZLIntegralShopH5PageViewController new];
            integralShopH5PageVc.navTitle = model.goodsName;
            integralShopH5PageVc.srcPath = model.bannerSrc;
            [weakSelf.navigationController pushViewController:integralShopH5PageVc animated:YES];
        }else {
#warning 往主项目上接入时补充
            if (model.bannerType == ZLIntegralShopHomeBannerTypeWeddingBossPage) {//婚庆商家
                
            }else if (model.bannerType == ZLIntegralShopHomeBannerTypeShopBossPage) {//商城商家
                
            }else if (model.bannerType == ZLIntegralShopHomeBannerTypeExample) {//案例
                
            }else if (model.bannerType == ZLIntegralShopHomeBannerTypeGoods) {//商品
                
            }else if (model.bannerType == ZLIntegralShopHomeBannerTypePrice) {//报价
                
            }
        }
    };
}

#pragma mark - Lazy
- (UIButton *)leftBarButtonItem {
    if (!_leftBarButtonItem) {
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0, 40.0)];
        [sender setImage:[UIImage imageNamed:@"goback_white"] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(leftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        [sender.titleLabel sizeToFit];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
        _leftBarButtonItem = sender;
    }
    return _leftBarButtonItem;
}
- (UIButton *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        UIButton *sender = [[UIButton alloc] init];
        sender.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [sender setTitle:@"积分明细" forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(rightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        [sender.titleLabel sizeToFit];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
        _rightBarButtonItem = sender;
    }
    return _rightBarButtonItem;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralShopHomeModel *)infoModel {
    _infoModel = infoModel;
    self.integralShopHomeView.shopHomeModel = _infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItemAction {
    ZLIntegralDetailViewController *integralDetailVc = [ZLIntegralDetailViewController new];
    integralDetailVc.token = self.token;
    integralDetailVc.userId = self.userId;
    [self.navigationController pushViewController:integralDetailVc animated:YES];
}

#pragma mark - Separate
- (void)gotoConversionDetailViewController {
    ZLConversionDetailViewController *conversionDetailVc = [ZLConversionDetailViewController new];
    conversionDetailVc.token = self.token;
    conversionDetailVc.userId = self.userId;
    [self.navigationController pushViewController:conversionDetailVc animated:YES];
}
- (void)didExpenseIntegral:(NSInteger)number {
    NSInteger currentTotalIntegral = self.infoModel.currentTotalIntegral.integerValue - number;
    self.infoModel.currentTotalIntegral = [NSString stringWithFormat:@"%ld",currentTotalIntegral];
    self.infoModel = self.infoModel;
}

#pragma mark - Request
- (void)integralShopHomeData {//积分商城首页
    __weak typeof(self)weakSelf = self;
    [ZLIntegralShopHomeModel integralShopHomeWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}
- (void)sign {//签到
    __weak typeof(self)weakSelf = self;
    [ZLIntegralShopHomeModel signWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, ZLIntegralShopHomeModel *signModel) {
        if (!sessionErrorState) {
            weakSelf.integralShopHomeView.signModel = signModel;
            weakSelf.infoModel.signState = YES;
        }
    }];
}

@end
