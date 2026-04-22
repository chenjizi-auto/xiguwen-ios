//
//  ShopNewCarViewController.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShopNewCarViewController.h"
#import <RDVTabBarController/RDVTabBarController.h>
#import "ShopNewCarViewModel.h"
#import "ShopNewCarModel.h"
#import "SureDingdanNewViewController.h"
#import "NewLoginViewController.h"
#import "SureDingdanNewSCViewController.h"
@interface ShopNewCarViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomInset;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShopNewCarViewModel *viewModel;
@property (nonatomic, strong) UIView *cartHeaderView;
@property (nonatomic, strong) UILabel *cartTitleLabel;
@property (nonatomic, strong) UIView *cartHeaderBottomLine;
@property (nonatomic, assign) CGFloat cartHeaderCurrentHeight;

@end

@implementation ShopNewCarViewController

- (CGFloat)cartHeaderHeight {
    CGFloat statusBarHeight = 0.0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = self.view.window.windowScene;
        if (windowScene.statusBarManager.statusBarFrame.size.height > 0.0) {
            statusBarHeight = windowScene.statusBarManager.statusBarFrame.size.height;
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
    }
    return statusBarHeight + 44.0;
}

- (NSInteger)cartItemCount {
    NSInteger count = 0;
    for (ShopNewCarListarray *sectionModel in self.viewModel.dataArray) {
        count += sectionModel.goods.count;
    }
    return count;
}

- (void)updateNavigationTitle {
    NSString *title = [NSString stringWithFormat:@"购物车(%ld)", (long)[self cartItemCount]];
    self.navigationItem.title = title;
    self.cartTitleLabel.text = title;
}

- (void)setupCartHeaderView {
    if (self.cartHeaderView) {
        return;
    }

    CGFloat headerHeight = [self cartHeaderHeight];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), headerHeight)];
    headerView.backgroundColor = [UIColor whiteColor];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.textColor = [UIColor colorWithRed:0.05 green:0.08 blue:0.16 alpha:1.0];
    [headerView addSubview:titleLabel];

    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    [headerView addSubview:bottomLine];

    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:20.0],
        [titleLabel.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-8.0],

        [bottomLine.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor],
        [bottomLine.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor],
        [bottomLine.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor],
        [bottomLine.heightAnchor constraintEqualToConstant:1.0 / UIScreen.mainScreen.scale]
    ]];

    self.cartHeaderView = headerView;
    self.cartTitleLabel = titleLabel;
    self.cartHeaderBottomLine = bottomLine;
    self.cartHeaderCurrentHeight = headerHeight;
    self.table.tableHeaderView = headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    if (![UserDataNew UserLoginState]) {
        self.vieww.hidden = YES;
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }else {
        self.vieww.hidden = NO;
        if (self.viewModel.dataArray.count == 0) {
            NSDictionary *params = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token ?: @"",
                                     @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
            [self.viewModel.refreshDataCommand execute:params];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCartHeaderView];
    [self updateNavigationTitle];
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    self.table.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    self.viewModel.isHunqin = self.index == 0;
    [self cellClick];
    [self setupTableView];
    [self applyCachedCartDataIfNeeded];
    if (self.isGiabianheight) {
        self.height.constant = 0;
    }
    self.bottomInset.constant = 0.0;
    [self setupCartBottomBarAppearance];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateCartHeaderLayoutIfNeeded];
}


#pragma mark - 点击事件

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        if (self.viewModel.dataArray.count == 0) {
            [NavigateManager showMessage:@"订单为空"];
            return;
        }else {
            if (self.isQuanxuan) {
                for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
                    self.viewModel.dataArray[i].isSele = NO;
                    for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
                        self.viewModel.dataArray[i].goods[j].isSele = NO;
                    }
                }
            }else {
                for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
                    self.viewModel.dataArray[i].isSele = YES;
                    for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
                        self.viewModel.dataArray[i].goods[j].isSele = YES;
                    }
                }
            }
            self.isQuanxuan = !self.isQuanxuan;
            self.isGouImage.image = [UIImage imageNamed:self.isQuanxuan == YES ? @"勾选商品":@"未勾选商品"];
            [self hejiMoney];
            [self.table reloadData];
        }
        
    }else {
        if (self.viewModel.dataArray.count == 0) {
            [NavigateManager showMessage:@"订单为空"];
            return;
        }
        if ([self.zongMoney.text isEqualToString:@"¥0.00"]) {
            [NavigateManager showMessage:@"请选择商品"];
            return;
        }
        //结算
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
                if (self.viewModel.dataArray[i].goods[j].isSele) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",self.viewModel.dataArray[i].goods[j].rec_id]];
                }
            }
        }
        
        NSString *string = [arr componentsJoinedByString:@"_"];
        if (self.index == 0) {
            SureDingdanNewViewController *sure = [[SureDingdanNewViewController alloc] init];
            sure.idPingjie = string;
            [self pushToNextVCWithNextVC:sure];
        }else {
            SureDingdanNewSCViewController *sure = [[SureDingdanNewSCViewController alloc] init];
            sure.idPingjie = string;
            sure.type = 2;
            [self pushToNextVCWithNextVC:sure];
        }
    }
}
- (void)hejiMoney{
    float money = 0.00;
    if (self.viewModel.isHunqin) {
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
                if (self.viewModel.dataArray[i].goods[j].isSele) {
                    
                    if (self.viewModel.dataArray[i].goods[j].paytype == 1) {//quan
                        money = money + [self.viewModel.dataArray[i].goods[j].price floatValue] * self.viewModel.dataArray[i].goods[j].quantity;
                    }else {//ding
                        money = money + [self.viewModel.dataArray[i].goods[j].partprice floatValue] * self.viewModel.dataArray[i].goods[j].quantity;
                    }
                    
                    
                }
                
            }
        }
    }else {
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
                if (self.viewModel.dataArray[i].goods[j].isSele) {
                    
                    money = money + [self.viewModel.dataArray[i].goods[j].price floatValue] * self.viewModel.dataArray[i].goods[j].quantity;
                    
                    
                }
                
            }
        }
    }
    
    
    self.zongMoney.text = [NSString stringWithFormat:@"¥ %.2f",money];
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(ShopNewCarModel *x) {
        @strongify(self);
    }];
    [self.viewModel.moneySubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self hejiMoney];
    }];
    [self.viewModel.bianjiUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
    
    }];
    [self.viewModel.shanchuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
       [self hejiMoney];
       [self updateNavigationTitle];
    }];
    
    //推荐商家
    [self.viewModel.selectTuijianSubject subscribeNext:^(ShopCarTuiJian *x) {
        @strongify(self);
        //
        [self gotoDetail:x];
    }];

}

- (void)updateCartHeaderLayoutIfNeeded {
    if (!self.cartHeaderView) {
        return;
    }

    CGFloat headerHeight = [self cartHeaderHeight];
    CGFloat headerWidth = CGRectGetWidth(self.table.bounds);
    BOOL heightChanged = fabs(headerHeight - self.cartHeaderCurrentHeight) > 0.5;
    BOOL widthChanged = fabs(headerWidth - CGRectGetWidth(self.cartHeaderView.frame)) > 0.5;
    if (!heightChanged && !widthChanged) {
        return;
    }

    self.cartHeaderCurrentHeight = headerHeight;
    CGRect frame = self.cartHeaderView.frame;
    frame.size.width = headerWidth;
    frame.size.height = headerHeight;
    self.cartHeaderView.frame = frame;
    self.table.tableHeaderView = self.cartHeaderView;
}

- (void)setupCartBottomBarAppearance {
    self.vieww.backgroundColor = [UIColor whiteColor];
    self.vieww.layer.shadowColor = [UIColor blackColor].CGColor;
    self.vieww.layer.shadowOpacity = 0.04;
    self.vieww.layer.shadowOffset = CGSizeMake(0.0, -4.0);
    self.vieww.layer.shadowRadius = 12.0;
}
//进入商家详情
- (void)gotoDetail:(ShopCarTuiJian *)model {
    if (self.index == 1) {
        ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
        vc.id = model.userid;
        [self pushToNextVCWithNextVC:vc];
    } else {
        NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
        vc.shopid = model.userid;
        [self pushToNextVCWithNextVC:vc];
    }
}
#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShopNewCarTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShopNewCarTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"GoodsNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsNewTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"CarTuijianTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"CarTuijianTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"GoodsNewSCTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"GoodsNewSCTableViewCell"];

    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    self.table.backgroundColor      = self.view.backgroundColor;
    self.table.separatorStyle       = UITableViewCellSeparatorStyleNone;
    self.table.contentInset         = UIEdgeInsetsZero;
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, CGRectGetHeight(self.vieww.bounds), 0.0);
    if (@available(iOS 15.0, *)) {
        self.table.sectionHeaderTopPadding = 0.0;
    }
    
    @weakify(self);
    
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        NSDictionary *dicc = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        [self.viewModel.refreshDataCommand execute:dicc];
    }];
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.table.mj_header = header;
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        [self updateNavigationTitle];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

- (void)applyCachedCartDataIfNeeded {
    id cachedResponse = [self.viewModel cachedCartResponse];
    if (!cachedResponse) {
        return;
    }
    [self.viewModel ConvertingToObject:cachedResponse isHeaderRefersh:YES];
    [self hejiMoney];
    [self.table reloadData];
    [self updateNavigationTitle];
}

//初始化viewModel
- (ShopNewCarViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShopNewCarViewModel alloc] init];
    }
    return _viewModel;
}


@end
