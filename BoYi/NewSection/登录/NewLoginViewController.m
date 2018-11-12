//
//  NewLoginViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewLoginViewController.h"
#import "UserZhuCeViewController.h"
#import "XuanZeTypeViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "NewForGetPassViewController.h"
#import "ChangepassWordNewViewController.h"
#import "AppDelegate.h"

#import "JPUSHService.h"

@interface NewLoginViewController ()<UITextFieldDelegate>

@end

@implementation NewLoginViewController
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

    self.userName.delegate = self;
    self.passWord.delegate = self;
//    [self.userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.userName setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    [self.passWord setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.passWord setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
;
    self.userName.inputAccessoryView = [self addToolbar];
    self.passWord.inputAccessoryView = [self addToolbar];


}
- (IBAction)allAction:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else if (sender.tag == 1) {
        //登录
        [self login];
    }else if (sender.tag == 2) {
        //忘记密码
        ChangepassWordNewViewController *vc = [[ChangepassWordNewViewController alloc] init];
        vc.ifForgetPw = YES;
        [self pushToNextVCWithNextVC:vc];
    }else if (sender.tag == 3) {
        //微信
        [self loginthree];
    }else if (sender.tag == 4) {
        //用户注册
        UserZhuCeViewController *user = [[UserZhuCeViewController alloc] init];
        user.tpye = 3;
        [self pushToNextVCWithNextVC:user];
    }else {
        //商家注册
        XuanZeTypeViewController *vc = [[XuanZeTypeViewController alloc] init];
        [self pushToNextVCWithNextVC:vc];
        
    }
}

- (void)loginthree{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            //生产极光推送的唯一标识码
            NSString *singleIdentifier = [[NSString stringWithFormat:@"%@%d%d%d%d%d%d%d%d%d%d",[NSUUID UUID].UUIDString,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255,arc4random()%255] md5String];
            
            NSDictionary *dic = @{@"head":resp.iconurl,@"nickname":resp.name,@"sex":resp.unionGender,@"thirdSystemId":resp.openid,@"type":@" 3",@"identification":singleIdentifier};
            
            [[RequestManager sharedManager] requestUrl:URL_New_registerThree
                                                method:POST
                                                loding:@""
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager showMessage:@"登录成功"];
                                                     
                                                       //注册别名
                                                       NSString *phone = singleIdentifier;
                                                       if (phone) {
                                                           [JPUSHService setAlias:phone completion:nil seq:0];
                                                       }
                                                       
                                                       [UserDataNew WriteUserInfo:response[@"data"]];
                                                       
                                                       [[CwChatManager sharedManager] FirstLoginWithInfo:response[@"data"]];
                                                       
                                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                           
                                                           if (self.isShenqingshangjia) {
                                                               AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                                               [app ConfirmRootViewController];
                                                           }else {
                                                               [self popViewConDelay];
                                                           }
                                                        
                                                           
                                                       });
                                                       
                                                   }else if ([response[@"code"] integerValue] == 908) {
                                                       [NavigateManager hiddenLoadingMessage];
                                                       
                                                       UserZhuCeViewController *user = [[UserZhuCeViewController alloc] init];
                                                       user.tpye = 4;
                                                       user.userid = [NSString stringWithFormat:@"%@",response[@"data"][@"token"][@"userid"]];
                                                       user.token = [NSString stringWithFormat:@"%@",response[@"data"][@"token"][@"token"]];
                                                       [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
                                                           
                                                       }];
                                                     
//                                                       [self pushToNextVCWithNextVC:user];
                                                       [self presentViewController:user animated:YES completion:nil];
                                                      
                                                       
                                                   }else{
                                                       
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   
                                                   [NavigateManager showMessage:@"登录失败"];
                                                   
                                               }];
            
        }
    }];
}
- (void)login{

    if (self.userName.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写用户名或手机号"];
        return;
    }
    if (self.passWord.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写密码"];
        return;
    }

    __weak typeof(self)weakSelf = self;
    
    NSDictionary *dic = @{@"password":self.passWord.text,@"mobile":self.userName.text,@"type":@"0",@"thirdSystemId":@""};
    [[RequestManager sharedManager] requestUrl:URL_New_login
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"登录成功"];
                                               
                                               //注册别名
                                               [JPUSHService setAlias:weakSelf.userName.text completion:nil seq:0];
                                               
                                               [UserDataNew WriteUserInfo:response[@"data"]];
                                               
                                               [[CwChatManager sharedManager] FirstLoginWithInfo:response[@"data"]];
                                               
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   
  
                                                   if (self.isShenqingshangjia) {
                                                       AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                                       [app ConfirmRootViewController];
                                                   }else {
                                                       [self popViewConDelay];
                                                   }
                                               });
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"登录失败"];
                                           
                                       }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}

@end
