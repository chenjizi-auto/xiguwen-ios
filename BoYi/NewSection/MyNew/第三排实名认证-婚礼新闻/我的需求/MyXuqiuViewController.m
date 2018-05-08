//
//  MyXuqiuViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyXuqiuViewController.h"
#import "MyXuqiuViewModel.h"
#import "MyXuqiuModel.h"
#import "PushXuqiuViewController.h"

#import "XuqiuDetailsViewController.h"

@interface MyXuqiuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyXuqiuViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MyXuqiuViewController

- (NSTimer *)timer {
	if (!_timer) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadTime) userInfo:nil repeats:YES];
	}
	return _timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
	
	[self.timer setFireDate:[NSDate distantPast]];// 开启定时器
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.table.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
//	[self.timer setFireDate:[NSDate distantFuture]];// 关闭定时器
}

#pragma mark - 点击事件

- (void)reloadTime {
	for (NSInteger i = 0; i < self.viewModel.dataArray.count; i ++) {
		MyXuqiuModel *model = [[MyXuqiuModel alloc] init];
		model = self.viewModel.dataArray[i];
		model.countdown --;
		if (model.countdown <= 0) {
			model.countdown = 0;
		}
		[self.viewModel.dataArray replaceObjectAtIndex:i withObject:model];
	}
	[self.table reloadData];
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(MyXuqiuModel *x) {
        @strongify(self);
		
		XuqiuDetailsViewController *vc = [[XuqiuDetailsViewController alloc] init];
		vc.kid = x.id;
		[self pushToNextVCWithNextVC:vc];
		
    }];
	
	// 编辑
	[self.viewModel.editItemSubject subscribeNext:^(MyXuqiuModel *x) {
		// 跳转编辑页面
		PushXuqiuViewController *vc = [[PushXuqiuViewController alloc] init];
		vc.model = x;
		vc.isEdit = YES;
		[self pushToNextVCWithNextVC:vc];
	}];
	// 关闭或者删除
	[self.viewModel.closeItemSubject subscribeNext:^(MyXuqiuModel *x) {
		if (x.status == 1) {
			// 关闭
			[[RequestManager sharedManager] requestUrl:URL_closeMyDemand method:POST
												loding:@""
												   dic:@{@"id":@(x.id),
														 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
														 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
											  progress:nil success:^(NSURLSessionDataTask *task, id response) {
												  if ([response[@"code"] integerValue] == 0) {
													  [NavigateManager showMessage:@"关闭成功"];
//													  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
														  [self.table.mj_header beginRefreshing];
//													  });
													  
												  }else{
													  
													  [NavigateManager showMessage:response[@"message"]];
												  }
											  } failure:^(NSURLSessionDataTask *task, NSError *error) {
												  [NavigateManager showMessage:@"关闭失败"];
											  }];
		} else {
			// 删除
			[[RequestManager sharedManager] requestUrl:URL_deleteMyDemand method:POST
												loding:@""
												   dic:@{@"id":@(x.id),
														 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
														 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
											  progress:nil success:^(NSURLSessionDataTask *task, id response) {
												  if ([response[@"code"] integerValue] == 0) {
													  [NavigateManager showMessage:@"删除成功"];
//													  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
														  [self.table.mj_header beginRefreshing];
														  
//													  });
													  
												  }else{
													  
													  [NavigateManager showMessage:response[@"message"]];
												  }
											  } failure:^(NSURLSessionDataTask *task, NSError *error) {
												  [NavigateManager showMessage:@"删除失败"];
											  }];
		}
		
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyXuqiuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyXuqiuTableViewCell"];
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
													 @"status":@(self.statusFlag),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
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
					[self.viewModel.refreshDataCommand execute:@{@"p":@(_page),
																 @"status":@(self.statusFlag),
																 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
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
- (MyXuqiuViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyXuqiuViewModel alloc] init];
    }
    return _viewModel;
}


@end
