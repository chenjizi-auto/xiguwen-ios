//
//  OrderDetilNewSCViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilNewSCViewController.h"
#import "ShangchengOderDetilHeder.h"
#import "OrderDetilcollectiontableViewCell.h"
#import "OrderDetilModelSC.h"
#import "SetPingjiaViewController.h"
#import "ShenqingTuiQianViewController.h"
#import "ShouyinTaiViewController.h"
#import "MyAlertView.h"
#import "TuikuanDetilViewController.h"
#import "LookWuliuViewController.h"
#import "ShangchengTuikuanViewController.h"
#import "ShouHuodizhiViewController.h"
#import "SCtuikuanDetilUserViewController.h"
#import "ShangChengTuikuanTwoViewController.h"

@interface OrderDetilNewSCViewController ()
@property (nonatomic,strong)OrderDetilModelSC *model;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ShangchengOderDetilHeder *headerwu;
@end

@implementation OrderDetilNewSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [kCountDownManager start];
    [self addPopBackBtn];
    [self setHeaderView];
    [self getdata];
}

- (void)viewWillAppear:(BOOL)animated{
    [self getdata];
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
        if (self.model.data.status == 70 || self.model.data.status == 80) { //查看物流
            LookWuliuViewController *look = [[LookWuliuViewController alloc] init];
            if (self.model.data.goods.count > 0) {
                look.id = self.model.data.order_id;
                look.imageurl = self.model.data.goods[0].goods_image;
            }
            [self pushToNextVCWithNextVC:look];
        }
    }else {//you
  
        //订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
        if (self.model.data.status == 10) {
            //立即支付
            ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
            shou.type = 2;
            shou.bianhao = [NSString stringWithFormat:@"%ld",self.model.data.order_id];
            shou.price = self.model.data.order_amount;
            [self pushToNextVCWithNextVC:shou];
        }else if (self.model.data.status == 20) {//取消
            //无
        }else if (self.model.data.status == 60) {//已支付
            //无
        }else if (self.model.data.status == 70) {//已发货
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
            detil.isHunQin = NO;
            detil.id = self.model.data.order_id;
            [self pushToNextVCWithNextVC:detil];
        }else { //90 已评价
            LookWuliuViewController *look = [[LookWuliuViewController alloc] init];
            if (self.model.data.goods.count > 0) {
                look.id = self.model.data.order_id;
                look.imageurl = self.model.data.goods[0].goods_image;
            }
            [self pushToNextVCWithNextVC:look];
        }
    }
}
//取消订单
- (void)cancle:(NSString *)dingID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:dingID forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/cancelorder"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               [NavigateManager showMessage:@"已取消订单"];
                                               [self.table.mj_header beginRefreshing];
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
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Orders/sureorder"]
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
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/getorderbyid"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.model = [OrderDetilModelSC mj_objectWithKeyValues:response];
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
    
    ShangchengOderDetilHeder *header = (ShangchengOderDetilHeder *)self.table.tableHeaderView;
    if (self.model) {
        header.model = self.model;
        if (self.model.data.status == 10) {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = NO;
            [self.rightBtn setTitle:@"立即付款" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        }else if (self.model.data.status == 20) {
            self.dibuHeight.constant = 0;
            self.rightBtn.hidden = YES;
            self.leftBtn.hidden = YES;
        }else if (self.model.data.status == 60) {
            self.rightBtn.hidden = YES;
            self.leftBtn.hidden = YES;
            self.dibuHeight.constant = 0;
        }else if (self.model.data.status == 70) {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        }else if (self.model.data.status == 80) {

            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        }else { //90 已评价
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
             [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        }
    }
}
- (void)setHeaderView{
    [self.table registerNib:[UINib nibWithNibName:@"OrderDetilcollectiontableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OrderDetilcollectiontableViewCell"];
    
    self.table.delegate             = self;
    self.table.dataSource           = self;
}

#pragma mark -  tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.data.goods.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.youlike.count > 0 ? 1 : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index;
    index = self.model.youlike.count / 2 + self.model.youlike.count % 2;
    return 183 * index;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 630 + 155 * self.model.data.goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.table)
    {
        CGFloat sectionHeaderHeight = 630 + 155 * self.model.data.goods.count;
        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShangchengOderDetilHeder *header = [[NSBundle mainBundle]loadNibNamed:@"ShangchengOderDetilHeder" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 774 + 155 * self.model.data.goods.count);
    header.model = self.model;
    @weakify(self);
    [header.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        //evaluation    10退款 20同意退款 30 拒绝退款 60退货退款 70发货同意 80 发货后同意 90 发货后不同意
        
        GoodsSCDetil *model = x;
        if (model.status == 60) {//60
            if (model.evaluation == 0) {
                
                
                ShangChengTuikuanTwoViewController *tui = [[ShangChengTuikuanTwoViewController alloc] init];
                tui.typeStitc = model.status;
                tui.id = model.rec_id;
                [self pushToNextVCWithNextVC:tui];
            }else {
                SCtuikuanDetilUserViewController *vc = [[SCtuikuanDetilUserViewController alloc] init];
                vc.id = model.rec_id;
                [self pushToNextVCWithNextVC:vc];
            }
        }
        if (model.status == 70) {//70
            SCtuikuanDetilUserViewController *vc = [[SCtuikuanDetilUserViewController alloc] init];
            vc.id = model.rec_id;
            [self pushToNextVCWithNextVC:vc];
        }
        if (model.status == 80) {//80
            if (model.evaluation == 0) {
                ShangchengTuikuanViewController *vc = [[ShangchengTuikuanViewController alloc] init];
                vc.type = model.status;
                vc.model = model;
                [self pushToNextVCWithNextVC:vc];
            }else {
                SCtuikuanDetilUserViewController *vc = [[SCtuikuanDetilUserViewController alloc] init];
                vc.id = model.rec_id;
                [self pushToNextVCWithNextVC:vc];
            }
        }
        
    }];
    [[[header.addressBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        ShouHuodizhiViewController *dizhi = [[ShouHuodizhiViewController alloc] init];
        [self pushToNextVCWithNextVC:dizhi];
        
    }];
    [[[header.sixinBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.data.shop_id] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [[[header.IphoneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.model.data.shop_mobile];
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            /// 大于等于10.0系统使用此openURL方法
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }];
    return header;
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
    [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
        vc.shangpinID = [x intValue];
        [self pushToNextVCWithNextVC:vc];
        
    }];
    cell.modelsc = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)dealloc{
    [kCountDownManager invalidate];
}
@end
