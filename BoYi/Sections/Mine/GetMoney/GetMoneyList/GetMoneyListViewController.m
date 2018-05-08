//
//  GetMoneyListViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "GetMoneyListViewController.h"
#import "GetMoneyListViewModel.h"
#import "NSDate+FSExtension.h"

@interface GetMoneyListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) GetMoneyListViewModel *viewModel;
@property (assign,nonatomic) NSInteger weekCount;
@end

@implementation GetMoneyListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"明细";
    [self addPopBackBtn];
    
    [self setupTableView];
    
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件



#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"GetMoneyListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GetMoneyListTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
        self.weekCount = 1;
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"status":@"",
                                                     @"startTime":[[NSDate date] fs_dateBySubtractingWeeks:self.weekCount].fs_string,
                                                     @"endTime":[[NSDate date] fs_dateBySubtractingWeeks:self.weekCount - 1].fs_string,
                                                     @"userid":@([UserData sharedManager].userInfoModel.id)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    self.weekCount++;
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{@"status":@"",
                                                                 @"startTime":[[NSDate date] fs_dateBySubtractingWeeks:self.weekCount].fs_string,
                                                                 @"endTime":[[NSDate date] fs_dateBySubtractingWeeks:self.weekCount - 1].fs_string,
                                                                 @"userid":@([UserData sharedManager].userInfoModel.id)}];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
//        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
        
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
}

//初始化viewModel
- (GetMoneyListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GetMoneyListViewModel alloc] init];
    }
    return _viewModel;
}


@end
