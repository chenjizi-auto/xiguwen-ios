//
//  MyDangQiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyDangQiViewController.h"
#import "MyDangQiViewModel.h"
#import "MyDangQiModel.h"
#import "SheJieDanViewController.h"
#import "XinZenDangqiViewController.h"
#import "DangqiKaViewController.h"
#import "MyDangQiViewModel.h"
#import "CheckScheduleViewController.h"

@interface MyDangQiViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyDangQiViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;

@end

@implementation MyDangQiViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
	[self.table.mj_header beginRefreshing];
	
	[self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
		[self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
	}];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
//    NSInteger userId =[UserDataNew sharedManager].userInfoModel.user.userid;
//    NSString * token = [UserDataNew sharedManager].userInfoModel.token.token;
//    [self.viewModel.refreshDataCommand execute:@{@"token":token,@"userid":@(userId)}];

    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        [self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
    }];
}

- (IBAction)allaction:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else if (sender.tag == 1) {
        //设置
        SheJieDanViewController *caipai = [[SheJieDanViewController alloc] init];
        [self pushToNextVCWithNextVC:caipai];
    }else {
        //加
        
        XinZenDangqiViewController *caipai = [[XinZenDangqiViewController alloc] init];
		caipai.isEdit = NO;
        [self pushToNextVCWithNextVC:caipai];
    }
}
- (IBAction)dangqika:(UIButton *)sender {
    
    DangqiKaViewController *caipai = [[DangqiKaViewController alloc] init];
    [self pushToNextVCWithNextVC:caipai];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(DangQiDetailsModel *x) {
        @strongify(self);
		// 查看档期
		CheckScheduleViewController *look = [[CheckScheduleViewController alloc] init];
		look.model = x;
		[self pushToNextVCWithNextVC:look];
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyDangQiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyDangQiTableViewCell"];
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
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.user.userid)}];
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
																 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
																 @"userid":@([UserDataNew sharedManager].userInfoModel.user.userid)}];
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
- (MyDangQiViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyDangQiViewModel alloc] init];
    }
    return _viewModel;
}


@end
