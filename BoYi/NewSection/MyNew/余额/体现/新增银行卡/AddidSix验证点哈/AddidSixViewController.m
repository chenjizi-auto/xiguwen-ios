//
//  AddidSixViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddidSixViewController.h"
#import "ChoeseCarIDViewController.h"

@interface AddidSixViewController () {
	NSInteger seconds;
}
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *phoneTF;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AddidSixViewController

- (NSTimer *)timer {
	if (!_timer) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(rockonTime) userInfo:nil repeats:YES];
	}
	return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    [self addPopBackBtn];
	
	[self.codeBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
	[self.codeBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
	[self.codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    self.phoneTF.delegate = self;
    self.codeTF.delegate = self;
    self.phoneTF.inputAccessoryView = [self addToolbar];
    self.codeTF.inputAccessoryView = [self addToolbar];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)rockonTime {
	// 短信验证定时器
	seconds --;
	if (seconds <= 0) {
		// 关闭定时器
		[self.timer setFireDate:[NSDate distantFuture]];
		[self.codeBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
		[self.codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
		[self.codeBtn setUserInteractionEnabled:YES];
	} else {
		// 定时器开启
		[self.codeBtn setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
		[self.codeBtn setTitle:[NSString stringWithFormat:@"倒计时(%lds)",seconds] forState:(UIControlStateNormal)];
		[self.codeBtn setUserInteractionEnabled:NO];
	}
}

- (IBAction)sendCode:(UIButton *)sender {
	// 发送验证码
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_New_getcode
										method:POST
										loding:@""
										   dic:@{@"mobile":self.phoneTF.text}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"发送验证码成功"];
											   seconds = 60;
											   [self.timer setFireDate:[NSDate distantPast]];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"发送验证码失败"];
									   }];
	
}
- (IBAction)toNext:(UIButton *)sender {
	// 下一步(提交新的银行卡)
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_submitBankCard
										method:POST
										loding:@""
										   dic:@{@"bandname":self.model.bandname,
												 @"bandnumber":self.model.bandnumber,
												 @"mobile":self.phoneTF.text,
												 @"name":self.model.name,
												 @"site":self.model.site,
												 @"verifycode":self.codeTF.text,
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"添加成功"];
											   [weakSelf jump];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"添加失败"];
									   }];
	
}

- (void)jump {
	ChoeseCarIDViewController *jumpVC = nil;
	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
		FatherViewController *vc = self.navigationController.viewControllers[i];
		if ([vc isKindOfClass:[ChoeseCarIDViewController class]]) {
			jumpVC = (ChoeseCarIDViewController *)vc;
			break;
		}
	}
	[self.navigationController popToViewController:jumpVC animated:YES];
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (self.phoneTF.text.length > 0 && self.codeTF.text.length > 0) {
		[self.nextBtn setUserInteractionEnabled:YES];
		[self.nextBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
	} else {
		[self.nextBtn setUserInteractionEnabled:NO];
		[self.nextBtn setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	}
	
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
