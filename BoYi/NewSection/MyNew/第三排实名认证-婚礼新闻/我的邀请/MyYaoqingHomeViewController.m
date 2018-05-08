//
//  MyYaoqingHomeViewController.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyYaoqingHomeViewController.h"
#import "MyYaoQingViewController.h"
#import "MOFSPickerManager.h"
@interface MyYaoqingHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel; // 成功邀请人数
@property (weak, nonatomic) IBOutlet UILabel *couponLabel; // 现金折扣券
@property (nonatomic, strong) NSDate *showTime;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation MyYaoqingHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的邀请";
    [self addRightBtnWithTitle:@"明细" image:nil];
    [self addPopBackBtn];
}
- (void)respondsToRightBtn {
    MyYaoQingViewController *my = [[MyYaoQingViewController alloc] init];
	my.showDate = self.showTime;
    [self pushToNextVCWithNextVC:my];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// 获取当前日期
	NSDate *datenow = [NSDate date];
	self.showTime = datenow;
	[self updateRequest:self.showTime];
}

- (IBAction)beforeBtn:(UIButton *)sender {
	// 点击上一天实现功能
	self.showTime = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.showTime];
	[self updateRequest:self.showTime];
}

- (IBAction)after:(UIButton *)sender {
	// 点击下一天实现功能
	self.showTime = [NSDate dateWithTimeInterval:24*60*60 sinceDate:self.showTime];
	[self updateRequest:self.showTime];
}

- (IBAction)dateBtn:(UIButton *)sender {
	// 点击日期实现功能
	WeakSelf(self);
	[[MOFSPickerManager shareManger] showDatePickerWithTag:0 commitBlock:^(NSDate * _Nonnull date) {
		weakSelf.showTime = date;
		[weakSelf updateRequest:date];
	} cancelBlock:^{
		
	}];
}




- (void)updateRequest:(NSDate *)date {
	// 格式化时间
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy年MM月dd日"];
	NSString *showStr = [formatter stringFromDate:self.showTime];
	// 将NSDate转换为时间戳
	NSInteger timeStamp = [self.showTime timeIntervalSince1970];
	
	// 根据日期更新数据
	[[RequestManager sharedManager] requestUrl:URL_myInvitation
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
												 @"time":@(timeStamp)}
									  progress:nil success:^(NSURLSessionDataTask *task, id response) {
										  self.numberLabel.text = [NSString stringWithFormat: @"%ld",[[response[@"data"] objectForKey:@"num"] integerValue]];
										  self.couponLabel.text = [NSString stringWithFormat: @"%ld",[[response[@"data"] objectForKey:@"money"] integerValue]];
										  // 更改显示时间
										  self.timeLabel.text = showStr;
									  } failure:^(NSURLSessionDataTask *task, NSError *error) {
										  [NavigateManager showMessage: @"请求失败"];
									  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
