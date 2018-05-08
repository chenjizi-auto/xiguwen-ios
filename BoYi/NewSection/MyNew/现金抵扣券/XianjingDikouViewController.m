//
//  XianjingDikouViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "XianjingDikouViewController.h"
#import "XianjingDikouViewModel.h"
#import "XianjingDikouModel.h"
@interface XianjingDikouViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) XianjingDikouViewModel *viewModel;

@end

@implementation XianjingDikouViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"现金抵扣券";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
//    [self.table.mj_header beginRefreshing];
	[self.table reloadData];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(XianjingDikouModel *x) {
        @strongify(self);
    }];
    
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"XianjingDikouTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianjingDikouTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        @strongify(self);
//        //传入参数 进行刷新
//        [self.viewModel.refreshDataCommand execute:@{}];
//    }];
	
    //请求结束
//    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
//
//        @strongify(self);
//
//        //数据处理
//        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
//
//        //正在下啦
//        if (self.table.mj_header.isRefreshing) {
//
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
//            [self.table.mj_header endRefreshing];
//        }
	
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//
//        }
//        //    [self.tableView reloadEmptyDataSet];
//        //刷新视图
//        [self.table reloadData];
//
//    }];
//    //处理请求失败
//    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
//        @strongify(self);
//        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
//        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
//    }];
}

//初始化viewModel
- (XianjingDikouViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[XianjingDikouViewModel alloc] init];
    }
    return _viewModel;
}


@end
