//
//  TuikuanDetilJiedanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuikuanDetilJiedanViewController.h"
#import "tuikuanDetilhqModel.h"
#import "XieshangLishiViewController.h"
#import "JuJueTuikuanViewController.h"
#import "MyAlertView.h"
@interface TuikuanDetilJiedanViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,strong)tuikuanDetilhqModel *model;

@end

@implementation TuikuanDetilJiedanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款详情";
    [self addPopBackBtn];
    [kCountDownManager start];
    [self getdata];
}


- (IBAction)allaction:(UIButton *)sender {
    if (sender.tag == 0) {
        //xieshang
        XieshangLishiViewController *xieshang = [[XieshangLishiViewController alloc] init];
        xieshang.isHunqin = YES;
        xieshang.type = 2;
        xieshang.id = self.model.tuikuan.fund_id;
        [self pushToNextVCWithNextVC:xieshang];
    }else if (sender.tag == 1) {
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.tuikuan.user_id] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //dian
        if (self.model.orderinfo.mobile) {
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
- (IBAction)two:(UIButton *)sender {
    if (sender.tag == 0) {
        [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                        message:@"是否确认同意退款？"
                           left:@"取消"
                          right:@"确定"
                          block:^(NSInteger index) {
                              if (index == 1) {
                                  [self tongyi];;
                              }
                          }];
        
    }else {
        JuJueTuikuanViewController *vc = [[JuJueTuikuanViewController alloc] init];
        vc.id = self.model.tuikuan.fund_id;
        [self pushToNextVCWithNextVC:vc];
    }
}

//同意退款
- (void)tongyi{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.model.tuikuan.fund_id) forKey:@"id"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/shangjiatongyi"]
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
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/shangjiatuikuanchuli"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.model = [tuikuanDetilhqModel mj_objectWithKeyValues:response[@"data"]];
                                               [self setModel];
                                           }
                                           [NavigateManager hiddenLoadingMessage];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
}

- (void)setModel{
    
    //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价 71 未付尾款
    if (self.model.orderinfo.tuihuo == 1) {
        self.titleState.text = @"用户已提交退款申请";
        self.tuikuanzhuangtai.text = self.titleState.text;
        self.timeShengyu.text = @"";
        self.btn1.superview.hidden = NO;
    }else if (self.model.orderinfo.tuihuo == 2){
        self.titleState.text = @"退款处理中";
        self.tuikuanzhuangtai.text = self.titleState.text;
        self.timeShengyu.text = @"";
        self.btn1.superview.hidden = NO;
    }else {
        self.titleState.text = @"退款处理完成";
        self.tuikuanzhuangtai.text = self.titleState.text;
        self.timeShengyu.text = @"";
        self.btn1.superview.hidden = YES;
    }
    
    [self.goodsImage sd_setImageWithUrl:self.model.orderinfo.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = self.model.orderinfo.baojia_name;
    self.time.text = self.model.orderinfo.specification;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.orderinfo.goods_amount];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",self.model.orderinfo.baojia_price];
    
    self.number.text = [NSString stringWithFormat:@"x %ld",self.model.orderinfo.quantity];
    if (self.model.orderinfo.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (self.model.orderinfo.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    self.bianhao.text = [NSString stringWithFormat:@"订单编号：%@",self.model.orderinfo.order_sn];
    
    self.shenqintime.text = [NSString stringWithFormat:@"申请时间：%@",self.model.tuikuan.created_at];
    self.shifuJine.text = [NSString stringWithFormat:@"支付金额：%@",self.model.orderinfo.order_amount];
    self.shenqinNumber.text = [NSString stringWithFormat:@"申请件数：%ld",self.model.orderinfo.quantity];
    self.yuanyin.text = [NSString stringWithFormat:@"退款原因：%@",self.model.tuikuan.tui_yuanyin];

    
}

@end
