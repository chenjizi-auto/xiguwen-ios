//
//  CheckScheduleViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CheckScheduleViewController.h"
#import "XinZenDangqiViewController.h"
#import "RemindShowView.h"

@interface CheckScheduleViewController ()

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) RemindShowView *remindShowView;

@end

@implementation CheckScheduleViewController

- (RemindShowView *)remindShowView {
	if (!_remindShowView) {
		_remindShowView = [[RemindShowView alloc] init];
		_remindShowView.tableView.userInteractionEnabled = NO;
		_remindShowView.isDeleteHidden = YES;
	}
	return _remindShowView;
}

- (UIButton *)deleteBtn {
	if (!_deleteBtn) {
		_deleteBtn = [[UIButton alloc] init];
		[_deleteBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
		[_deleteBtn setTitle: @"删除档期" forState:(UIControlStateNormal)];
		[_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _deleteBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationItem setTitle: @"查看档期"];
	[self addRightBtnWithTitle:@"编辑" image:nil];
	[self addPopBackBtn];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	// 添加提醒
	UIView *container = [[UIView alloc]init];
	[self.view addSubview:container];
    ZL_Navigation_Height(navigationHeight);
	container.sd_layout
	.topSpaceToView(self.view, navigationHeight)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(0.1f);
	
	[self.remindShowView setIsDeleteHidden: YES];
	[self.view addSubview:self.remindShowView];
	self.remindShowView.sd_layout
	.topSpaceToView(container, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(40.0f*self.model.tixing.count);
	[self.remindShowView updateViewWithModel:self.model.tixing];
	
	container = self.remindShowView;
	
	// 添加其他信息
	NSArray *titleArr = @[@"时间",@"联系人",@"电话",@"备注"];
	NSArray *infoArr = @[[NSString stringWithFormat: @"%@ %@",self.model.date,self.model.timeslot],self.model.contacts ? self.model.contacts : @"",self.model.contactnumber ? self.model.contactnumber : @"",self.model.remarks ? self.model.remarks : @""];
	// [self.model.contactnumber stringByReplacingOccurrencesOfString:[self.model.contactnumber substringWithRange:NSMakeRange(3, 4)] withString:@"****"]
	for (NSInteger i = 0; i < 4; i ++) {
		
		UILabel *titleLabel = [[UILabel alloc] init];
		[titleLabel setText:titleArr[i]];
		[titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[self.view addSubview: titleLabel];
		titleLabel.sd_layout
		.topSpaceToView(container, 0.0f)
		.leftSpaceToView(self.view, 15.0f)
		.widthIs(80.0f)
		.heightIs(50.0f);
		
		UILabel *infoLabel = [[UILabel alloc] init];
		[infoLabel setText: infoArr[i]];
		[infoLabel setTextAlignment:NSTextAlignmentRight];
		[infoLabel setTextColor:UIColorFromRGB(0x898989)];
		[infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
		[self.view addSubview: infoLabel];
		infoLabel.sd_layout
		.centerYEqualToView(titleLabel)
		.rightSpaceToView(self.view, 15.0f)
		.leftSpaceToView(titleLabel, 10.0f)
		.heightIs(50.0f);
		
		UIView *lineView = [[UIView alloc] init];
		[lineView setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
		[self.view addSubview:lineView];
		lineView.sd_layout
		.topSpaceToView(titleLabel, 0.0f)
		.leftSpaceToView(self.view, 15.0f)
		.rightSpaceToView(self.view, 0.0f)
		.heightIs(1.0f);
		
		container = lineView;
	}
	
	[self.view addSubview:self.deleteBtn];
	self.deleteBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
	
}

- (void)respondsToRightBtn {
	// 跳转编辑页面
	XinZenDangqiViewController *vc = [[XinZenDangqiViewController alloc] init];
	vc.model = self.model;
	vc.isEdit = YES;
	[self pushToNextVCWithNextVC:vc];
}

- (void)deleteBtnClick {
	// 删除档期
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_deleteSchedule
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
												 @"id":@(self.model.id)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"删除成功"];
											   [weakSelf popViewConDelay];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"删除成功"];
									   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
