//
//  MyOfferViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyOfferViewController.h"
#import "MyOfferViewModel.h"

@interface MyOfferViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyOfferViewModel *viewModel;
@property (assign,nonatomic) NSInteger curPage;

@end

@implementation MyOfferViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    [self addPopBackBtn];
    
    [self setupTableView];
    [self cellClick];
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件

/**
 cell点击事件
 */
- (void)cellClick {
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(MyOfferModel *x) {
        @strongify(self);
        //1：待审核 2： 已审核 3：已上架 4：已下架
        if (x.status == -1) {
            
            [self.viewModel.updateProductStatusCommand execute:@{@"id":@(x.id),
                                                                 @"status":@1}];
            
            
        } else if (x.status == 1) {
            [self.viewModel.updateProductStatusCommand execute:@{@"id":@(x.id),
                                                                 @"status":@(-1)}];
        }
    }];
    
    
    [self.viewModel.updateProductStatusCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NavigateManager showMessage:@"操作成功"];
        [self.table.mj_header beginRefreshing];
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyOfferTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyOfferTableViewCell"];
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
        
        self.curPage = 1;
        
        if (self.statusFlag != 0) {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@1,
                                                         @"pageSize":@10,
                                                         @"status":@(self.statusFlag)}];
        } else {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@1,
                                                         @"pageSize":@10}];
        }
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x[@"rows"] isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    
                    self.curPage ++;
                    
                    if (self.statusFlag != 0) {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                                     @"curPage":@(self.curPage),
                                                                     @"pageSize":@10,
                                                                     @"status":@(self.statusFlag)}];
                    } else {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                                     @"curPage":@(self.curPage),
                                                                     @"pageSize":@10}];
                    }
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理异常状态
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        } else if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
}

//初始化viewModel
- (MyOfferViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyOfferViewModel alloc] init];
    }
    return _viewModel;
}


@end
