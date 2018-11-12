//
//  ZLIntegralDetailViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLIntegralDetailViewController.h"
#import "ZLIntegralDetailView.h"
#import "ZLIntegralDetailModel.h"

@interface ZLIntegralDetailViewController ()

///
@property (nonatomic,weak) ZLIntegralDetailView *integralDetailView;
///持有数据
@property (nonatomic,strong) ZLIntegralDetailModel *infoModel;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;

@end

@implementation ZLIntegralDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"积分明细";
    [self addSubviews];
    [self integralDetailData];
}

#pragma mark - Add
- (void)addSubviews {
    //初始化视图
    ZLIntegralDetailView *integralDetailView = [[ZLIntegralDetailView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:integralDetailView];
    self.integralDetailView = integralDetailView;
    //初始化模型
    ZLIntegralDetailModel *infoModel = [ZLIntegralDetailModel new];
    infoModel.page = 1;
    infoModel.count = [[UIApplication sharedApplication] statusBarFrame].size.height == 20.0 ? 10 : 11;
    infoModel.token = self.token;
    infoModel.userId = self.userId;
    self.infoModel = infoModel;
    //导航项
    [self leftBarButtonItem];
    //加载数据
    __weak typeof(self)weakSelf = self;
    integralDetailView.loadData = ^() {
        [weakSelf integralDetailData];
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
- (void)setInfoModel:(ZLIntegralDetailModel *)infoModel {
    _infoModel = infoModel;
    self.integralDetailView.infoModel = infoModel;
}

#pragma mark - Action
- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)integralDetailData {//积分商城首页
    __weak typeof(self)weakSelf = self;
    [ZLIntegralDetailModel integralDetailWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
            return;
        }
    }];
}

@end
