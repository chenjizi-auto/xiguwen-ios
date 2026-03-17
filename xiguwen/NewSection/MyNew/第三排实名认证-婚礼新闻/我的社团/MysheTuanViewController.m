//
//  MysheTuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MysheTuanViewController.h"
#import "JoinSheTuanViewController.h"
#import "MakeSheTuanViewController.h"
@interface MysheTuanViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation MysheTuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的社团";
    [self addPopBackBtn];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 52.0;
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
		// 判断是否是商家VIP
		if ([UserDataNew sharedManager].userInfoModel.user.usertype != 3 && [UserDataNew sharedManager].userInfoModel.user.isshopvip == 1) {
			MakeSheTuanViewController *make = [[MakeSheTuanViewController alloc] init];
			[self pushToNextVCWithNextVC:make];
		} else {
			[NavigateManager showMessage:@"您现在还不是商家VIP哦"];
		}
	
    }else {
        JoinSheTuanViewController *make = [[JoinSheTuanViewController alloc] init];
        [self pushToNextVCWithNextVC:make];
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
