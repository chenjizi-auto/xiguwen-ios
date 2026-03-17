//
//  DaiLiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DaiLiViewController.h"

@interface DaiLiViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;
@property (weak, nonatomic) IBOutlet UITextView *infoTV;

@end

@implementation DaiLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationItem setTitle:@"代理招募"];
    [self addPopBackBtn];
    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.phoneTF.delegate = self;
    self.phoneTF.inputAccessoryView = [self addToolbar];
    self.codeTF.delegate = self;
    self.codeTF.inputAccessoryView = [self addToolbar];
    self.areaTF.delegate = self;
    self.areaTF.inputAccessoryView = [self addToolbar];
    self.infoTV.delegate = self;
    self.infoTV.inputAccessoryView = [self addToolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)getCode:(UIButton *)sender {
	// 请求验证码
	if (self.phoneTF.text.length <= 0) {
		[NavigateManager showMessage:@"请填写手机号"];
		return;
	}
	
	[[RequestManager sharedManager] requestUrl:URL_New_getcode
										method:POST
										loding:@""
										   dic:@{@"mobile":self.phoneTF.text}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage:@"验证码发送成功"];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"验证码发送失败"];
									   }];
}

- (IBAction)submit:(id)sender {
	// 提交审核后
	if (self.nameTF.text.length <= 0) {
		[NavigateManager showMessage:@"请输入您的姓名"];
		return;
	}
	if (self.phoneTF.text.length <= 0) {
		[NavigateManager showMessage:@"请输入您的手机号"];
		return;
	}
	if (self.codeTF.text.length <= 0) {
		[NavigateManager showMessage:@"请输入当前手机验证码"];
		return;
	}
	if (self.areaTF.text.length <= 0) {
		[NavigateManager showMessage:@"请输入意向合作区域"];
		return;
	}
	if (self.infoTV.text.length <= 0) {
		[NavigateManager showMessage:@"请输入您的团队介绍"];
		return;
	}
	
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_recruitAgency
										method:POST
										loding:@""
										   dic:@{@"cooperativearea":self.areaTF.text,
												 @"mobile":self.phoneTF.text,
												 @"name":self.nameTF.text,
												 @"teamjs":self.infoTV.text,
												 @"verifycode":self.codeTF.text}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage:response[@"message"]];
											   [weakSelf popViewConDelay];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"提交失败"];
									   }];
}

@end
