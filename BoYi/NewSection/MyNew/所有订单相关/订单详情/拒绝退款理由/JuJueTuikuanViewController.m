//
//  JuJueTuikuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "JuJueTuikuanViewController.h"

@interface JuJueTuikuanViewController ()

@end

@implementation JuJueTuikuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写拒绝理由";
    [self addRightBtnWithTitle:@"提交" image:nil];
    [self addPopBackBtn];
    self.liyou.placeholder = @"请输入拒绝理由…";
    self.liyou.delegate = self;
    self.liyou.inputAccessoryView = [self addToolbar];
}
- (void)respondsToRightBtn {
    if (self.liyou.text.length == 0) {
        [NavigateManager showMessage:@"理由不能为空"];
    }else {
        if (self.type == 1) {//尽退款
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@(self.id) forKey:@"fundid"];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:self.liyou.text forKey:@"text"];
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/tongyituikuan"]
                                                method:POST
                                                loding:@""
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager showMessage:@"已拒绝退款"];
                                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                           
                                                           [self popViewControllerAtLastIndex:2];
                                                       });
                                                   }else {
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   [NavigateManager showMessage:@"请检查网络"];
                                                   
                                               }];
        }else if (self.type == 2) {//退款退货
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            [dic setValue:@(self.id) forKey:@"fundid"];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:self.liyou.text forKey:@"text"];
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/tongyituihuikuan"]
                                                method:POST
                                                loding:@""
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager showMessage:@"已拒绝退款"];
                                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                           
                                                           [self popViewControllerAtLastIndex:2];
                                                       });
                                                   }else {
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   [NavigateManager showMessage:@"请检查网络"];
                                                   
                                               }];
        }else {//婚庆
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@(self.id) forKey:@"id"];
            [dic setValue:self.liyou.text forKey:@"text"];
            
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/shangjiajujueapp"]
                                                method:POST
                                                loding:@"正在提交。。。"
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager hiddenLoadingMessage];
                                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                           [self popViewControllerAtLastIndex:2];
                                                       });
                                                       
                                                   }else {
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   [NavigateManager showMessage:@"请检查网络"];
                                                   
                                               }];
        }
        
        
    }
    
}


@end
