//
//  LookMingxiNewViewController.m
//  BoYi
//
//  Created by heng on 2018/2/27.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookMingxiNewViewController.h"
#import "LookMingxiNewViewModel.h"
#import "LookFheaderview.h"

@interface LookMingxiNewViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) LookMingxiNewViewModel *viewModel;

@end

@implementation LookMingxiNewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"查看明细";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {

}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"LookMingxiNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LookMingxiNewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    LookFheaderview *header = [[NSBundle mainBundle]loadNibNamed:@"LookFheaderview" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.table.tableHeaderView = header;
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新

        [self.viewModel.refreshDataCommand execute:@{@"id":@(self.id)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        NSString *dtr = x[@"zongji"];
        
        LookFheaderview *headerJoin = (LookFheaderview *)self.table.tableHeaderView;
        headerJoin.name.text = [NSString stringWithFormat:@"婚礼总价：¥%@",dtr];
        
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
        
//        //判断，如果item < size 显示已获取完成
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
- (LookMingxiNewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LookMingxiNewViewModel alloc] init];
    }
    return _viewModel;
}


@end
