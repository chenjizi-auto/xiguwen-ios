//
//  SCtuikuanDetilViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SCtuikuanDetilViewController.h"
#import "XieshangLishiViewController.h"
#import "MyAlertView.h"
#import "ShangchengModelTui.h"
#import "JuJueTuikuanViewController.h"
@interface SCtuikuanDetilViewController ()
@property (nonatomic,strong) ShangchengModelTui *model;
@end

@implementation SCtuikuanDetilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款详情";
    [self addPopBackBtn];
    [kCountDownManager start];
    [self getdata];
}
- (IBAction)allaction:(UIButton *)sender {
    if (self.model) {
        if (sender.tag == 0) {
            //xieshang
            
            XieshangLishiViewController *xieshang = [[XieshangLishiViewController alloc] init];
            xieshang.id = self.model.refundinfo.fund_id;
            xieshang.type = 4;
            [self pushToNextVCWithNextVC:xieshang];
        }else if (sender.tag == 1) {
            //im
            NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.orderinfo.buyer_id] type:NIMSessionTypeP2P];
            NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            //dian
            if (self.model.orderinfo) {
                NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.model.orderinfo.mobile];
                CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
                if (version >= 10.0) {
                    /// 大于等于10.0系统使用此openURL方法
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
                }
            }
        }
    }
}
- (IBAction)two:(UIButton *)sender {
    if (sender.tag == 0) {//1
        if (self.model.refundinfo.refund_status == 1 || self.model.refundinfo.refund_status == 5) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认同意退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self tongyi];;
                                  }
                              }];
        }else {//8
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认确定收货？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self sureshouhuo];;
                                  }
                              }];
        }
        
        
    }else {//2
        if (self.model.refundinfo.refund_status == 1 || self.model.refundinfo.refund_status == 5) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认拒绝退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      JuJueTuikuanViewController *vc = [[JuJueTuikuanViewController alloc] init];
                                      vc.id = self.model.refundinfo.fund_id;
                                      vc.type = self.model.orderinfo.status == 60 ? 1 : 2;
                                      [self pushToNextVCWithNextVC:vc];
                                  }
                              }];
        }else {//8
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认拒绝收货？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self jujueshouhuo];
                                  }
                              }];
        }
        
    }
}

//确认收货
- (void)sureshouhuo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.model.refundinfo.fund_id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/fahuoquerenshouhuo"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已确认收货"];
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
//拒绝收货
- (void)jujueshouhuo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.model.refundinfo.fund_id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/fahuojujueshou"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已拒绝收货"];
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
//同意退款
- (void)tongyi{
    NSString *url;
    if (self.model.orderinfo.status == 60) {
        
        url = [HOMEURL stringByAppendingString:@"appapi/orders/tongyituikuan"];
    }else {
        url = [HOMEURL stringByAppendingString:@"appapi/orders/tongyituihuikuan"];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.model.refundinfo.fund_id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:url
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已同意退款"];
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
- (void)getdata{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.id) forKey:@"rec_id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/spyhtuikuan"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.model = [ShangchengModelTui mj_objectWithKeyValues:response[@"data"]];
                                               [self setModel];
                                           }
                                           [NavigateManager hiddenLoadingMessage];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
}

- (void)setModel{
    
    //订单状态 1 2 3 4 5 6 7 8 9 10
    if (self.model.refundinfo.refund_status == 1) {
        self.titleState.text = @"买家提交退货申请";
        self.timeShengyu.text = @"";
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
    }else if (self.model.refundinfo.refund_status == 2) {
        self.titleState.text = @"退款成功";
        self.timeShengyu.text = @"";
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
    }else if (self.model.refundinfo.refund_status == 3) {
        self.titleState.text = @"拒绝退款";
        self.timeShengyu.text = @"";
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
    }else if (self.model.refundinfo.refund_status == 4) {
        
    }else if (self.model.refundinfo.refund_status == 5) {
        self.titleState.text = @"买家提交退货申请";
        self.timeShengyu.text = @"";
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
    }else if (self.model.refundinfo.refund_status == 6) {
        self.titleState.text = @"等待买家发货";
        self.timeShengyu.text = @"";
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
    }else if (self.model.refundinfo.refund_status == 7) {
        
    }else if (self.model.refundinfo.refund_status == 8) {
        self.titleState.text = @"买家已发货";
        self.timeShengyu.text = @"";
        [self.btn1 setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"拒绝收货" forState:UIControlStateNormal];
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
    }else if (self.model.refundinfo.refund_status == 9) {
        self.titleState.text = @"退款成功";
        self.timeShengyu.text = @"";
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
    }else {
        self.titleState.text = @"拒绝退款";
        self.timeShengyu.text = @"";
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
    }
    
    [self.goodsImage sd_setImageWithUrl:self.model.goodsinfo.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = self.model.goodsinfo.goods_name;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.goodsinfo.price];

    self.number.text = [NSString stringWithFormat:@"x %ld",self.model.goodsinfo.quantity];

    self.bianhao.text = [NSString stringWithFormat:@"订单编号：%@",self.model.orderinfo.order_sn];
    
    self.shenqintime.text = [NSString stringWithFormat:@"申请时间：%@",self.model.refundinfo.created_at];
    self.shifuJine.text = [NSString stringWithFormat:@"支付金额：%@",self.model.orderinfo.order_amount];
    self.shenqinNumber.text = [NSString stringWithFormat:@"申请件数：%ld",self.model.goodsinfo.quantity];
    self.yuanyin.text = [NSString stringWithFormat:@"退款原因：%@",self.model.refundinfo.tuikuan_yuanyin];
    
    
}
@end
