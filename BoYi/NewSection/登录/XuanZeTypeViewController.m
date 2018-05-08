//
//  XuanZeTypeViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "XuanZeTypeViewController.h"
#import "UserZhuCeViewController.h"
@interface XuanZeTypeViewController ()
@property (nonatomic,strong)UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIButton *ben;

@end

@implementation XuanZeTypeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tpye = 2;
    self.ben.selected = YES;
    self.markBtn = self.ben;
    if (IS_IPHONE_5) {
        self.weight.constant = 15;
        self.weight1.constant = 15;
        self.weight2.constant = 15;
        self.weight3.constant = 40;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
        
    }else {
        //下一步
        UserZhuCeViewController *user = [[UserZhuCeViewController alloc] init];
        user.tpye = self.tpye;
        [self pushToNextVCWithNextVC:user];
    }
}
- (IBAction)seleac:(UIButton *)sender {
    self.markBtn.selected = NO;
    sender.selected = YES;
    self.markBtn = sender;
    if (sender.tag == 0) {//本地婚庆
        self.tpye = 2;
    }else {//婚品电商
        self.tpye = 1;
    }
    
}


@end
