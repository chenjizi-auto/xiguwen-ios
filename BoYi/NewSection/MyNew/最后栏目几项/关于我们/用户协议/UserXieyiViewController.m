//
//  UserXieyiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UserXieyiViewController.h"

@interface UserXieyiViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTV;

@end

@implementation UserXieyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户协议";
    [self addPopBackBtn];
	
	// 获取用户协议
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_userAgreement
										method:POST
										loding:@""
										   dic:@{}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [weakSelf.contentTV setText:[response[@"data"] objectForKey:@"content"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"用户协议获取失败"];
									   }];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
