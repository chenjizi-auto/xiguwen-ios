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
#import "ZLHTTPSessionManager.h"

@interface SetNewViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation SetNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self addPopBackBtn];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 50.0;
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
- (IBAction)closeUserAction:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注销喜顾问账号"
                                   message:@"账号注销后不可恢复，请您谨慎操作。注销成功后，您将无法登录或使用原账号，账号内的信息和权益将无法找回。"
                                   preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    
    defaultAction = [UIAlertAction actionWithTitle:@"已清楚，确定注销" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self closeUserRequest];
    }];
     
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/// 注销账号
- (void)closeUserRequest {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    dictM[@"status"] = @(2);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/cancel/index" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            [UserDataNew signOutNoAlert];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"账号已注销成功"];
            });
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败"];
    }];
}

@end
