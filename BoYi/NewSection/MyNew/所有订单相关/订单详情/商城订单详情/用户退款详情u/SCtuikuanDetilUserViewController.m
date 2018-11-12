//
//  SCtuikuanDetilUserViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SCtuikuanDetilUserViewController.h"
#import "XieshangLishiViewController.h"
#import "MyAlertView.h"
#import "ShangchengModelTui.h"
@interface SCtuikuanDetilUserViewController ()
@property (nonatomic,strong) ShangchengModelTui *model;
@end

@implementation SCtuikuanDetilUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款详情";
    [self addPopBackBtn];
    [kCountDownManager start];
    [self getdata];
}
- (IBAction)all:(UIButton *)sender {
    if (sender.tag == 0) {
        //xieshang
        XieshangLishiViewController *xieshang = [[XieshangLishiViewController alloc] init];
        xieshang.id = self.model.refundinfo.fund_id;
        xieshang.type = 3;
        [self pushToNextVCWithNextVC:xieshang];
    }else if (sender.tag == 1) {
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.orderinfo.seller_id] type:NIMSessionTypeP2P];
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

- (IBAction)chexiao:(UIButton *)sender {

    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.model.refundinfo.fund_id) forKey:@"fundid"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/clearrefundsh"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已撤销退款"];
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
    
    //退款状态1买家提交处理中（退款）2同意退款（未发货，直接完成），3不同意退款（未发货，直接拒绝），4撤销退款5买家提交处理中（退款退货）6同意退款（发货，等待买家发货），8买家发货 9卖家确认收获（退款完成） 10卖家拒绝收货（退款拒绝）
    if (self.model.refundinfo.refund_status == 1) {
        
        self.titleState.text = @"退款处理中";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 2) {
        self.btn1.hidden = YES;
        self.titleState.text = @"卖家同意退款";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 3) {
        self.btn1.hidden = YES;
        self.titleState.text = @"卖家不同意退款";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 4) {
        self.btn1.hidden = YES;
        self.titleState.text = @"买家撤销退款";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 5) {
        self.btn1.hidden = YES;
        self.titleState.text = @"退款退货处理中";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 6) {
        self.btn1.hidden = YES;
        self.titleState.text = @"卖家同意退款";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 8) {
        self.btn1.hidden = YES;
        self.titleState.text = @"买家发货中";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 9) {
        self.btn1.hidden = YES;
        self.titleState.text = @"退款完成";
        self.timeShengyu.text = @"";
    }else if (self.model.refundinfo.refund_status == 10) {
        self.btn1.hidden = YES;
        self.titleState.text = @"卖家拒绝收货";
        self.timeShengyu.text = @"";
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
