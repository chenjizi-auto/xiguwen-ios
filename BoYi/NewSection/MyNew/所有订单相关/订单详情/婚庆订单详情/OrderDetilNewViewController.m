//
//  OrderDetilNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilNewViewController.h"
#import "OrderDetilNewHeader.h"
#import "OrderDetilcollectiontableViewCell.h"
#import "OrderDetilModelNew.h"
#import "SetPingjiaViewController.h"
#import "ShenqingTuiQianViewController.h"
#import "ShouyinTaiViewController.h"
#import "MyAlertView.h"
#import "TuikuanDetilViewController.h"

@interface OrderDetilNewViewController ()
@property (nonatomic,strong)OrderDetilModelNew *model;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) OrderDetilNewHeader *headerwu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dibuHeight;

@end

@implementation OrderDetilNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [kCountDownManager start];
    [self getdata];
    [self addPopBackBtn];
    [self setHeaderView];
}
- (void)handleTimer {
    if (self.model.data.fukuantime == 0) {
        [self.timer invalidate];
        [self getdata];
        
    } else {
        NSInteger  countDown = self.model.data.fukuantime;

        self.headerwu.timeshengyunumber = [NSString stringWithFormat:@"还剩余%02zd小时%02zd分%02zd秒", countDown/3600, (countDown/60)%60, countDown%60];
   
    }
    self.model.data.fukuantime --;
}
- (IBAction)action:(IB_DESIGN_Button *)sender {
    if (sender.tag == 0) {//左
        if (self.model.data.status == 10) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"确定取消订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self cancle:[NSString stringWithFormat:@"%ld",self.model.data.order_id]];
                                  }
                              }];
            
        }
    }else {//you
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 71：已服务（未付尾款） 79：已服务 ：80：待评价（交易成功） 90 已评价
        if (self.model.data.status == 10) {
            
            
            //立即支付
            ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
            shou.type = 2;
            shou.bianhao = [NSString stringWithFormat:@"%ld",self.model.data.order_id];
            float price;
            price = [self.model.data.baojia_price floatValue] * self.model.data.quantity;
            shou.price = [NSString stringWithFormat:@"%.2f",price];
            [self pushToNextVCWithNextVC:shou];
        }else if (self.model.data.status == 70) {
            if (self.model.data.tuihuo == 1) {
                ShenqingTuiQianViewController *detil = [[ShenqingTuiQianViewController alloc] init];
                Hunqinordernew *model = [[Hunqinordernew alloc] init];
                model.order_amount = self.model.data.order_amount;
                model.baojia_image = self.model.data.baojia_image;
                model.baojia_name = self.model.data.baojia_name;
                model.specification = self.model.data.specification;
                model.baojia_price = self.model.data.baojia_price;
                model.quantity = self.model.data.quantity;
                model.paytype = self.model.data.paytype;
                model.order_id = self.model.data.order_id;

                detil.model = model;
                [self pushToNextVCWithNextVC:detil];
            }else if (self.model.data.tuihuo == 2 || self.model.data.tuihuo == 3){
                TuikuanDetilViewController *detil = [[TuikuanDetilViewController alloc] init];
                detil.id = self.model.data.order_id;
                [self pushToNextVCWithNextVC:detil];
            }else {
                ShenqingTuiQianViewController *detil = [[ShenqingTuiQianViewController alloc] init];
                Hunqinordernew *model = [[Hunqinordernew alloc] init];
                model.order_amount = self.model.data.order_amount;
                model.baojia_image = self.model.data.baojia_image;
                model.baojia_name = self.model.data.baojia_name;
                model.specification = self.model.data.specification;
                model.baojia_price = self.model.data.baojia_price;
                model.quantity = self.model.data.quantity;
                model.paytype = self.model.data.paytype;
                model.order_id = self.model.data.order_id;
                
                detil.model = model;
                [self pushToNextVCWithNextVC:detil];
            }
            
        }else if (self.model.data.status == 71) {//
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认支付尾款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      //支付尾款
                                      ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
                                      shou.type = 7;
                                      shou.bianhao = [NSString stringWithFormat:@"%ld",self.model.data.order_id];
                                      float price;
                                      price = [self.model.data.baojia_price floatValue] * self.model.data.quantity;
                                      shou.price = [NSString stringWithFormat:@"%.2f",price];
                                      [self pushToNextVCWithNextVC:shou];
                                  }
                              }];
        }else if (self.model.data.status == 79) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self sure:[NSString stringWithFormat:@"%ld",self.model.data.order_id]];
                                  }
                              }];
        }else if (self.model.data.status == 80) {
            SetPingjiaViewController *detil = [[SetPingjiaViewController alloc] init];
            detil.isHunQin = YES;
            detil.id = self.model.data.order_id;
            [self pushToNextVCWithNextVC:detil];
        }else { //90 已评价
            
        }
    }
}
- (void)cancle:(NSString *)dingID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:dingID forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/cancelorder"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已取消订单"];
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}
//确认完成订单
- (void)sure:(NSString *)dingID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:dingID forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/sureok"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已确认订单"];
                                               [self.table.mj_header beginRefreshing];
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
                                               [self.table reloadData];
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

    OrderDetilNewHeader *header = (OrderDetilNewHeader *)self.table.tableHeaderView;
    if (self.model) {
        header.model = self.model;
        if (self.model.data.status == 10) {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = NO;
            self.dibuHeight.constant = 49;
            [self.rightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        }else if (self.model.data.status == 20) {
            self.rightBtn.hidden = YES;
            self.leftBtn.hidden = YES;
        }else if (self.model.data.status == 60) {
            self.rightBtn.hidden = YES;
            self.leftBtn.hidden = YES;
        }else if (self.model.data.status == 70) {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            self.dibuHeight.constant = 49;
            if (self.model.data.tuihuo == 1) {
                [self.rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            }else if (self.model.data.tuihuo == 2){
            
                [self.rightBtn setTitle:@"退款详情" forState:UIControlStateNormal];
            }else if (self.model.data.tuihuo == 3){
                
                [self.rightBtn setTitle:@"退款详情" forState:UIControlStateNormal];
            }else {
                
                [self.rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            }
        }else if (self.model.data.status == 71) {
            self.dibuHeight.constant = 49;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
           [self.rightBtn setTitle:@"支付尾款" forState:UIControlStateNormal];
        }else if (self.model.data.status == 79) {
            self.dibuHeight.constant = 49;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"确认完成" forState:UIControlStateNormal];
        }else if (self.model.data.status == 80) {
            self.dibuHeight.constant = 49;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        }else { //90
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = YES;
        }
    }
}
- (void)setHeaderView{
    [self.table registerNib:[UINib nibWithNibName:@"OrderDetilcollectiontableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OrderDetilcollectiontableViewCell"];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self;
    self.table.dataSource           = self;
    
    OrderDetilNewHeader *header = [[NSBundle mainBundle]loadNibNamed:@"OrderDetilNewHeader" owner:nil options:nil].firstObject;
    @weakify(self);
    [header.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x integerValue] == 0) {
            //im
            NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.data.user_im] type:NIMSessionTypeP2P];
            NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
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
    }];
    
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 888 - 95 - 47);
    self.table.tableHeaderView = header;
    self.headerwu = header;
}

#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.youlike.count > 0 ? 1 : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index;
    index = self.model.youlike.count / 2 + self.model.youlike.count % 2;
    return 183 * index;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetilcollectiontableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetilcollectiontableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OrderDetilcollectiontableViewCell" owner:nil options:nil].firstObject;
    }
    @weakify(self);
    [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
        vc.baojiaid = [x intValue];
        [self pushToNextVCWithNextVC:vc];
    }];
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}
- (void)dealloc{
    [kCountDownManager invalidate];
}
@end
