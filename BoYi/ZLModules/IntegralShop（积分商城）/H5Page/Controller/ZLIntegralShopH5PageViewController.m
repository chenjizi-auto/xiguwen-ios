//
//  ZLIntegralShopH5PageViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopH5PageViewController.h"
#import "ZLIntegralShopH5PageView.h"

@interface ZLIntegralShopH5PageViewController ()

///
@property (nonatomic,weak) ZLIntegralShopH5PageView *integralShopH5PageView;
///
@property (nonatomic,weak) UIButton *leftBarButtonItem;

@end

@implementation ZLIntegralShopH5PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
}

#pragma mark - Add
- (void)addSubviews {
    ZLIntegralShopH5PageView *integralShopH5PageView = [[ZLIntegralShopH5PageView alloc] initWithFrame:self.view.frame];
    integralShopH5PageView.srcPath = self.srcPath;
    [self.view addSubview:integralShopH5PageView];
    self.integralShopH5PageView = integralShopH5PageView;
    //导航项
    self.navigationItem.title = self.navTitle;
    [self leftBarButtonItem];
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

#pragma mark - Action
- (void)leftBarButtonItemAction {
    NSLog(@"%d",[self.integralShopH5PageView canGoBack]);
    if (![self.integralShopH5PageView canGoBack]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self.integralShopH5PageView goBack];
}

@end
