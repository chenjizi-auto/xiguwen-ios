//
//  ZLIntegralGoodsSureOrderViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsSureOrderViewController.h"
#import "ZLIntegralGoodsSureOrderView.h"
#import "ShouHuodizhiViewController.h"
#import "ShouyinTaiViewController.h"
#import "XLPasswordView.h"
#import "ZLIntegralGoodsOrderDetailViewController.h"

@interface ZLIntegralGoodsSureOrderViewController ()<XLPasswordViewDelegate>

///
@property (nonatomic,weak) ZLIntegralGoodsSureOrderView *integralGoodsSureOrderView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;
///持有数据
@property (nonatomic,strong) ZLIntegralGoodsSureOrderModel *infoModel;

@end

@implementation ZLIntegralGoodsSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";
    [self addSubviews];
    [self integralGoodsSureOrderData];
}

#pragma mark - Add
- (void)addSubviews {
    ZLIntegralGoodsSureOrderView *integralGoodsSureOrderView = [[ZLIntegralGoodsSureOrderView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:integralGoodsSureOrderView];
    self.integralGoodsSureOrderView = integralGoodsSureOrderView;
    //初始化模型
    ZLIntegralGoodsSureOrderModel *infoModel = [ZLIntegralGoodsSureOrderModel new];
    infoModel.keyId = self.keyId;
    infoModel.token = self.token;
    infoModel.userId = self.userId;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //提交订单
    __weak typeof(self)weakSelf = self;
    integralGoodsSureOrderView.clickFunctionBar = ^{
        [weakSelf commitOrderData];
    };
    //选择地址
    integralGoodsSureOrderView.clickAddress = ^{
        ShouHuodizhiViewController *shouHuodizhiVc = [ShouHuodizhiViewController new];
        shouHuodizhiVc.didGetModel = ^(Addressarray *model) {
            [weakSelf giveValueWithAddressModel:model];
        };
        [weakSelf.navigationController pushViewController:shouHuodizhiVc animated:YES];
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
- (void)setInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel {
    _infoModel = infoModel;
    self.integralGoodsSureOrderView.infoModel = infoModel;
}

#pragma mark - Separate
- (void)giveValueWithAddressModel:(Addressarray *)model {
    self.infoModel.addressId = [NSString stringWithFormat:@"%ld",model.id];
    self.infoModel.name = model.username;
    self.infoModel.phone = model.mobile;
    NSString *address = @"";
    if (model.province) {
        address = [address stringByAppendingString:model.province];
    }
    if (model.city) {
        address = [address stringByAppendingString:model.city];
    }
    if (model.county) {
        address = [address stringByAppendingString:model.county];
    }
    if (model.site) {
        address = [address stringByAppendingString:model.site];
    }
    self.infoModel.address = address;
    CGFloat height = [self.infoModel.address boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 100.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
    self.infoModel.addressHeight = height > 20.0 ? height : 20.0;
    self.infoModel = self.infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)integralGoodsSureOrderData {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsSureOrderModel integralGoodsSureOrderWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}
- (void)commitOrderData {
    __weak typeof(self)weakSelf = self;
    [ZLIntegralGoodsSureOrderModel commitOrderWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (!sessionErrorState) {
            //展示后台提示信息
            if (errorMessage) {
                weakSelf.integralGoodsSureOrderView.errorMessage = errorMessage;
                return;
            }
            if (!weakSelf.infoModel.isSingleIntegral) {
                ShouyinTaiViewController *shouyinTaiVc = [ShouyinTaiViewController new];
                shouyinTaiVc.bianhao = weakSelf.infoModel.orderNumber;
                shouyinTaiVc.price = weakSelf.infoModel.money;
                shouyinTaiVc.integral = weakSelf.infoModel.goodsPrice;
                shouyinTaiVc.interfaceType = ZLCheckstandInterfaceTypeIntegralSureOrder;
                [weakSelf.navigationController pushViewController:shouyinTaiVc animated:YES];
                return;
            }
            //单积分，在本页进行支付交易
            XLPasswordView *passwordView = [[XLPasswordView alloc] init];
            passwordView.delegate = weakSelf;
            [passwordView showPasswordInView:weakSelf.integralGoodsSureOrderView];
            return;
        }
    }];
}

#pragma mark - XLPasswordViewDelegate
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password {
    self.infoModel.password = password;
    __weak typeof(self)weakSelf = self;
    __weak typeof(passwordView)weakPasswordView = passwordView;
    [ZLIntegralGoodsSureOrderModel integralGoodsPayWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (!sessionErrorState) {
            [weakPasswordView hidePasswordView];
            if (errorMessage) {
                weakSelf.integralGoodsSureOrderView.errorMessage = errorMessage;
                return;
            }
            ZLIntegralGoodsOrderDetailViewController *integralGoodsOrderDetailVc = [ZLIntegralGoodsOrderDetailViewController new];
            integralGoodsOrderDetailVc.keyId = weakSelf.infoModel.orderId;
            integralGoodsOrderDetailVc.token = [UserDataNew sharedManager].userInfoModel.token.token;
            integralGoodsOrderDetailVc.userId = [NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.token.userid];
            integralGoodsOrderDetailVc.interfaceType = ZLOrderDetailInterfaceTypeIntegralSureOrder;
            [self.navigationController pushViewController:integralGoodsOrderDetailVc animated:YES];
            return;
        }
        
    }];
}

@end
