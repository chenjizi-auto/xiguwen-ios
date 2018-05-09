//
//  ZLShopDetailsViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsViewController.h"
#import "ZLShopDetailsView.h"

@interface ZLShopDetailsViewController ()

//
@property (nonatomic,weak) ZLShopDetailsView *shopDetailsView;

@end

@implementation ZLShopDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
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
    //承载子视图
    [self shopDetailsView];
    //注册事件
    [self registerEvent];
}

#pragma mark - RegisterEvent
- (void)registerEvent {
//    ZL_WEAK_SELF(weakSelf);
}

#pragma mark - Lazy
- (ZLShopDetailsView *)shopDetailsView {
    if (!_shopDetailsView) {
        ZLShopDetailsView *shopDetailsView = [[ZLShopDetailsView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:shopDetailsView];
        _shopDetailsView = shopDetailsView;
    }
    return _shopDetailsView;
}

@end
