//
//  UserNumberNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UserNumberNewViewController.h"
#import "BangdingIPhoneViewController.h"
@interface UserNumberNewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneBindStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation UserNumberNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号绑定";
    [self addPopBackBtn];
    
    if ([UserDataNew sharedManager].userInfoModel.user.mobile) {
        self.phoneBindStatus.text = @"已绑定";
    }
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 52.0;
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 1) {//手机号
        BangdingIPhoneViewController *iphone = [[BangdingIPhoneViewController alloc] init];
        [self pushToNextVCWithNextVC:iphone];
    }else {//微信
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
