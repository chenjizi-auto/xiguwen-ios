//
//  GuanliAddressViewController.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanliAddressViewController.h"
#import "GuanliAddressViewModel.h"
#import "GuanliAddressModel.h"
#import "AddshouhuoViewController.h"
@interface GuanliAddressViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) GuanliAddressViewModel *viewModel;

@end

@implementation GuanliAddressViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self.table.mj_header beginRefreshing];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"管理收货地址";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    
}

- (IBAction)add:(UIButton *)sender {
    AddshouhuoViewController *vc = [[AddshouhuoViewController alloc] init];
    [self pushToNextVCWithNextVC:vc];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(GuanliAddressModel *x) {
        @strongify(self);
    }];
    [self.viewModel.refreshUIAC subscribeNext:^(GuanliAddressModel *x) {
        @strongify(self);
        [self.table.mj_header beginRefreshing];
    }];
    [self.viewModel.bianjiUISubject subscribeNext:^(Addressarray *x) {
        @strongify(self);
        Addressarray *model = x;
        AddshouhuoViewController *vc = [[AddshouhuoViewController alloc] init];
        vc.isBianji = YES;
        vc.model = model;
        [self pushToNextVCWithNextVC:vc];
    }];
    
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"GuanliAddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GuanliAddressTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [self.viewModel.refreshDataCommand execute:dic];
    }];
    
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
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (GuanliAddressViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GuanliAddressViewModel alloc] init];
    }
    return _viewModel;
}


@end
