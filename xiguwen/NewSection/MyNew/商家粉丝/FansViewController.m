//
//  FansViewController.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "FansViewController.h"
#import "FansViewModel.h"
#import "FansModel.h"
@interface FansViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) FansViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumber;
@property (nonatomic, strong) NSIndexPath *indexRow;

@property (nonatomic, assign) NSInteger page;
@end

@implementation FansViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"粉丝";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Fansarrayw *x) {
        @strongify(self);
    }];
    [self.viewModel.guanBtnUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
       _indexRow = x;
        Fansarrayw *model = self.viewModel.dataArray[_indexRow.row];
        if (model.follow) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.dataArray[_indexRow.row].userid] forKey:@"id"];
            [self.viewModel.deleguanzhuCommand execute:dic];
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:@(self.viewModel.dataArray[_indexRow.row].userid) forKey:@"id"];
            [self.viewModel.addguanzhuCommand execute:dic];
        }
    }];
    
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.dataArray[self.indexRow.row].follow = 1;
            [self.table reloadData];
        }
    }];
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.dataArray[self.indexRow.row].follow = 0;
            [self.table reloadData];
        }
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"FansTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FansTableViewCell"];
    
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
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
//        [dic setValue:@"112" forKey:@"token"];
//        [dic setValue:@"16"forKey:@"userid"];
        [self.viewModel.refreshDataCommand execute:dic];
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
					NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
					
					[dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
					[dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                    [self.viewModel.refreshDataCommand execute:dic];
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
        self.fansNumber.text = [NSString stringWithFormat:@"全部粉丝(%ld)",self.viewModel.dataArray.count];
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
- (FansViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FansViewModel alloc] init];
    }
    return _viewModel;
}


@end
