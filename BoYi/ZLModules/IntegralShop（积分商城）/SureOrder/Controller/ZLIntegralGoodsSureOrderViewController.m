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

@interface ZLIntegralGoodsSureOrderViewController ()

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
            weakSelf.infoModel.addressId = [NSString stringWithFormat:@"%ld",model.id];
            weakSelf.infoModel.name = model.username;
            weakSelf.infoModel.phone = model.mobile;
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
            weakSelf.infoModel.address = address;
            weakSelf.infoModel = weakSelf.infoModel;
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
            
#warning 发起支付待交互
            return;
        }
    }];
}


@end
