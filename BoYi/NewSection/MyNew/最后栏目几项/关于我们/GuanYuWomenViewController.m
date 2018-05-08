//
//  GuanYuWomenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanYuWomenViewController.h"
#import "UserXieyiViewController.h"
#import "UserPrivacyPolicyViewController.h"
@interface GuanYuWomenViewController ()

@end

@implementation GuanYuWomenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于博艺婚嫁";
    [self addPopBackBtn];
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//协议
        UserXieyiViewController *user = [[UserXieyiViewController alloc]init];
        [self pushToNextVCWithNextVC:user];
        
    }else {//政策
		UserPrivacyPolicyViewController *vc = [[UserPrivacyPolicyViewController alloc] init];
		[self pushToNextVCWithNextVC:vc];
    }
}


@end
