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
@property (weak, nonatomic) IBOutlet UILabel *banben;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation GuanYuWomenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于喜顾问";
    [self addPopBackBtn];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.banben.text = [NSString stringWithFormat:@"v%@",appCurVersion];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//协议
        UserXieyiViewController *user = [[UserXieyiViewController alloc]init];
        user.isXieyi = YES;
        [self pushToNextVCWithNextVC:user];
        
    }else {//政策
        UserXieyiViewController *user = [[UserXieyiViewController alloc]init];
        user.isXieyi = NO;
        [self pushToNextVCWithNextVC:user];
    }
}


@end
