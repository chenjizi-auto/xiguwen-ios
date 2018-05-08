//
//  HunliXInwenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunliXInwenViewController.h"
#import "HunliXInwenViewModel.h"
#import "HunliXInwenModel.h"
#import "NewsDetailsViewController.h"
@interface HunliXInwenViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunliXInwenViewModel *viewModel;

@end

@implementation HunliXInwenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"婚礼新闻";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
	// 点击进入新闻详情
    [self.viewModel.selectItemSubject subscribeNext:^(HunliXInwenModel *x) {
        @strongify(self);
		NewsDetailsViewController *details = [[NewsDetailsViewController alloc] init];
		details.model = x;
		[self pushToNextVCWithNextVC:details];
		
    }];
    
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//                [NavigateManager showMessage:@"操作成功"];
//                [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HunliXInwenTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunliXInwenTableViewCell"];
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
		_page = 1;
		[self.viewModel.refreshDataCommand execute:@{@"p":@(_page),
													 @"type":@(_type)}];
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
                    //传入参数 进行刷新
					_page ++;
					[self.viewModel.refreshDataCommand execute:@{@"p":@(_page),
															   @"type":@(_type)}];
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
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (HunliXInwenViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunliXInwenViewModel alloc] init];
    }
    return _viewModel;
}


@end
