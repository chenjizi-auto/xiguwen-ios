//
//  OtherDemandViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OtherDemandViewController.h"

@interface OtherDemandViewController () {
	NSMutableDictionary *urlDic;
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *lastTimeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *liulan;
@property (nonatomic, strong) UILabel *canyu;
@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UITextView *explainTV;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) UIButton *orderBtn;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OtherDemandViewController

#pragma mark -- Setters and getters
- (UIView *)headerView {
	if (!_headerView) {
		_headerView = [[UIView alloc] init];
		[_headerView setBackgroundColor:UIColorFromRGB(0xFFF2DC)];
	}
	return _headerView;
}
- (UILabel *)lastTimeLabel {
	if (!_lastTimeLabel) {
		_lastTimeLabel = [[UILabel alloc] init];
		[_lastTimeLabel setTextColor:UIColorFromRGB(0xFC7017)];
		[_lastTimeLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_lastTimeLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _lastTimeLabel;
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
		[_priceLabel setFont:[UIFont systemFontOfSize:18.0f]];
		[_priceLabel setTextColor:UIColorFromRGB(0xFC5887)];
	}
	return _priceLabel;
}
- (UILabel *)addressLabel {
	if (!_addressLabel) {
		_addressLabel = [[UILabel alloc] init];
		[_addressLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[_addressLabel setTextColor:UIColorFromRGB(0x535353)];
		[_addressLabel setTextAlignment:NSTextAlignmentRight];
	}
	return _addressLabel;
}
- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		[_timeLabel setFont:[UIFont systemFontOfSize:13.0f]];
		[_timeLabel setTextColor:UIColorFromRGB(0x898989)];
	}
	return _timeLabel;
}
- (UILabel *)liulan {
	if (!_liulan) {
		_liulan = [[UILabel alloc] init];
		[_liulan setFont:[UIFont systemFontOfSize:13.0f]];
		[_liulan setTextColor:UIColorFromRGB(0x898989)];
		[_liulan setTextAlignment:NSTextAlignmentCenter];
	}
	return _liulan;
}
- (UILabel *)canyu {
	if (!_canyu) {
		_canyu = [[UILabel alloc] init];
		[_canyu setFont:[UIFont systemFontOfSize:13.0f]];
		[_canyu setTextColor:UIColorFromRGB(0x898989)];
		[_canyu setTextAlignment:NSTextAlignmentCenter];
	}
	return _canyu;
}
- (UIView *)lineOne {
	if (!_lineOne) {
		_lineOne = [[UIView alloc] init];
		[_lineOne setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineOne;
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
- (UITextView *)explainTV {
	if (!_explainTV) {
		_explainTV = [[UITextView alloc] init];
		[_explainTV setFont:[UIFont systemFontOfSize:15.0f]];
		[_explainTV setTextColor:UIColorFromRGB(0xB3B3B3)];
	}
	return _explainTV;
}

- (UIView *)bottomView {
	if (!_bottomView) {
		_bottomView = [[UIView alloc] init];
	}
	return _bottomView;
}
- (UIButton *)messageBtn {
	if (!_messageBtn) {
		_messageBtn = [[UIButton alloc] init];
		[_messageBtn setImage:[UIImage imageNamed:@"私信"] forState:(UIControlStateNormal)];
		[_messageBtn addTarget:self action:@selector(makeCall:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _messageBtn;
}
- (UIButton *)phoneBtn {
	if (!_phoneBtn) {
		_phoneBtn = [[UIButton alloc] init];
		[_phoneBtn setImage:[UIImage imageNamed:@"电话的副本"] forState:(UIControlStateNormal)];
		[_phoneBtn addTarget:self action:@selector(makeCall:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _phoneBtn;
}
- (UIButton *)orderBtn {
	if (!_orderBtn) {
		_orderBtn = [[UIButton alloc] init];
		[_orderBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
		[_orderBtn setTitle:@"我来接单" forState:(UIControlStateNormal)];
		[_orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _orderBtn;
}
- (UIView *)lineTwo {
	if (!_lineTwo) {
		_lineTwo = [[UIView alloc] init];
		[_lineTwo setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineTwo;
}

- (NSTimer *)timer {
	if (!_timer) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(uploadTime) userInfo:nil repeats:YES];
	}
	return _timer;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// 	请求分享接口
	[[RequestManager sharedManager] requestUrl:URL_xuqiuDetailsShare
										method:POST
										loding:@""
										   dic:@{@"id":@(self.model.id)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
//											   urlDic = @{@"url":[[response[@"date"] objectForKey:@"url"]};
//														  @"title":[[response[@"date"] objectForKey:@"title"],
//														  @"image":[[response[@"date"] objectForKey:@"image"],
//														  @"descr":[[response[@"date"] objectForKey:@"descr"]
//																	};
                                               urlDic = [[NSMutableDictionary alloc] init];
											   [urlDic setValue:response[@"data"][@"url"] forKey:@"url"];
											   [urlDic setValue:response[@"data"][@"title"] forKey:@"title"];
											   [urlDic setValue:response[@"data"][@"image"] forKey:@"image"];
											   [urlDic setValue:response[@"data"][@"descr"] forKey:@"descr"];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"分享链接请求失败"];
									   }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self addPopBackBtn];
	self.navigationItem.title = @"需求详情";
	
	[self addRightBtnWithTitle:@"" image:@"分享的副本"];
	
	
	[self.timer setFireDate:[NSDate distantPast]];
	
	
	[self.view addSubview: self.headerView];
	self.headerView.sd_layout
	.topSpaceToView(self.view, 64.0f)
	.leftSpaceToView(self.view, 0.0f )
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(self.model.status == 1 ? 40.0f : 0.0f);
	
	[self.headerView addSubview: self.lastTimeLabel];
	self.lastTimeLabel.sd_layout
	.centerYEqualToView(self.headerView)
	.centerXEqualToView(self.headerView)
	.heightIs(20.0f);
	[self.lastTimeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
	[self.lastTimeLabel setHidden:self.model.status == 1 ? NO : YES];
	
	UIImageView *timeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"时间"]];
	[self.headerView addSubview: timeImg];
	timeImg.sd_layout
	.centerYEqualToView(self.headerView)
	.rightSpaceToView(self.lastTimeLabel, 5.0f)
	.widthIs(20.0f)
	.heightEqualToWidth();
	[timeImg setHidden:self.model.status == 1 ? NO : YES];
	
	[self.view addSubview: self.titleLabel];
	self.titleLabel.sd_layout
	.topSpaceToView(self.headerView, 0.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(40.0f);
	
	[self.view addSubview: self.priceLabel];
	self.priceLabel.sd_layout
	.topSpaceToView(self.titleLabel, 0.0f)
	.leftSpaceToView(self.view, 15.0f)
	.heightIs(30.0f);
	[self.priceLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/2];
	
	[self.view addSubview:self.addressLabel];
	self.addressLabel.sd_layout
	.centerYEqualToView(self.priceLabel)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(20.0f);
	[self.addressLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/2];
	
	[self.view addSubview: self.timeLabel];
	self.timeLabel.sd_layout
	.topSpaceToView(self.priceLabel, 0.0f)
	.leftSpaceToView(self.view, 15.0f)
	.heightIs(30.0f);
	[self.timeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/2];
	
	[self.view addSubview: self.canyu];
	self.canyu.sd_layout
	.centerYEqualToView(self.timeLabel)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(20.0f);
	[self.canyu setSingleLineAutoResizeWithMaxWidth:100.0f];
	
	[self.view addSubview: self.liulan];
	self.liulan.sd_layout
	.centerYEqualToView(self.timeLabel)
	.rightSpaceToView(self.canyu, 5.0f)
	.heightIs(20.0f);
	[self.liulan setSingleLineAutoResizeWithMaxWidth:100.0f];
	
	[self.view addSubview: self.lineOne];
	self.lineOne.sd_layout
	.topSpaceToView(self.timeLabel, 0.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(1.0f);
	
	[self.view addSubview: self.detailsLabel];
	self.detailsLabel.sd_layout
	.topSpaceToView(self.lineOne, 5.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.autoHeightRatio(0);
	
	[self.view addSubview: self.sectionView];
	self.sectionView.sd_layout
	.topSpaceToView(self.detailsLabel, 5.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(8.0f);
	
	[self.view addSubview:self.explainTV];
	self.explainTV.sd_layout
	.topSpaceToView(self.sectionView, 5.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(150.0f);
	self.explainTV.delegate = self;
	self.explainTV.inputAccessoryView = [self addToolbar];

	
	
	[self.view addSubview:self.bottomView];
	self.bottomView.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
	
	[self.bottomView addSubview: self.lineTwo];
	self.lineTwo.sd_layout
	.topSpaceToView(self.bottomView, 0.0f)
	.leftSpaceToView(self.bottomView, 0.0f)
	.rightSpaceToView(self.bottomView, 0.0f)
	.heightIs(1.0f);
	
	[self.bottomView addSubview: self.messageBtn];
	self.messageBtn.sd_layout
	.centerXIs(ScreenWidth/8)
	.topSpaceToView(self.lineTwo, 0.0f)
	.bottomSpaceToView(self.bottomView, 0.0f)
	.widthIs(40.0f);
	
	[self.bottomView addSubview:self.phoneBtn];
	self.phoneBtn.sd_layout
	.centerXIs(ScreenWidth/8*3)
	.topSpaceToView(self.lineTwo, 0.0f)
	.bottomSpaceToView(self.bottomView, 0.0f)
	.widthIs(40.0f);
	
	[self.bottomView addSubview: self.orderBtn];
	self.orderBtn.sd_layout
	.topSpaceToView(self.lineTwo, 0.0f)
	.rightSpaceToView(self.bottomView, 0.0f)
	.widthIs(ScreenWidth/2)
	.bottomSpaceToView(self.bottomView, 0.0f);
	
	// 绑定数据
	[self.lastTimeLabel setText: [NSString stringWithFormat: @"剩余时间%.2ld天%.2ld时%.2ld分%.2ld秒",self.model.countdown/(24 *3600),self.model.countdown/(24 *3600)%3600,self.model.countdown/60%60,self.model.countdown%60]];
	[self.titleLabel setText: self.model.title];
	[self.priceLabel setText:[NSString stringWithFormat:@"¥%ld",self.model.price]];
	[self.addressLabel setText: self.model.address];
	[self.timeLabel setText:[NSString stringWithFormat:@"发布时间:%@",self.model.create_ti]];
	[self.canyu setText:[NSString stringWithFormat:@"参与:%ld",self.model.renshu]];
	[self.liulan setText:[NSString stringWithFormat:@"浏览:%ld",self.model.browsingvolume]];
	[self.detailsLabel setText: self.model.details];
	
	[self.explainTV setText:@"请录入您的接单说明..."];
	
	if (self.model.status == 2) {
		[self.orderBtn setUserInteractionEnabled: NO];
		[self.orderBtn setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	
	[self.messageBtn setUserInteractionEnabled:self.model.openmessage == 0 ? NO : YES];
	[self.phoneBtn setUserInteractionEnabled:self.model.openphone == 0 ? NO : YES];
	[self.orderBtn setUserInteractionEnabled:self.model.jiedan == 0 ? YES : NO];
	[self.orderBtn setBackgroundColor:self.model.jiedan == 0 ? UIColorFromRGB(0xFF7299) : UIColorFromRGB(0xF0F0F0)];
}

- (void)uploadTime {
	self.model.countdown --;
	if (self.model.countdown <= 0) {
		self.model.countdown = 0;
	}
	[self.lastTimeLabel setText: [NSString stringWithFormat: @"剩余时间%.2ld天%.2ld时%.2ld分%.2ld秒",self.model.countdown/(24 *3600),self.model.countdown/(24 *3600)%3600,self.model.countdown/60%60,self.model.countdown%60]];
}

#pragma mark - 拨打电话或者发送短息
- (void)makeCall:(UIButton *)sender {
	if (sender == self.messageBtn) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",self.model.mobile]]];
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.userid] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
	} else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.model.mobile]]];
	}
}

#pragma mark - 分享的操作
- (void)respondsToRightBtn {
	// 分享按钮
	[CwShareManager shareWebPageToPlatformWithUrl:[urlDic objectForKey:@"url"] image:[urlDic objectForKey:@"image"] title:[urlDic objectForKey:@"title"] descr:[urlDic objectForKey:@"descr"] vc:self completion:^(id data, NSError *error) {

	}];
}

#pragma mark - 接单
- (void)orderBtnClick {
	DLog(@"我来接单");
	if (self.explainTV.text.length <= 0) {
		[NavigateManager showMessage: @"请填写接单说明"];
		return;
	}
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_takeDemandOrder
										method:POST
										loding:@""
										   dic:@{@"cont":self.explainTV.text,
												 @"id":@(self.model.id),
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage:@"接单请求已发送"];
											   weakSelf.model.jiedan = 1;
											   [weakSelf.orderBtn setUserInteractionEnabled:weakSelf.model.jiedan == 0 ? YES : NO];
											   [weakSelf.orderBtn setBackgroundColor:weakSelf.model.jiedan == 0 ? UIColorFromRGB(0xFF7299) : UIColorFromRGB(0xF0F0F0)];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"接单失败"];
									   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
