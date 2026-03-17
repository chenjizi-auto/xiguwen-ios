//
//  SurePayViewController.m
//  BoYi
//
//  Created by apple on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "SurePayViewController.h"
#import "WeChatPayManager.h"
#import "ApayOrYL.h"
#import "MyOrderSubViewController.h"

@interface SurePayViewController (){
    NSString *_payStatus;
}
@property (nonatomic, strong) UIButton *btnMark;//
@end

@implementation SurePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认支付";
    
    [self addPopBackBtn];
    
    self.dingjin.text = String(@"¥ ",self.dic[@"dingjin"]);
    self.quankuan.text = String(@"¥ ",self.dic[@"quankuan"]);
    self.hejiJine.text = String(@"¥ ",self.dic[@"quankuan"]);
    self.quankuanBtn.selected = YES;
    self.btnMark = self.quankuanBtn;
    _payStatus = @"2";
    
    @weakify(self);
    //先删除掉
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALIPAY_PAY_RESULT_NOTIFACATION object:nil];
    //接收通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:ALIPAY_PAY_RESULT_NOTIFACATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if ([x.object integerValue] != 9000) {
            //接收到消息处理
            [self popViewConDelay];
        }else {
            MyOrderSubViewController *myoder = [[MyOrderSubViewController alloc] init];
        
            [self pushToNextVCWithNextVC:myoder];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dingJOrQuankuanAC:(UIButton *)sender {
    
    //时间
    self.btnMark.selected = NO;
    sender.selected = YES;
    self.btnMark = sender;
    
    if (sender.tag == 10) {
        _payStatus = @"1";
        self.hejiJine.text = self.dingjin.text;
    }else {
        _payStatus = @"2";
        self.hejiJine.text = self.quankuan.text;
    }
    
}
- (IBAction)jiesuanAC:(UIButton *)sender {
    
    [ApayOrYL showInView:[UIApplication sharedApplication].keyWindow block:^(NSDictionary *dic) {
        NSString *payFor;
        if ([dic[@"type"] intValue] == 1) {
            payFor = @"app";
        }else {
            payFor = @"bank";
        }
        NSMutableDictionary *dicm = [[NSMutableDictionary alloc] initWithDictionary:@{@"ids":self.dic[@"id"],@"userId":@([UserData sharedManager].userInfoModel.id),@"payStatus":_payStatus,@"payFor":payFor}];
        
        [[RequestManager sharedManager] requestUrl:URL_ZHIFU
                                            method:POST
                                            loding:@""
                                               dic:dicm
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"status"] integerValue] == 200) {
                                                   [NavigateManager hiddenLoadingMessage];
                                                   [WeChatPayManager payWithType:[dic[@"type"] intValue] info:response[@"r"] vc:self block:^(NSDictionary *response) {
                                                       
                                                   }];
                                               }else {
                                                  [NavigateManager showMessage:response[@"msg"] ? [[NSString stringWithFormat:@"%@",response[@"msg"]] replaceUnicode] : @"空空如也"];
                                               }
                                               
                                               
                                               
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                               [NavigateManager showMessage:@""];
                                               
                                           }];
        
    }];
    
    
    
    
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALIPAY_PAY_RESULT_NOTIFACATION object:nil];
}

@end
