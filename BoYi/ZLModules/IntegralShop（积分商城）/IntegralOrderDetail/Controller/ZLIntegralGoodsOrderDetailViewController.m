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
#import "ShouyinTaiViewController.h"
#import "XLPasswordView.h"
#import "LookWuliuViewController.h"

@interface ZLIntegralGoodsOrderDetailViewController ()<XLPasswordViewDelegate>

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
        integralGoodsDetailVc.userId = weakSelf.userId;
        integralGoodsDetailVc.token = weakSelf.token;
        [weakSelf.navigationController pushViewController:integralGoodsDetailVc animated:YES];
    };
    //订单交互
    integralGoodsOrderDetailView.operationOrder = ^(ZLIntegralGoodsOrderDetailViewInteractionType interactionType) {
        if (interactionType == ZLIntegralGoodsOrderDetailViewInteractionTypeCancelOrder) {
            [weakSelf cancelOrder];
        }else if (interactionType == ZLIntegralGoodsOrderDetailViewInteractionTypeGoToPay) {
            [weakSelf.infoModel.payPrice floatValue]
            //收银台付款
            ? [weakSelf gotoCheckstand]
            //积分立刻消费（无需收银台）
            : [weakSelf nowPay];
        }else if (interactionType == ZLIntegralGoodsOrderDetailViewInteractionTypeLookLogistics) {
            [weakSelf gotoLookLogistics];
        }else if (interactionType == ZLIntegralGoodsOrderDetailViewInteractionTypeSureReceive) {
            [weakSelf sureReceive];
        }
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
    //回到最近的商品详情页
    if (self.interfaceType == ZLOrderDetailInterfaceTypeIntegralSureOrder
        || self.interfaceType == ZLOrderDetailInterfaceTypeCheckstandInterface) {
        CGFloat count = self.navigationController.childViewControllers.count;
        for (NSInteger index = 0; index < count; index++) {
            UIViewController *viewController = self.navigationController.childViewControllers[index];
            if (viewController == self) {
                NSInteger value = self.interfaceType == ZLOrderDetailInterfaceTypeIntegralSureOrder
                                ? 2
                                : 3;
                [self.navigationController popToViewController:self.navigationController.childViewControllers[index - value] animated:YES];
                break;
            }
        }
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)willEnterForeground {
    [self integralGoodsOrderDetailData];
}
- (void)didEnterBackground {
    [self.integralGoodsOrderDetailView stopTimer];
}

#pragma mark - Separate
- (void)gotoCheckstand {
    ShouyinTaiViewController *shouyinTaiVc = [ShouyinTaiViewController new];
    shouyinTaiVc.bianhao = self.infoModel.orderNumber;
    shouyinTaiVc.price = self.infoModel.payPrice;
    shouyinTaiVc.integral = self.infoModel.goodsPrice;
    shouyinTaiVc.interfaceType = ZLCheckstandInterfaceTypeIntegralOrderDetail;
    [self.navigationController pushViewController:shouyinTaiVc animated:YES];
}
- (void)nowPay {
    XLPasswordView *passwordView = [[XLPasswordView alloc] init];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.integralGoodsOrderDetailView];
}
- (void)gotoLookLogistics {
    LookWuliuViewController *lookWuliuVc = [[LookWuliuViewController alloc] init];
    lookWuliuVc.id = [self.keyId integerValue];
    lookWuliuVc.imageurl = self.infoModel.goodsUrl;
    lookWuliuVc.isIntegral = YES;
    [self.navigationController pushViewController:lookWuliuVc animated:YES];
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
- (void)cancelOrder {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsOrderDetailModel cancelOrderWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (!sessionErrorState) {
            if (errorMessage) {
                weakSelf.integralGoodsOrderDetailView.errorMessage = errorMessage;
                [weakSelf integralGoodsOrderDetailData];
                return;
            }
            [weakSelf integralGoodsOrderDetailData];
            return;
        }
    }];
}
- (void)sureReceive {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsOrderDetailModel sureOrderWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (!sessionErrorState) {
            if (errorMessage) {
                weakSelf.integralGoodsOrderDetailView.errorMessage = errorMessage;
                [weakSelf integralGoodsOrderDetailData];
                return;
            }
            [weakSelf integralGoodsOrderDetailData];
            return;
        }
    }];
}

#pragma mark - XLPasswordViewDelegate
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password {
    self.infoModel.password = password;
    __weak typeof(self)weakSelf = self;
    __weak typeof(passwordView)weakPasswordView = passwordView;
    [ZLIntegralGoodsOrderDetailModel payOrderWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (!sessionErrorState) {
            [weakPasswordView hidePasswordView];
            if (errorMessage) {
                weakSelf.integralGoodsOrderDetailView.errorMessage = errorMessage;
                return;
            }
            [weakSelf integralGoodsOrderDetailData];
            return;
        }
    }];
}

@end
