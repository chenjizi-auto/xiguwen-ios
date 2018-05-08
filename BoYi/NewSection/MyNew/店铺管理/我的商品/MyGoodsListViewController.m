//
//  MyGoodsListViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyGoodsListViewController.h"
#import "YUSegment.h"
#import "MyGoodsViewModel.h"
#import "MyGoodsDetailsViewController.h"
#import "AddMyGoodsViewController.h"

@interface MyGoodsListViewController ()

@property (nonatomic, strong) YUSegment *segment;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) MyGoodsViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger index;

@end

@implementation MyGoodsListViewController

- (YUSegment *)segment {
	if (!_segment) {
		_segment = [[YUSegment alloc] initWithTitles:@[@"审核中",@"审核通过",@"审核未通过"] style:(YUSegmentStyleLine)];
		_segment.frame = CGRectMake(0.0f, 0.0f, ScreenWidth, 40.0f);
		[_segment setBackgroundColor: [UIColor whiteColor]];
		_segment.indicator.backgroundColor = UIColorFromRGB(0xFF7299);
		[_segment addTarget:self action:@selector(onSegmentChange) forControlEvents:(UIControlEventValueChanged)];
	}
	return _segment;
}

- (UITableView *)table {
	if (!_table) {
		_table = [[UITableView alloc] init];
		_table.delegate = self.viewModel;
		_table.dataSource = self.viewModel;
		_table.emptyDataSetSource = self.viewModel;
		_table.emptyDataSetDelegate = self.viewModel;
		_table.separatorStyle = UITableViewCellSeparatorStyleNone;
		_table.tableFooterView = [UIView new];
	}
	return _table;
}

- (MyGoodsViewModel *)viewModel {
	if (!_viewModel) {
		_viewModel = [[MyGoodsViewModel alloc] init];
	}
	return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	self.navigationItem.title = @"我的商品";
	[self addPopBackBtn];
	[self addRightBtnWithTitle:@"" image:@"添加银行卡"];
	
	[self.view addSubview: self.segment];
	self.segment.sd_layout
	.topSpaceToView(self.view, isIPhoneXBarHeight)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(40.0f);
	
	UIView *lineView = [[UIView alloc] init];
	[lineView setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	[self.view addSubview:lineView];
	lineView.sd_layout
	.topSpaceToView(self.segment, -1)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);
	
	[self.view addSubview:self.table];
	self.table.sd_layout
	.topSpaceToView(self.segment, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
	
	[self cellClick];
	[self setupTableView];
	self.index = 1;
	
	[self.table.mj_header beginRefreshing];
}

- (void)respondsToRightBtn {
	// 跳转新建页面
	AddMyGoodsViewController *vc = [[AddMyGoodsViewController alloc] init];
	vc.isEdit = NO;
	[self pushToNextVCWithNextVC:vc];
}

#pragma mark - 点击事件
- (void)cellClick {
	@weakify(self);
	[self.viewModel.selectItemSubject subscribeNext:^(MyGoodsModel *x) {
		@strongify(self);
		// 跳转详情页面
		
		MyGoodsDetailsViewController *vc = [[MyGoodsDetailsViewController alloc] init];
		vc.model = x;
		[self pushToNextVCWithNextVC:vc];
		
	}];

}

- (void)setupTableView {
	
	@weakify(self);
	
	//下拉刷新
	self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		@strongify(self);
		//传入参数 进行刷新
		_page = 1;
		[self.viewModel.refreshDataCommand execute:@{
													 @"p":@(_page),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"status":@(self.index),
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
					[self.viewModel.refreshDataCommand execute:@{
																 @"p":@(_page),
																 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
																 @"status":@(self.index),
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


// 列表切换
- (void)onSegmentChange {
//	[self.mainScrollView setContentOffset:CGPointMake(self.segment.selectedIndex * SCREEN_WIDTH, 0.0f) animated:YES];
	self.index = self.segment.selectedIndex + 1;
	[self.table.mj_header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}


@end
