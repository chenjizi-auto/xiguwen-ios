//
//  UserPrivacyPolicyViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UserPrivacyPolicyViewController.h"

@interface UserPrivacyPolicyViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UITextView *contentTV;

@end

@implementation UserPrivacyPolicyViewController

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setText:@"博艺婚嫁隐私政策"];
		[_titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
	}
	return _titleLabel;
}

- (UILabel *)promptLabel {
	if (!_promptLabel) {
		_promptLabel = [[UILabel alloc] init];
		[_promptLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_promptLabel setText:@"提示条款"];
	}
	return _promptLabel;
}

- (UITextView *)contentTV {
	if (!_contentTV) {
		_contentTV = [[UITextView alloc] init];
		[_contentTV setFont:[UIFont systemFontOfSize:14.0f]];
	}
	return _contentTV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"隐私政策";
	[self addPopBackBtn];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	[self.view addSubview:self.titleLabel];
	self.titleLabel.sd_layout
	.topSpaceToView(self.view, 74.0f)
	.leftSpaceToView(self.view, 16.0f)
	.rightSpaceToView(self.view, 16.0f)
	.heightIs(40.0f);
	
	[self.view addSubview: self.promptLabel];
	self.promptLabel.sd_layout
	.topSpaceToView(self.titleLabel, 16.0f)
	.leftSpaceToView(self.view, 16.0f)
	.rightSpaceToView(self.view, 16.0f)
	.heightIs(20.0f);
	
	[self.view addSubview:self.contentTV];
	self.contentTV.sd_layout
	.topSpaceToView(self.promptLabel, 10.0f)
	.leftSpaceToView(self.view, 10.0f)
	.rightSpaceToView(self.view, 10.0f)
	.bottomSpaceToView(self.view, 5.0f);
	
	
	// 获取用户协议
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_privacyPolicy
										method:POST
										loding:@""
										   dic:@{}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [weakSelf.contentTV setText:[response[@"data"] objectForKey:@"content"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"用户隐私政策获取失败"];
									   }];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
