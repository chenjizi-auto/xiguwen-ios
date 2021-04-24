//
//  HunQinOrderViewController.m
//  BoYi
//
//  Created by heng on 2018/1/13.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunQinOrderViewController.h"
#import "HunQinOrderViewModel.h"
#import "HunQinOrderModel.h"
#import "OrderDetilNewViewController.h"
#import "SetPingjiaViewController.h"
#import "ShenqingTuiQianViewController.h"
#import "ShouyinTaiViewController.h"
#import "MyAlertView.h"
#import "TuikuanDetilViewController.h"
#import "ZLPayPriceView.h"
#import "ZLHTTPSessionManager.h"

@interface HunQinOrderViewController (){
    NSInteger p;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunQinOrderViewModel *viewModel;

@end

@implementation HunQinOrderViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 启动倒计时管理
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [kCountDownManager start];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.table.mj_header beginRefreshing];
}
#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    //cell
    [self.viewModel.selectItemSubject subscribeNext:^(Hunqinordernew *x) {
        @strongify(self);
        OrderDetilNewViewController *detil = [[OrderDetilNewViewController alloc] init];
        detil.id = x.order_id;
        [self pushToNextVCWithNextVC:detil];
    }];
    //右btn所有、、、、、、、、
    [self.viewModel.firstSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Hunqinordernew *model = x;
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 71：已服务（未付尾款） 79：已服务 ：80：待评价（交易成功） 90 已评价
        if (model.status == 10) {
            //立即支付
            ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
            shou.type = 2;
            shou.bianhao = [NSString stringWithFormat:@"%ld",model.order_id];
            float price;
            price = [model.baojia_price floatValue] * model.quantity;
            shou.price = model.paytype == 2 ? model.order_amount : model.zongjine;
            [self pushToNextVCWithNextVC:shou];
        }else if (model.status == 60) { //
            [self payPrice:model];
        }else if (model.status == 70) { //
            if (model.payment_dis == 4) {
                if (model.tuihuo == 1) {
                    ShenqingTuiQianViewController *detil = [[ShenqingTuiQianViewController alloc] init];
                    detil.model = model;
                    [self pushToNextVCWithNextVC:detil];
                }else if (model.tuihuo == 2 || model.tuihuo == 3){
                    TuikuanDetilViewController *detil = [[TuikuanDetilViewController alloc] init];
                    detil.id = model.order_id;
                    [self pushToNextVCWithNextVC:detil];
                }else {
                    ShenqingTuiQianViewController *detil = [[ShenqingTuiQianViewController alloc] init];
                    detil.model = model;
                    [self pushToNextVCWithNextVC:detil];
                }
            }else {
                [self payPrice:model];
            }
        }else if (model.status == 71) {//
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认支付尾款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
                                      shou.type = 7;
                                      shou.bianhao = [NSString stringWithFormat:@"%ld",model.order_id];
                                      shou.price = model.order_lastamount;
                                      [self pushToNextVCWithNextVC:shou];
                                  }
                              }];
        }else if (model.status == 79) {
            NSString *message = nil;
            if (model.confirm_completion == 1) {
                message = @"请确认商家已提供服务，否则有可能钱货两失！";
            }else {
                message = @"该笔订单还有款项未支付，请先支付完成后再点击确认完成哦！";
            }
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:message
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      if (model.confirm_completion == 1) {
                                          [self sure:[NSString stringWithFormat:@"%ld",model.order_id]];
                                      }
                                  }
                              }];
        }else {//if (model.status == 80) //评价
            SetPingjiaViewController *detil = [[SetPingjiaViewController alloc] init];
            detil.isHunQin = YES;
            detil.id = model.order_id;
            [self pushToNextVCWithNextVC:detil];
        }
        
    }];
    //左btn
    [self.viewModel.secondSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Hunqinordernew *model = x;
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价
        if (model.status == 10) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"确定取消订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self cancle:[NSString stringWithFormat:@"%ld",model.order_id]];
                                  }
                              }];
            
        }else if (model.status == 70) { //
            if (model.tuihuo == 1) {
                ShenqingTuiQianViewController *detil = [[ShenqingTuiQianViewController alloc] init];
                detil.model = model;
                [self pushToNextVCWithNextVC:detil];
            }else if (model.tuihuo == 2 || model.tuihuo == 3){
                TuikuanDetilViewController *detil = [[TuikuanDetilViewController alloc] init];
                detil.id = model.order_id;
                [self pushToNextVCWithNextVC:detil];
            }else {
                ShenqingTuiQianViewController *detil = [[ShenqingTuiQianViewController alloc] init];
                detil.model = model;
                [self pushToNextVCWithNextVC:detil];
            }
        }else if (model.status == 79) {
            [self payPrice:model];
        }
    }];
}
//取消订单
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

- (void)payPrice:(Hunqinordernew *)model {
    ZLPayPriceView *payPriceView = [[UINib nibWithNibName:NSStringFromClass([ZLPayPriceView class]) bundle:NSBundle.mainBundle] instantiateWithOwner:nil options:nil].firstObject;
    payPriceView.frame = UIScreen.mainScreen.bounds;
    payPriceView.allowShow = model.status == 79;
    payPriceView.alertView.layer.cornerRadius = 5.0;
    payPriceView.alertView.layer.masksToBounds = YES;
    payPriceView.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.amount_balance];
    payPriceView.priceTf.text = [NSString stringWithFormat:@"%@",model.amount_balance];
    __weak typeof(self)weakSelf = self;
    __weak typeof(payPriceView)weakView = payPriceView;
    payPriceView.payAction = ^{
        if ([weakView.priceTf.text floatValue] > [model.amount_balance floatValue]) {
            [MBProgressHUD showMsg:@"支付金额不能超出剩余款项"];
            return;
        }
        [weakView removeFromSuperview];
        //立即支付
        ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
        shou.type = 7;
        shou.bianhao = [NSString stringWithFormat:@"%ld",model.order_id];
        shou.price = [NSString stringWithString:weakView.priceTf.text];
        [weakSelf pushToNextVCWithNextVC:shou];
    };
    
    payPriceView.offlinePay = ^{
        NSMutableDictionary *dictM = [NSMutableDictionary new];
        dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
        dictM[@"id"] = @(model.order_id);
        dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
        __weak typeof(self)weakSelf = self;
        [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/ordershq/paypartfinishorder_user" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
            if (!sessionErrorState) {
                if (![responseObject[@"code"] intValue]) {
                    [weakSelf.table.mj_header beginRefreshing];
                    return;
                }
                [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:responseObject[@"message"]];
                return;
            }
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败，请检查您的网络设置。"];
        }];
    };
    
    [UIApplication.sharedApplication.delegate.window addSubview:payPriceView];
}


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HunQinOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunQinOrderTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunQinOrderSmallTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunQinOrderSmallTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        p = 1;
        //传入参数 进行刷新
        NSMutableDictionary *dictM = [NSMutableDictionary new];
        dictM[@"status"] = @(self.statusFlag);
        dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
        dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
        dictM[@"p"] = @(p);
        dictM[@"rows"] = @"10";
        dictM[@"title"] = self.searchString;
        [self.viewModel.refreshDataCommand execute:dictM];
    }];
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    p ++;
                    //传入参数 进行刷新
                    NSMutableDictionary *dictM = [NSMutableDictionary new];
                    dictM[@"status"] = @(self.statusFlag);
                    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
                    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
                    dictM[@"p"] = @(p);
                    dictM[@"rows"] = @"10";
                    dictM[@"title"] = self.searchString;
                    [self.viewModel.refreshDataCommand execute:dictM];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        NSMutableArray *array = [[NSMutableArray alloc] init];
        array =  x[@"data"];
        if (array.count < 10) {

            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {

            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];

        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        [kCountDownManager reload];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}
//初始化viewModel

- (HunQinOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunQinOrderViewModel alloc] init];
    }
    return _viewModel;
}
- (void)dealloc{
    [kCountDownManager invalidate];
}
@end
