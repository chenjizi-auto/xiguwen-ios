//
//  ChoeseCarIDViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChoeseCarIDViewController.h"
#import "ChoeseCarIDViewModel.h"
//#import "ChoeseCarIDModel.h"
#import "BankCardModel.h"
#import "AddIDoneViewController.h"
@interface ChoeseCarIDViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ChoeseCarIDViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ChoeseCarIDViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择银行卡";
    [self addRightBtnWithTitle:nil image:@"添加银行卡"];
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.table.mj_header beginRefreshing];
}

- (void)respondsToRightBtn {
    
    AddIDoneViewController *xuan = [[AddIDoneViewController alloc] init];
    [self pushToNextVCWithNextVC:xuan];
}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(BankCardModel *x) {
        @strongify(self);
		
		self.onSelectedBank(x);
    }];
	
	WeakSelf(self);
	[self.viewModel.deleteItemSubject subscribeNext:^(BankCardModel *x) {
		// 删除
//		[weakSelf.viewModel.dataArray removeObjectAtIndex:0];
//		[self.table reloadData];
		[[RequestManager sharedManager] requestUrl:URL_deleteBankCard
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage: @"删除成功"];
												   [weakSelf.table.mj_header beginRefreshing];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage: @"删除失败"];
										   }];
		
		
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ChoeseCarIDTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChoeseCarIDTableViewCell"];
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
		_page = 1;
        //传入参数 进行刷新
		[self.viewModel.refreshDataCommand execute:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
			_page ++;
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
					[self.viewModel.refreshDataCommand execute:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
																 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
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
- (ChoeseCarIDViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChoeseCarIDViewModel alloc] init];
    }
    return _viewModel;
}


@end
