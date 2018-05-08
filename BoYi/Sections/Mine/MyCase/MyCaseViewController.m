//
//  MyCaseViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyCaseViewController.h"
#import "MyCaseViewModel.h"

@interface MyCaseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyCaseViewModel *viewModel;
@property (nonatomic,assign) NSInteger curPage;
@end

@implementation MyCaseViewController


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

- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(MyCaseModel *x) {
        @strongify(self);
        //案例状态 -1：待审核 0：待提交 1：审核通过 2：已上架 3：已下架 4：审核不通过 5：已推荐
        switch (x.status) {
            case 0:
                [self.viewModel.updateExampleViewCommand execute:@{@"id":@(x.id),
                                                                   @"status":@(-1)}];
                break;
            case 1:
                [self.viewModel.updateExampleViewCommand execute:@{@"id":@(x.id),
                                                                   @"status":@(2)}];
                break;
            case 2:
                [self.viewModel.updateExampleViewCommand execute:@{@"id":@(x.id),
                                                                   @"status":@(3)}];
                break;
            case 3:
                [self.viewModel.updateExampleViewCommand execute:@{@"id":@(x.id),
                                                                   @"status":@(2)}];
                break;
            default:
                break;
        }
    }];
    
    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NavigateManager showMessage:@"操作成功"];
        [self.table.mj_header beginRefreshing];
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyCaseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyCaseTableViewCell"];
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
        
        if (self.status != 999) {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userInfoBvo.id":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@(self.curPage),
                                                         @"pageSize":@10,
                                                         @"status":@(self.status)}];
        } else {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userInfoBvo.id":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@(self.curPage),
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
                
                @weakify(self);
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    
                    @strongify(self);
                    self.curPage++;
                    
                    if (self.status != 999) {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userInfoBvo.id":@([UserData sharedManager].userInfoModel.id),
                                                                     @"curPage":@(self.curPage),
                                                                     @"pageSize":@10,
                                                                     @"status":@(self.status)}];
                    } else {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userInfoBvo.id":@([UserData sharedManager].userInfoModel.id),
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
- (MyCaseViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyCaseViewModel alloc] init];
    }
    return _viewModel;
}


@end
