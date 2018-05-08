//
//  CHengweishangjiaViewController.m
//  BoYi
//
//  Created by heng on 2018/5/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CHengweishangjiaViewController.h"

@interface CHengweishangjiaViewController ()
@property (nonatomic,strong)UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIButton *ben;
@end

@implementation CHengweishangjiaViewController

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
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
        
    }else {
        //下一步
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:@(self.tpye) forKey:@"type"];
        
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/member/chengweishangjia"]
                                            method:POST
                                            loding:nil
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"恭喜您成为商家"];
                                                   
                                                   [UserDataNew ClearUserDefaults:@"user_dic"];
                                                   [[CwChatManager sharedManager] signOut];
                                                   [UserDataNew sharedManager].userInfoModel = nil;
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       NewLoginViewController *vc = [[NewLoginViewController alloc] init];
                                                       vc.isShenqingshangjia = YES;
                                                       vc.hidesBottomBarWhenPushed = YES;
                                                       [self pushToNextVCWithNextVC:vc];
                                                       
                                                      
                                                   });
                                                   
                                               }else{
                                                   
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
//                                               [NavigateManager showMessage:@"注册失败"];
                                               
                                           }];
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
