//
//  SetNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SetNewViewController.h"
#import "ShouHuodizhiViewController.h"
#import "MyDataNewViewController.h"
#import "UserNumberNewViewController.h"
#import "ChooseSettingViewController.h"

@interface SetNewViewController ()

@end

@implementation SetNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self addPopBackBtn];
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//收货地址
        ShouHuodizhiViewController *shouhuo = [[ShouHuodizhiViewController alloc] init];
        [self pushToNextVCWithNextVC:shouhuo];
    }else if (sender.tag == 1) {//个人资料
        MyDataNewViewController *ziliao = [[MyDataNewViewController alloc] init];
        [self pushToNextVCWithNextVC:ziliao];
    }else if (sender.tag == 2) {//账号绑定
        UserNumberNewViewController *ziliao = [[UserNumberNewViewController alloc] init];
        [self pushToNextVCWithNextVC:ziliao];
        
    }else if (sender.tag == 3) {//安全设置
        ChooseSettingViewController *vc = [[ChooseSettingViewController alloc] init];
        [self pushToNextVCWithNextVC:vc];
    }else {//退出账号
        [UserDataNew signOut];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
