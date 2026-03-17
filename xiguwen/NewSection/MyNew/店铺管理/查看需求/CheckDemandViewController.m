//
//  CheckDemandViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CheckDemandViewController.h"
#import "MyDemandCell.h"
#import "MyXuqiuModel.h"
#import "OtherDemandViewController.h"
#import "quyuModel.h"

@interface CheckDemandViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> {
	UIButton *markBtn;
	NSMutableArray *countyIdArray;// 下拉列表区域id
	NSMutableArray *countyNameArray;// 下拉列表区域名称
}
// 下拉列表数组数据
@property (nonatomic, strong) NSMutableArray *selectedArray;
// 数据列表date
@property (nonatomic, strong) NSMutableArray *dataArray;
// 头部按钮集合部分
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;
@property (nonatomic, strong) UIButton *threeBtn;
// 下拉列表与数据列表
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *dropTableView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *maskView;
// 请求列表所需参数
@property (nonatomic, assign) NSInteger page;// 页数
@property (nonatomic, assign) NSInteger mallType;// 商城类型
@property (nonatomic, strong) NSString *liulanType;// 浏览类型
@property (nonatomic, strong) NSString *shijanType;// 时间类型
@property (nonatomic, strong) NSString *jiageType;// 价格类型
@property (nonatomic, assign) NSInteger cityId;// 当前城市id
@property (nonatomic, assign) NSInteger countyid;// 区域id

@end

@implementation CheckDemandViewController

#pragma mark - Setters and getters

- (NSMutableArray *)dataArray {
	if (!_dataArray) {
		_dataArray = [[NSMutableArray alloc] init];
	}
	return _dataArray;
}

- (NSMutableArray *)selectedArray {
	if (!_selectedArray) {
		_selectedArray = [[NSMutableArray alloc] init];
	}
	return _selectedArray;
}

- (UIView *)lineView {
	if (!_lineView) {
		_lineView = [[UIView alloc] init];
		[_lineView setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	}
	return _lineView;
}

- (UIButton *)oneBtn {
	if (!_oneBtn) {
		_oneBtn = [[UIButton alloc] init];
		[_oneBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_oneBtn setTitle:@"婚庆" forState:(UIControlStateNormal)];
		[_oneBtn setTitleEdgeInsets:UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 15.0f)];
		[_oneBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
		[_oneBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateSelected)];
		[_oneBtn setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
		[_oneBtn setImage:[UIImage imageNamed:@"下拉（未选中）"] forState:(UIControlStateSelected)];
		[_oneBtn setImageEdgeInsets:UIEdgeInsetsMake(10.0f, ScreenWidth/3-30, 10.0f, 5.0f)];
		[_oneBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _oneBtn;
}

- (UIButton *)twoBtn {
	if (!_twoBtn) {
		_twoBtn = [[UIButton alloc] init];
		[_twoBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_twoBtn setTitle:@"综合排序" forState:(UIControlStateNormal)];
		[_twoBtn setTitleEdgeInsets:UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 15.0f)];
		[_twoBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
		[_twoBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateSelected)];
		[_twoBtn setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
		[_twoBtn setImage:[UIImage imageNamed:@"下拉（未选中）"] forState:(UIControlStateSelected)];
		[_twoBtn setImageEdgeInsets:UIEdgeInsetsMake(10.0f, ScreenWidth/3-30, 10.0f, 5.0f)];
		[_twoBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _twoBtn;
}

- (UIButton *)threeBtn {
	if (!_threeBtn) {
		_threeBtn = [[UIButton alloc] init];
		[_threeBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_threeBtn setTitle:@"全国" forState:(UIControlStateNormal)];
		[_threeBtn setTitleEdgeInsets:UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 15.0f)];
		[_threeBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateSelected)];
		[_threeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
		[_threeBtn setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
		[_threeBtn setImage:[UIImage imageNamed:@"下拉（未选中）"] forState:(UIControlStateSelected)];
		[_threeBtn setImageEdgeInsets:UIEdgeInsetsMake(10.0f, ScreenWidth/3-30, 10.0f, 5.0f)];
		[_threeBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _threeBtn;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		[_tableView setDelegate:self];
		[_tableView setDataSource: self];
	}
	return _tableView;
}

- (UITableView *)dropTableView {
	if (!_dropTableView) {
		_dropTableView = [[UITableView alloc] init];
		[_dropTableView setDelegate:self];
		[_dropTableView setDataSource:self];
		_dropTableView.alwaysBounceVertical = NO;
		_dropTableView.bounces = NO;
		[_dropTableView.layer setBorderColor:UIColorFromRGB(0xF0F0F2).CGColor];
		[_dropTableView.layer setBorderWidth:1.0f];
//		[_dropTableView setClipsToBounds: YES];
//		[_dropTableView.layer setMasksToBounds: YES];
//		[_dropTableView.layer setShadowOffset:CGSizeMake(5, 5)];
//		[_dropTableView.layer setShadowOpacity:0.5f];
//		[_dropTableView.layer setShadowRadius:5.0f];
	}
	return _dropTableView;
}

- (NSTimer *)timer {
	if (!_timer) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(reloadTime) userInfo:nil repeats:YES];
	}
	return _timer;
}

- (UIView *)maskView {
	if (!_maskView) {
		_maskView = [[UIView alloc] init];
		[_maskView setBackgroundColor:UIColorFromRGB(0x9B9B9B)];
		[_maskView setAlpha:0.7f];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
		[_maskView addGestureRecognizer:tap];
	}
	return _maskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationItem setTitle:@"查看需求"];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self addPopBackBtn];
	[self.timer setFireDate:[NSDate distantPast]];
	
	// 加载三个按钮
	[self.view addSubview: self.oneBtn];
	self.oneBtn.sd_layout
	.topSpaceToView(self.view, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0)
	.leftSpaceToView(self.view, 0.0f)
	.widthIs(ScreenWidth/3)
	.heightIs(44.0f);
	
	[self.view addSubview: self.twoBtn];
	self.twoBtn.sd_layout
	.topSpaceToView(self.view, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0)
	.leftSpaceToView(self.oneBtn, 0.0f)
	.widthIs(ScreenWidth/3)
	.heightIs(44.0f);

	[self.view addSubview: self.threeBtn];
	self.threeBtn.sd_layout
	.topSpaceToView(self.view, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0)
	.leftSpaceToView(self.twoBtn, 0.0f)
	.widthIs(ScreenWidth/3)
	.heightIs(44.0f);


	[self.view addSubview: self.lineView];
	self.lineView.sd_layout
	.topSpaceToView(self.oneBtn, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);
	
	
	// 加载两个tableView
	[self.view addSubview: self.tableView];
	self.tableView.sd_layout
	.topSpaceToView(self.lineView, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
	
	[self.view addSubview:self.maskView];
	self.maskView.sd_layout
	.topSpaceToView(self.lineView, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
	[self.maskView setHidden:YES];
	
	[self.view addSubview: self.dropTableView];
	self.dropTableView.sd_layout
	.topSpaceToView(self.lineView, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(ScreenWidth/2);
	[self.dropTableView setHidden: YES];
	
	// 设定初步参数
	self.page = 1;
	self.mallType = 1;
	self.cityId = 0;
	self.countyid = 0;
	// 以下三个只能传一个
	self.liulanType = @"asc";
	self.shijanType = @"";
	self.jiageType = @"";
	
	[self headerReload];
	
//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
//	[self.view setUserInteractionEnabled: YES];
//	[tap setCancelsTouchesInView:YES];
//	[self.view addGestureRecognizer:tap];
	
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
//	if (sender.state == UIGestureRecognizerStateEnded){
//
//		CGPoint location = [sender locationInView:nil];
//		//获取当前点击点在分享视图的坐标信息
//		CGPoint clickPoint = [self.dropTableView convertPoint: location fromView: self.view];
//		//如果当前点击区域不在分享视图上，就隐藏主视图
//		if(![self.dropTableView pointInside: clickPoint withEvent: nil]){
			[self.dropTableView setHidden:YES];
	[self.maskView setHidden:YES];
//		}
//	}
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//	[self.dropTableView setHidden:YES];
//}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// 初始化两个数组
	countyNameArray = [[NSMutableArray alloc] init];
	countyIdArray = [[NSMutableArray alloc] init];
	// 获取当前城市地址与id，包括当前城市区域id
	@weakify(self);
	[[CwLocationManager sharedManager] startWithGeoSearch:YES complete:^(BOOL success, NSString *province, NSString *city) {
		@strongify(self);
		if (success) {
			// 获取当前城市id
			[[RequestManager sharedManager] requestUrl:URL_New_citychange
												method:POST
												loding:@""
												   dic:@{@"cityname":city}
											  progress:nil
											   success:^(NSURLSessionDataTask *task, id response) {
												   if ([response[@"code"] integerValue] == 0) {
													   // 获取城市id之后再获取城市区域列表
													   NSNumber *number = @([[response[@"data"] valueForKey:@"id"] integerValue]);
													   [self getCountryList:number];
													   // 添加全国和城市信息
													   [countyIdArray addObjectsFromArray:@[@(0),number]];
													   [countyNameArray addObjectsFromArray:@[@"全国",city]];
												   } else {
													   [NavigateManager showMessage:response[@"message"]];
												   }
											   } failure:^(NSURLSessionDataTask *task, NSError *error) {
												   [NavigateManager showMessage: @"获取城市id失败"];
											   }];
			
		} else {
			[NavigateManager showMessage:@"获取定位失败，请重试！"];
		}
	}];
	
	[self updateView:NO];
}

- (void)getCountryList:(NSNumber *)cityId {
	[[RequestManager sharedManager] requestUrl:URL_New_getquyu
										method:POST
										loding:@""
										   dic:@{@"city":cityId}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   NSMutableArray *array = [[NSMutableArray alloc] init];
											   [array addObjectsFromArray:[Quyuquarray mj_objectArrayWithKeyValuesArray:response[@"data"]]];
											   
											   for (NSInteger index = 0; index < array.count; index ++) {
												   Quyuquarray *model = array[index];
												   [countyIdArray addObject:@(model.id)];
												   [countyNameArray addObject:model.name];
											   }
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"获取城市区域失败"];
									   }];
}

#pragma mark - 更新时间
- (void)reloadTime {
	for (NSInteger i = 0; i < self.dataArray.count; i ++) {
		MyXuqiuModel *model = [[MyXuqiuModel alloc] init];
		model = self.dataArray[i];
		model.countdown = model.countdown - 60;
		if (model.countdown <= 0) {
			model.countdown = 0;
		}
		[self.dataArray replaceObjectAtIndex:i withObject:model];
	}
	[self.tableView reloadData];
}

- (void)selectedBtnClick:(UIButton *)sender {
	// 点击按钮下拉框
	if (sender == self.oneBtn) {
		self.selectedArray = [NSMutableArray arrayWithObjects:@"婚庆",@"商城",nil];
	} else if (sender == self.twoBtn) {
		self.selectedArray = [NSMutableArray arrayWithObjects:@"浏览量",@"时间排序",@"价格排序",nil];
	} else if (sender == self.threeBtn) {
		self.selectedArray = countyNameArray;
	}
	
	[markBtn setSelected:NO];
	markBtn = sender;
	[markBtn setSelected: YES];
	
	CGFloat height = 45*self.selectedArray.count >= ScreenHeight/2 ? ScreenHeight/2 : 45*self.selectedArray.count;
	
	[self.maskView setHidden: NO];
	[self.dropTableView setHidden: NO];
	[self.dropTableView reloadData];
	self.dropTableView.sd_resetLayout
	.topSpaceToView(self.lineView, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(height);
}

- (void)headerReload {
	WeakSelf(self);
	self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
		[weakSelf updateView:NO];
	}];;
	self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
		[weakSelf updateView:YES];
	}];
}

#pragma mark - 列表数据请求
- (void)updateView:(BOOL)isLoadMore {
	
	
	WeakSelf(self);
	if (!isLoadMore) {
		_page = 1;
	} else {
		_page ++;
	}
	
	[[RequestManager sharedManager] requestUrl:URL_checkDemandList
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
												 @"browsingsort":self.liulanType,
												 @"cityid":@(self.cityId),
												 @"countyid":@(self.countyid),
												 @"p":@(_page),
												 @"pricesorting":self.jiageType,
												 @"timesorting":self.shijanType,
												 @"type":@(self.mallType)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [self.tableView.mj_header endRefreshing];
											   if (!isLoadMore) {
												   [weakSelf.dataArray removeAllObjects];
											   }
											   
											   if ([[MyXuqiuModel mj_objectArrayWithKeyValuesArray:response[@"data"]] count] < 10) {
												   
												   [self.tableView.mj_footer endRefreshingWithNoMoreData];
											   } else {
												   
												   self.tableView.mj_footer.state == MJRefreshStateNoMoreData ? [self.tableView.mj_footer resetNoMoreData] : [self.tableView.mj_footer endRefreshing];
												   
											   }

											   [weakSelf.dataArray addObjectsFromArray:[MyXuqiuModel mj_objectArrayWithKeyValuesArray:response[@"data"]]];
											   [weakSelf.tableView reloadData];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"请求失败"];
									   }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (tableView == self.tableView) {
		return self.dataArray.count <= 0 ? 0 : 1;
	} else {
		return self.selectedArray.count <= 0 ? 0 : 1;
	}
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.tableView) {
		return self.dataArray.count;
	} else {
		return self.selectedArray.count;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (tableView == self.tableView) {
		MyDemandCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
		if (!cell) {
			cell = [[MyDemandCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		MyXuqiuModel *model = self.dataArray[indexPath.row];
		[cell updateViewWithModel:model];
		return cell;
	} else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectedCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"selectedCell"];
		}
		[cell.textLabel setText:self.selectedArray[indexPath.row]];
		return cell;
	}
	
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (tableView == self.tableView) {
		OtherDemandViewController *vc = [[OtherDemandViewController alloc] init];
		vc.model = self.dataArray[indexPath.row];
		[self pushToNextVCWithNextVC:vc];
	} else {
		// 选则了其中一款类型
		[self.maskView setHidden:YES];
		[self.dropTableView setHidden: YES];
		[markBtn setTitle:self.selectedArray[indexPath.row] forState:(UIControlStateNormal)];
		if (self.oneBtn.selected) {
			// 商城类型
			self.mallType = indexPath.row+1;
		} else if (self.twoBtn.selected) {
			// 综合排序
			if (indexPath.row == 0) {
				self.liulanType = [self.liulanType isEqualToString:@"asc"]  ? @"desc" : @"asc";
				self.shijanType = @"";
				self.jiageType = @"";
			} else if (indexPath.row == 1) {
				self.liulanType = @"";
				self.shijanType = [self.shijanType isEqualToString:@"asc"]  ? @"desc" : @"asc";
				self.jiageType = @"";
			} else {
				self.liulanType = @"";
				self.shijanType = @"";
				self.jiageType = [self.jiageType isEqualToString:@"asc"]  ? @"desc" : @"asc";
			}
		} else if (self.threeBtn.selected) {
			// 区域选择
			if (indexPath.row == 0) {
				self.cityId = 0;
				self.countyid = 0;
			} else if (indexPath.row == 1) {
				self.cityId = [countyIdArray[1] integerValue];// 成都市id273
				self.countyid = 0;
			} else {
				self.cityId = [countyIdArray[1] integerValue];
				self.countyid = [countyIdArray[indexPath.row] integerValue];// 传递区域id
			}
		}
		
		[self updateView:NO];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.tableView) {
		return [self cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:self.tableView];
	} else {
		return 45.0f;
	}
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	
	return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	
	return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	
	return 0.0000001;
}

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
	
	NSString *text = @"空空如也";
	
	
	UIFont *font = [UIFont boldSystemFontOfSize:13.0];
	UIColor *textColor = RGBA(202, 202, 202, 1);
	
	
	NSMutableDictionary *attributes = [NSMutableDictionary new];
	
	
	if (font) [attributes setObject:font forKey:NSFontAttributeName];
	if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
	
	return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
	return IMAGE_NAME(@"无数据 空状态");
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
	return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
	return -49.0;
}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -49.0;
//}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
	return self.dataArray.count == 0  && self.dataArray;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
	return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

@end
