//
//  AddTixingViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddTixingViewController.h"
#import "CaipaiTiixingViewController.h"
#import "OtherTixingViewController.h"
#import "AddRemindViewController.h"

@interface AddTixingViewController ()

@end

@implementation AddTixingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加提醒";
    [self addPopBackBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.onComplete(self.model);
}

- (IBAction)action:(UIButton *)sender {
	AddRemindViewController *caipai = [[AddRemindViewController alloc] init];
	caipai.model = self.model;
	caipai.isEdit = NO;
	caipai.type = sender.tag + 1;
	
    if (sender.tag == 0) {
		caipai.navigationItem.title = @"彩排提醒";
    }else if (sender.tag == 1) {
		caipai.navigationItem.title = @"约见提醒";
    }else {
		caipai.navigationItem.title = @"其他提醒";
    }
	
	[self pushToNextVCWithNextVC:caipai];
	
	[caipai setOnComplete:^(DangQiDetailsModel *model) {
		// 二级页面返回数据
		self.model = model;
	}];
	
}


@end
