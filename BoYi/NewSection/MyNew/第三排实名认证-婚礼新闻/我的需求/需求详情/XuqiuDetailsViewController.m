//
//  XuqiuDetailsViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "XuqiuDetailsViewController.h"
#import "MyXuqiuModel.h"
#import "MyxuqiuCollectionViewCell.h"
#import "JoinDetilViewController.h"

@interface XuqiuDetailsViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *remainTimeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *liulanLabel;
@property (nonatomic, strong) UILabel *canyuLabel;
@property (nonatomic, strong) UIView *oneLineView;
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *twoLineView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) XuqiuDetailsModel *model;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XuqiuDetailsViewController

#pragma mark - Setters and getters
- (UIScrollView *)scrollView {
	if (!_scrollView) {
		_scrollView = [[UIScrollView alloc] init];
		[_scrollView setBackgroundColor:[UIColor whiteColor]];
	}
	return _scrollView;
}
- (UIView *)headerView {
	if (!_headerView) {
		_headerView = [[UIView alloc] init];
		[_headerView setBackgroundColor:UIColorFromRGB(0xFFF2DC)];
	}
	return _headerView;
}
- (UILabel *)remainTimeLabel {
	if (!_remainTimeLabel) {
		_remainTimeLabel = [[UILabel alloc] init];
		[_remainTimeLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_remainTimeLabel setTextColor:UIColorFromRGB(0xFC7017)];
		[_remainTimeLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _remainTimeLabel;
}
- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
	}
	return _titleLabel;
}
- (UILabel *)priceLabel {
	if (!_priceLabel) {
		_priceLabel = [[UILabel alloc] init];
		[_priceLabel setTextColor:UIColorFromRGB(0xFC5887)];
		[_priceLabel setFont:[UIFont systemFontOfSize:18.0f]];
	}
	return _priceLabel;
}
- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		[_timeLabel setFont:[UIFont systemFontOfSize:13.0f]];
		[_timeLabel setTextColor:UIColorFromRGB(0x898989)];
	}
	return _timeLabel;
}
- (UILabel *)liulanLabel {
	if (!_liulanLabel) {
		_liulanLabel = [[UILabel alloc] init];
		[_liulanLabel setFont:[UIFont systemFontOfSize:13.0f]];
		[_liulanLabel setTextColor:UIColorFromRGB(0x898989)];
		[_liulanLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _liulanLabel;
}
- (UILabel *)canyuLabel {
	if (!_canyuLabel) {
		_canyuLabel = [[UILabel alloc] init];
		[_canyuLabel setFont:[UIFont systemFontOfSize:13.0f]];
		[_canyuLabel setTextColor:UIColorFromRGB(0x898989)];
		[_canyuLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _canyuLabel;
}
- (UIView *)oneLineView {
	if (!_oneLineView) {
		_oneLineView = [[UIView alloc] init];
		[_oneLineView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _oneLineView;
}
- (UILabel *)detailsLabel {
	if (!_detailsLabel) {
		_detailsLabel = [[UILabel alloc] init];
		[_detailsLabel setFont:[UIFont systemFontOfSize:15.0f]];
	}
	return _detailsLabel;
}
- (UIView *)sectionView {
	if (!_sectionView) {
		_sectionView = [[UIView alloc] init];
		[_sectionView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _sectionView;
}
- (UILabel *)infoLabel {
	if (!_infoLabel) {
		_infoLabel = [[UILabel alloc] init];
		[_infoLabel setText: @"参与人"];
		[_infoLabel setFont:[UIFont systemFontOfSize:16.0f]];
	}
	return _infoLabel;
}
- (UIView *)twoLineView {
	if (!_twoLineView) {
		_twoLineView = [[UIView alloc] init];
		[_twoLineView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _twoLineView;
}
- (UICollectionView *)collectionView {
	if (!_collectionView) {
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, 150.0f) collectionViewLayout:self.flowLayout];
		[_collectionView setBackgroundColor:[UIColor whiteColor]];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.bounces = NO;
		_collectionView.scrollEnabled = NO;
		[_collectionView registerNib:[UINib nibWithNibName:@"MyxuqiuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
	}
	return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
	if (!_flowLayout) {
		_flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_flowLayout.itemSize = CGSizeMake(ScreenWidth / 3 - 5,150);
	}
	return _flowLayout;
}

- (XuqiuDetailsModel *)model{
	if (!_model) {
		_model = [[XuqiuDetailsModel alloc] init];
	}
	return _model;
}

- (NSTimer *)timer {
	if (!_timer) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadTime) userInfo:nil repeats:YES];
	}
	return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"需求详情";
	[self addPopBackBtn];
	[self.timer setFireDate:[NSDate distantPast]];// 开启定时器
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// 请求详情数据
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_myDemandDetails
										method:POST
										loding:@""
										   dic:@{@"id":@(self.kid),
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   // 刷新数据
											   weakSelf.model = [XuqiuDetailsModel mj_objectWithKeyValues:response[@"data"]];
											   [weakSelf updateMainView];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"数据请求错误"];
									   }];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
//	[self.timer setFireDate:[NSDate distantFuture]];// 关闭定时器
}


- (void)reloadTime {
	self.model.xuquxiangqing.countdown --;
	if (self.model.xuquxiangqing.countdown <= 0) {
		self.model.xuquxiangqing.countdown = 0;
	}
	[self.remainTimeLabel setText:[NSString stringWithFormat: @"剩余时间%.2ld天%.2ld时%.2ld分%.2ld秒",self.model.xuquxiangqing.countdown/(24 *3600),self.model.xuquxiangqing.countdown/(24 *3600)%3600,self.model.xuquxiangqing.countdown/60%60,self.model.xuquxiangqing.countdown%60]];
}


- (void)updateMainView {
	// 添加滚动视图
	[self.view addSubview: self.scrollView];
	self.scrollView.sd_layout
	.topSpaceToView(self.view, 64.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
	
	UIView *container = self.scrollView;
	// 添加子视图
	if (self.model.xuquxiangqing.status == 1) {
		// 进行中
		[self.scrollView addSubview: self.headerView];
		self.headerView.sd_layout
		.topSpaceToView(self.scrollView, 0.0f)
		.leftSpaceToView(self.scrollView, 0.0f)
		.rightSpaceToView(self.scrollView, 0.0f)
		.heightIs(40.0f);
		
		container = self.headerView;
		
		[self.headerView addSubview: self.remainTimeLabel];
		self.remainTimeLabel.sd_layout
		.centerXEqualToView(self.headerView)
		.centerYEqualToView(self.headerView)
		.heightIs(20.0f);
		[self.remainTimeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
		
		UIImageView *timeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"时间"]];
		[self.headerView addSubview:timeImg];
		timeImg.sd_layout
		.centerYEqualToView(self.remainTimeLabel)
		.rightSpaceToView(self.remainTimeLabel, 5.0f)
		.widthIs(20.0f)
		.heightEqualToWidth();
		
	} else {
		// 已结束
	}
	
	[self.scrollView addSubview:self.titleLabel];
	self.titleLabel.sd_layout
	.topSpaceToView(container, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(40.0f);
	
	[self.scrollView addSubview: self.priceLabel];
	self.priceLabel.sd_layout
	.topSpaceToView(self.titleLabel, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(30.0f);

	[self.scrollView addSubview:self.timeLabel];
	self.timeLabel.sd_layout
	.topSpaceToView(self.priceLabel, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.widthIs(ScreenWidth/2)
	.heightIs(40.0f);

	[self.scrollView addSubview: self.canyuLabel];
	self.canyuLabel.sd_layout
	.centerYEqualToView(self.timeLabel)
	.rightSpaceToView(self.scrollView, 15.0f)
	.widthIs(60.0f)
	.heightIs(20.0f);

	[self.scrollView addSubview: self.liulanLabel];
	self.liulanLabel.sd_layout
	.centerYEqualToView(self.timeLabel)
	.rightSpaceToView(self.canyuLabel, 5.0f)
	.widthIs(60.0f)
	.heightIs(20.0f);

	[self.scrollView addSubview:self.oneLineView];
	self.oneLineView.sd_layout
	.topSpaceToView(self.timeLabel, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(1.0f);

	[self.scrollView addSubview: self.detailsLabel];
	self.detailsLabel.sd_layout
	.topSpaceToView(self.oneLineView, 5.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.autoHeightRatio(0);

	[self.scrollView addSubview: self.sectionView];
	self.sectionView.sd_layout
	.topSpaceToView(self.detailsLabel, 5.0f)
	.leftSpaceToView(self.scrollView, 0.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(8.0f);

	[self.scrollView addSubview: self.infoLabel];
	self.infoLabel.sd_layout
	.topSpaceToView(self.sectionView, 5.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(40.0f);

	[self.scrollView addSubview: self.twoLineView];
	self.twoLineView.sd_layout
	.topSpaceToView(self.infoLabel, 5.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(1.0f);
	
	
	CGFloat height = 150*(self.model.jiedanren.count/3 + (self.model.jiedanren.count%3 > 0 ? 1 : 0)) + 20;
	
	[self.scrollView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.twoLineView, 0.0f)
	.leftSpaceToView(self.scrollView, 0.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(height);
	
	[self.scrollView setupAutoContentSizeWithBottomView:self.collectionView bottomMargin:0.0f];
	
//	[self.scrollView setContentSize:CGSizeMake(ScreenWidth, ScreenHeight)];
	
	// 绑定数据
	[self.remainTimeLabel setText:[NSString stringWithFormat: @"剩余时间%.2ld天%.2ld时%.2ld分%.2ld秒",self.model.xuquxiangqing.countdown/(24 *3600),self.model.xuquxiangqing.countdown/(24 *3600)%3600,self.model.xuquxiangqing.countdown/60%60,self.model.xuquxiangqing.countdown%60]];
	[self.titleLabel setText:self.model.xuquxiangqing.title];
	[self.priceLabel setText:[NSString stringWithFormat:@"¥%.2f",(float)self.model.xuquxiangqing.price]];
	[self.timeLabel setText:[NSString stringWithFormat:@"发布时间:%@",self.model.xuquxiangqing.create_ti]];
	[self.liulanLabel setText:[NSString stringWithFormat:@"浏览:%ld",self.model.xuquxiangqing.browsingvolume]];
	[self.canyuLabel setText:[NSString stringWithFormat:@"参与:%ld",self.model.xuquxiangqing.renshu]];
	[self.detailsLabel setText:self.model.xuquxiangqing.details];
	
}

//item个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return self.model.jiedanren.count <= 0 ? 0 : 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.model.jiedanren.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	JoinDetilViewController *join = [[JoinDetilViewController alloc] init];
	// 传递数据
	PlayersModel *model = self.model.jiedanren[indexPath.row];
	join.cid = model.cid;
	[self pushToNextVCWithNextVC:join];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//重用cell
	DLog(@"%@",self.model.jiedanren[indexPath.row]);
	MyxuqiuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	//    cell.city.text = self.fuwuArray[indexPath.row];
	
	cell.model = self.model.jiedanren[indexPath.row];
	
	return cell;
	
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(ScreenWidth / 3 - 5,150);
	
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
	return 0;
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
