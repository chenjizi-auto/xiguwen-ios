//
//  TuijianTuanduiMyViewController.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuijianTuanduiMyViewController.h"
#import "TuijianTuanduiMyViewModel.h"
#import "TuijianTuanduiMyModel.h"
#import "AddTuijianViewController.h"
@interface TuijianTuanduiMyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) TuijianTuanduiMyViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;

@end

@implementation TuijianTuanduiMyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐团队";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [self addRightBtnWithTitle:nil image:@"添加银行卡"];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.table.mj_header beginRefreshing];
}

- (void)respondsToRightBtn {
    
    // 跳转添加推荐页面
	AddTuijianViewController *add = [[AddTuijianViewController alloc] init];
	[self pushToNextVCWithNextVC:add];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(TuijianTuanduiMyModel *x) {
        @strongify(self);
    }];
	
	[self.viewModel.deleteItemSubject subscribeNext:^(TuijianTuanduiMyModel *model) {
		[[RequestManager sharedManager] requestUrl:URL_deleteTeam
											method:POST
											loding:@""
											   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
													 @"id":@(model.id)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"data"] integerValue] == 0) {
												   [NavigateManager showMessage:@"删除成功"];
//												   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
													   [self.table.mj_header beginRefreshing];
													   
//												   });
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"TuijianTuanduiMyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TuijianTuanduiMyTableViewCell"];
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
- (TuijianTuanduiMyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TuijianTuanduiMyViewModel alloc] init];
    }
    return _viewModel;
}


@end
