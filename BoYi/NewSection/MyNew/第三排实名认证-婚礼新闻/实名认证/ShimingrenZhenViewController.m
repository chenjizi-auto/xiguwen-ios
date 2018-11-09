//
//  ShimingrenZhenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShimingrenZhenViewController.h"
#import "QiyeRenzhenViewController.h"
#import "GerenRenzhengViewController.h"
@interface ShimingrenZhenViewController ()
@property (weak, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation ShimingrenZhenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实名认证";
    [self addPopBackBtn];
	
	if ([UserDataNew sharedManager].userInfoModel.user.usertype == 3) {
		[self.emptyView setHidden: YES];
	} else {
		[self.emptyView setHidden: NO];
	}
	
	
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        GerenRenzhengViewController *geren = [[GerenRenzhengViewController alloc] init];
        [self pushToNextVCWithNextVC:geren];
    }else {
        QiyeRenzhenViewController *geren = [[QiyeRenzhenViewController alloc] init];
        [self pushToNextVCWithNextVC:geren];
        
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
