//
//  TuikuanDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuikuanDetilViewController.h"
#import "tuikuanDetilhqModel.h"
#import "XieshangLishiViewController.h"
#import "MyAlertView.h"
@interface TuikuanDetilViewController ()
@property (nonatomic,strong)tuikuanDetilhqModel *model;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TuikuanDetilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款详情";
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    [self addPopBackBtn];
    [self getZhuangtai];
}
- (IBAction)actionall:(UIButton *)sender {
    if (sender.tag == 0) {
        XieshangLishiViewController *xieshang = [[XieshangLishiViewController alloc] init];
        xieshang.isHunqin = YES;
        xieshang.type = 1;
        xieshang.id = self.model.tuikuan.fund_id;
        [self pushToNextVCWithNextVC:xieshang];
    }else if (sender.tag == 1) {
        
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.tuikuan.user_id] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 2) {
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
    }else {
        
        
            
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否撤销退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [NavigateManager showLoadingMessage:@""];
                                      [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/yonghuchexiao"]
                                                                          method:POST
                                                                          loding:nil
                                                                             dic:@{@"id":@(self.model.tuikuan.fund_id)}
                                                                        progress:nil
                                                                         success:^(NSURLSessionDataTask *task, id response) {
                                                                             if ([response[@"code"] integerValue] == 0) {
//                                                                                 [self getZhuangtai];
                                                                                 
                                                                                 [NavigateManager showMessage:@"撤销成功"];
                                                                                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                     [self popViewConDelay];
                                                                                 });
                                                                                 
                                                                             }else {
                                                                                 [NavigateManager showMessage:response[@"message"]];
                                                                             }
                                                                             
                                                                         } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                             [NavigateManager hiddenLoadingMessage];
                                                                         }];
                                  }
                              }];
    }
}

- (void)getZhuangtai{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/yonghutuikuan"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.model = [tuikuanDetilhqModel mj_objectWithKeyValues:response[@"data"]];
                                               [self fuzhi:self.model];
                                           }
                                           [NavigateManager hiddenLoadingMessage];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {

                                       }];
}
- (void)handleTimer {
    if (self.model.tuikuan.shenyushijian == 0) {
        [self.timer invalidate];
        [self getZhuangtai];
        
    } else {
        NSInteger  countDown = self.model.tuikuan.shenyushijian;
        self.timeShengyu.text = [NSString stringWithFormat:@"还剩余%02zd小时%02zd分%02zd秒", countDown/3600, (countDown/60)%60, countDown%60];
    }
    self.model.tuikuan.shenyushijian --;
}

- (void)fuzhi:(tuikuanDetilhqModel *)model{

    if (self.model.tuikuan.status == 1) {
        self.isYinCangView.hidden = YES;
        self.isYinCangTitle.hidden = YES;
        self.isYinCangContent.hidden = YES;
        self.isYinCangHeight.constant = 0.0001;
        self.actionBtn.hidden = NO;
        self.scrollHegit.constant = 602;
    }else {
        self.isYinCangView.hidden = NO;
        self.isYinCangTitle.hidden = NO;
        self.isYinCangContent.hidden = NO;
        self.isYinCangHeight.constant = 50;
        self.scrollHegit.constant = 612;
        self.actionBtn.hidden = YES;
    }
    //退款状态1买家提交处理中，2同意退款，3不同意退款，4撤销退款

    if (self.model.tuikuan.status == 1) {
        self.titleState.text = @"等待卖家处理";

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        
    }else if (self.model.tuikuan.status == 2) {
        self.titleState.text = @"卖家同意退款";

        self.timeShengyu.text = self.model.tuikuan.created_at;
    }else if (self.model.tuikuan.status == 3) {
        self.titleState.text = @"卖家拒绝退款";

        self.timeShengyu.text = self.model.tuikuan.created_at;
    }else {
        self.titleState.text = @"用户撤销退款";
        self.timeShengyu.text = self.model.tuikuan.created_at;
    }
    
    [self.goodsImage sd_setImageWithUrl:self.model.orderinfo.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = self.model.orderinfo.baojia_name;
    self.time.text = self.model.orderinfo.specification;
    
    self.isYinCangContent.text = [NSString stringWithFormat:@"¥%@",self.model.tuikuan.tui_amount];
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.orderinfo.baojia_price];
    
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",self.model.orderinfo.order_amount];
    
    self.number.text = [NSString stringWithFormat:@"x %ld",self.model.orderinfo.quantity];

    if (self.model.orderinfo.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (self.model.orderinfo.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    
    self.bianhao.text = [NSString stringWithFormat:@"退款编号：%ld",self.model.tuikuan.fund_id];
    self.shenqintime.text = [NSString stringWithFormat:@"退款申请时间：%@",self.model.tuikuan.created_at];
    self.fukuanjine.text = [NSString stringWithFormat:@"实付金额：¥%@",self.model.tuikuan.tui_amount];
    self.shenqinNumber.text =[NSString stringWithFormat:@"申请件数：%ld",self.model.orderinfo.quantity];
    self.tuikuanYuanyin.text = [NSString stringWithFormat:@"退款原因：%@",self.model.tuikuan.tui_yuanyin];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.timer = nil;
}
@end
