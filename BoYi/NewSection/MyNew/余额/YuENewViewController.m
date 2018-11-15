//
//  YuENewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "YuENewViewController.h"
#import "MingxiNewViewController.h"
#import "TixianNewViewController.h"
#import "ChoeseCarIDViewController.h"
@interface YuENewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation YuENewViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
	
	// 请求余额信息
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_myAccountBalance
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   [weakSelf.balanceLabel setText:response[@"data"]];
										   [[UserDataNew sharedManager].userInfoModel.user setVouchers:response[@"data"]];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popac:(UIButton *)sender {
    [self popViewConDelay];
}
- (IBAction)actionall:(UIButton *)sender {
    if (sender.tag == 0) {//明细
        MingxiNewViewController *mingxi = [[MingxiNewViewController alloc] init];
        [self pushToNextVCWithNextVC:mingxi];
    }else if (sender.tag == 1) {//提现
        TixianNewViewController *mingxi = [[TixianNewViewController alloc] init];
        [self pushToNextVCWithNextVC:mingxi];
    }else {//银行卡
		ChoeseCarIDViewController *xuan = [[ChoeseCarIDViewController alloc] init];
		[self pushToNextVCWithNextVC:xuan];
    }
}



@end
