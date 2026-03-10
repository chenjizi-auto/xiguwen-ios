//
//  OrderDetilNewJDViewController.m
//  BoYi
//
//  Created by heng on 2018/4/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilNewJDViewController.h"
#import "OrderDetilModelNew.h"
#import "MyAlertView.h"
#import "TuikuanDetilViewController.h"
#import "ChangeJiageViewController.h"
#import "MyAlertView.h"
#import "ShopWanchengView.h"
#import "TuikuanDetilJiedanViewController.h"
#import "HunQinOrderModel.h"
#import "JuJueTuikuanViewController.h"
@interface OrderDetilNewJDViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation OrderDetilNewJDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [kCountDownManager start];
    [self getdata];
    [self addPopBackBtn];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}
- (void)handleTimer {
    if (self.model.data.fukuantime == 0) {
        [self.timer invalidate];
        [self getdata];
        
    } else {
        NSInteger  countDown = self.model.data.fukuantime;
        
        self.timeshengyunumber = [NSString stringWithFormat:@"还剩余%02zd小时%02zd分%02zd秒", countDown/3600, (countDown/60)%60, countDown%60];
        
    }
    self.model.data.fukuantime --;
}

- (IBAction)allaction:(UIButton *)sender {
    if (sender.tag == 0) {//im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.data.user_im] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {//拨打
        if (self.model) {
            if (self.model.data.mobile) {
                NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.model.data.mobile];
                CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
                if (version >= 10.0) {
                    /// 大于等于10.0系统使用此openURL方法
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
                }
            }
        }
    }else if (sender.tag == 2) {//left
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价
        if (self.model.data.status == 60) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否拒绝此订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self jujue:[NSString stringWithFormat:@"%ld",self.model.data.order_id]];
                                  }
                              }];
            
        }else {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否拒绝退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      JuJueTuikuanViewController *vc = [[JuJueTuikuanViewController alloc] init];
                                      vc.id = self.model.data.order_id;
                                      [self pushToNextVCWithNextVC:vc];
                                  }
                              }];
        }
    }else {
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价
        if (self.model.data.status == 10) {
            ChangeJiageViewController *shou = [[ChangeJiageViewController alloc] init];
            shou.id = self.model.data.order_id;
            Hunqinordernew *model = [Hunqinordernew new];
            model.baojia_image = self.model.data.baojia_image;
            model.baojia_name = self.model.data.baojia_name;
            model.specification = self.model.data.specification;
            model.baojia_price = self.model.data.baojia_price;
            model.yuandingjin = self.model.data.yuandingjin;
            model.quantity = self.model.data.quantity;
            model.paytype = self.model.data.paytype;
            model.order_id = self.model.data.order_id;
            
            shou.model = model;
            [self pushToNextVCWithNextVC:shou];
        }else if (self.model.data.status == 60) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否接此订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self jie:[NSString stringWithFormat:@"%ld",self.model.data.order_id]];
                                  }
                              }];
            
        }else if (self.model.data.status == 70) {
            if (self.model.data.paytype == 1) {
                [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                                message:@"是否完成此订单？"
                                   left:@"取消"
                                  right:@"确定"
                                  block:^(NSInteger index) {
                                      if (index == 1) {
                                          NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                                          [dic setValue:@(self.model.data.order_id) forKey:@"id"];
                                          [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                                          [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                                          
                                          [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/paypartfinishorder"]
                                                                              method:POST
                                                                              loding:@""
                                                                                 dic:dic
                                                                            progress:nil
                                                                             success:^(NSURLSessionDataTask *task, id response) {
                                                                                 if ([response[@"code"] integerValue] == 0) {
                                                                                     [NavigateManager showMessage:@"已确认订单"];
                                                                                     
                                                                                 }else {
                                                                                     [NavigateManager showMessage:response[@"message"]];
                                                                                 }
                                                                                 
                                                                             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                 [NavigateManager showMessage:@"请检查网络"];
                                                                                 
                                                                             }];
                                      }
                                  }];
            }else {
                __weak typeof(self) weakSelf = self;
                [ShopWanchengView showInView:[UIApplication sharedApplication].keyWindow orderid:[NSString stringWithFormat:@"%ld",weakSelf.model.data.order_id] block:^(NSMutableDictionary *dic) {
                    [NavigateManager showMessage:@"已确认订单"];
                    
                }];
            }
            

        }else { //100
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认同意退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self tongyi:[NSString stringWithFormat:@"%ld",self.model.data.order_id]];;
                                  }
                              }];
        }
    }
    
}
//同意退款
- (void)tongyi:(NSString *)oderid{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:oderid forKey:@"id"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/shangjiatongyi"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已同意退款"];
                                               
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}

//接单
- (void)jie:(NSString *)dingID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:dingID forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/jiedan"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已接订单"];
                                               
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}
//拒绝单
- (void)jujue:(NSString *)dingID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:dingID forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/myhome/jujuejiedan"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已拒绝订单"];
                                             
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
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/details"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.model = [OrderDetilModelNew mj_objectWithKeyValues:response];
                                               [self configDataForHeaderSentCode];
                                            
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
}
- (void)configDataForHeaderSentCode{
    if (self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }
    [self setModel];
}
- (void)setModel{
    OrderDetilModelNew *model = self.model;

    ///订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
    
    if (model.data.status == 10) {
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"修改价格" forState:UIControlStateNormal];
        self.titleState.text = @"待支付";
        self.timeShengyu.text = @"";
    }else if (model.data.status == 20) {
        
        self.titleState.text = @"交易关闭";
        self.rightBtn.hidden = YES;
        self.leftBtn.hidden = YES;
        
        self.timeShengyu.text = @"";
    }else if (model.data.status == 60) {
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"立即发货" forState:UIControlStateNormal];
        self.titleState.text = @"待发货";
        self.timeShengyu.text = model.data.specification;

    }else if (model.data.status == 70) {
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"完成订单" forState:UIControlStateNormal];
        self.titleState.text = @"待服务";
        self.timeShengyu.text = @"";

    }else if (model.data.status == 71 || model.data.status == 79) {
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = YES;
        self.titleState.text = @"商家已服务";
        self.timeShengyu.text = @"";
    }else if (model.data.status == 80) {
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        
        self.titleState.text = @"交易成功";
        self.timeShengyu.text = @"";

    }else { //90
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        
        self.titleState.text = @"交易成功";
        self.timeShengyu.text = @"";

    }
    self.shangjianame.text = model.data.snickname;
    
    [self.goodsImage sd_setImageWithUrl:model.data.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.data.baojia_name;
    self.time.text = model.data.specification;
    
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.data.price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.data.yuandingjin];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.data.quantity];
    if (model.data.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (model.data.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    self.zongjia.text = [NSString stringWithFormat:@"¥ %@",model.data.shangpingjongjia];
    self.dikou.text = [NSString stringWithFormat:@"¥ %@",model.data.dikouzongge];
    self.dingjin.text = [NSString stringWithFormat:@"¥ %@",model.data.dindanzongge];
    self.fanxiandikou.text = [NSString stringWithFormat:@"%@",model.data.fanjifen];
    
    self.yinfuzonge.text = [NSString stringWithFormat:@"¥ %@",model.data.yingfuzonge];
    self.yinfujine.text = [NSString stringWithFormat:@"¥ %@",model.data.yingfujine];
    self.yifuzonge.text = [NSString stringWithFormat:@"¥ %@",model.data.yifuzonge];
    
    self.bianhao.text = [NSString stringWithFormat:@"订单编号：%@",model.data.order_sn];
    self.xiadantime.text = [NSString stringWithFormat:@"下单时间：%@",model.data.published];
    self.chucifukuantime.text = [NSString stringWithFormat:@"初次付款时间：%@",model.data.pay_time];
    self.weikuantime.text = [NSString stringWithFormat:@"尾款付款时间：%@",model.data.wkpay_time];
    self.wanchengtime.text = [NSString stringWithFormat:@"完成时间：%@",model.data.sureok_time];
    self.remarkLabel.text = [NSString stringWithFormat:@"%@",model.data.remark];
    
}
- (void)dealloc{
    [kCountDownManager invalidate];
}
@end
