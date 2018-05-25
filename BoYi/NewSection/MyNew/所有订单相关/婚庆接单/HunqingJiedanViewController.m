//
//  HunqingJiedanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqingJiedanViewController.h"
#import "HunqingJiedanViewModel.h"
#import "HunqingJiedanModel.h"
#import "HunQinOrderModel.h"
#import "ChangeJiageViewController.h"
#import "MyAlertView.h"
#import "ShopWanchengView.h"
#import "TuikuanDetilJiedanViewController.h"
#import "OrderDetilNewJDViewController.h"
#import "JuJueTuikuanViewController.h"
@interface HunqingJiedanViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunqingJiedanViewModel *viewModel;

@end

@implementation HunqingJiedanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [kCountDownManager start];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.table.mj_header beginRefreshing];
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Hunqinordernew *x) {
        @strongify(self);
        if (self.statusFlag == 100) {
            TuikuanDetilJiedanViewController *vc = [[TuikuanDetilJiedanViewController alloc] init];
            vc.id = x.order_id;
            [self pushToNextVCWithNextVC:vc];
        }else {
            OrderDetilNewJDViewController *vc= [[OrderDetilNewJDViewController alloc] init];
            vc.id = x.order_id;
            [self pushToNextVCWithNextVC:vc];
        }
        
    }];
    //右btn所有
    [self.viewModel.firstSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Hunqinordernew *model = x;
        //订单状态 10：待支付 20：已关闭 60：待接单 70：待服务 79：已服务 ：80：待评价 90 交易完成 100 代服务 tuikuan  // 10 60 70 100
        if (model.status == 10) {
            ChangeJiageViewController *shou = [[ChangeJiageViewController alloc] init];
            shou.id = model.order_id;
            shou.model = model;
            [self pushToNextVCWithNextVC:shou];
        }else if (model.status == 60) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否接此订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self jie:[NSString stringWithFormat:@"%ld",model.order_id]];
                                  }
                              }];
            
        }else if (model.status == 70) {
            if (model.paytype == 1) {
                [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                                message:@"是否完成此订单？"
                                   left:@"取消"
                                  right:@"确定"
                                  block:^(NSInteger index) {
                                      if (index == 1) {
                                          NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                                          [dic setValue:@(model.order_id) forKey:@"id"];
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
                [ShopWanchengView showInView:[UIApplication sharedApplication].keyWindow orderid:[NSString stringWithFormat:@"%ld",model.order_id] block:^(NSMutableDictionary *dic) {
                    [NavigateManager showMessage:@"已确认订单"];
                    [weakSelf.table.mj_header beginRefreshing];
                }];
            }
        }else { //100
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否确认同意退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self tongyi:[NSString stringWithFormat:@"%ld",model.order_id]];;
                                  }
                              }];
        }
        
    }];
    //左btn
    [self.viewModel.secondSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Hunqinordernew *model = x;
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价
        if (model.status == 60) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否拒绝此订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      [self jujue:[NSString stringWithFormat:@"%ld",model.order_id]];
                                  }
                              }];
            
        }else { //100
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"是否拒绝退款？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
                                      JuJueTuikuanViewController *vc = [[JuJueTuikuanViewController alloc] init];
                                      vc.id = model.order_id;
                                      [self pushToNextVCWithNextVC:vc];
                                  }
                              }];
            
        }
        
    }];
}

#pragma mark - public api
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

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    [self.table registerNib:[UINib nibWithNibName:@"HunqingJiedanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunqingJiedanTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqingJiedanSamllTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunqingJiedanSamllTableViewCell"];

    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价 71 未付尾款 100：退款
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"status":@(self.statusFlag),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//            
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
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
                                               [self.table.mj_header beginRefreshing];
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
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/jujuejiedan"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已拒绝订单"];
                                               [self.table.mj_header beginRefreshing];
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}

//初始化viewModel
- (HunqingJiedanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunqingJiedanViewModel alloc] init];
    }
    return _viewModel;
}
- (void)dealloc{
    [kCountDownManager invalidate];
}

@end
