//
//  WritewuliuViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "WritewuliuViewController.h"

@interface WritewuliuViewController ()

@end

@implementation WritewuliuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写物流信息";
    [self addRightBtnWithTitle:@"提交" image:nil];
    [self addPopBackBtn];
    self.bianhao.delegate = self;
    self.bianhao.inputAccessoryView = [self addToolbar];
    self.bianma.delegate = self;
    self.bianma.inputAccessoryView = [self addToolbar];
}

- (void)respondsToRightBtn {
    if (self.bianma.text.length == 0) {
        [NavigateManager showMessage:@"快递编码不能为空"];
        return;
    }
    if (self.bianhao.text.length == 0) {
        [NavigateManager showMessage:@"快递编号不能为空"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.bianhao.text forKey:@"kuaidinum"];
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:self.bianma.text forKey:@"kuaidicode"];

    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Orders/fahuo"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已提交物流信息"];
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   [self popViewConDelay];
                                               });
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}

@end
