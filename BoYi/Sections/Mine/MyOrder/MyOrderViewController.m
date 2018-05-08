//
//  MyOrderViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderViewModel.h"
#import "OrderDetailViewController.h"
#import "OrderAlertView.h"
#import "RebackOrderView.h"
#import "OrderEvaluateView.h"
#import "WeChatPayManager.h"
#import "ApayOrYL.h"

@interface MyOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyOrderViewModel *viewModel;
@property (assign,nonatomic) NSInteger curPage;
@property (strong,nonatomic) NSString *payType;

@end

@implementation MyOrderViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.title = @"";
    self.curPage = 1;
    [self addPopBackBtn];
    
    [self setupTableView];
    [self cellClick];
    [self.table.mj_header beginRefreshing];
    
    @weakify(self);
    [self.viewModel.orderPayCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     
        @strongify(self);
        [WeChatPayManager payWithType:[self.payType integerValue] info:x vc:self block:nil];
    }];
    
    //付款成功
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:ALIPAY_PAY_RESULT_NOTIFACATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if ([x.object integerValue] == 9000) {
            [NavigateManager showMessage:@"付款成功"];
            [self.table.mj_header beginRefreshing];
        }
        
    }];
    
}

#pragma mark - 点击事件

- (void)cellClick {
    
    //点击事件
    //订单状态 -1：待审核 1：待接单 2：商家已接单 3：订单取消 4：申请退款 5：商家完成订单 6：用户确认完成订单 7：同意退款 8：拒绝退款 9.已评价
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(MyOrderModel *x) {
        
        @strongify(self);
        
        if (x.payStatus == -1) {
            
            @weakify(self);
            [ApayOrYL showInView:[UIApplication sharedApplication].keyWindow block:^(NSDictionary *dic) {
                @strongify(self);
                //付款
                self.payType = dic[@"type"];
                [self.viewModel.orderPayCommand execute:@{@"orderId":@(x.id),
                                                          @"userId":@([UserData sharedManager].userInfoModel.id),
                                                          @"payType":@2,
                                                          @"payFor":[dic[@"type"] integerValue] == 1 ? @"app" : @"bank"}];
                
            }];
            
            
        } else {
            
            //已付款
            
            switch (x.status) {
                case -1: {
                    //付款
                }
                    break;
                    
                case 1: {
                    __weak typeof(self) weakSelf = self;
                    //申请退款
                    [RebackOrderView showInView:self.view
                                            top:nil
                                         bottom:nil block:^(NSString *string) {
                                             [weakSelf.viewModel.submitRefundCommand execute:@{@"descn":string,
                                                                                               @"orderId":@(x.id)}];
                                         }];
    
                }
                    break;
                case 2: {
                    __weak typeof(self) weakSelf = self;
                    //申请退款
                    [RebackOrderView showInView:self.view
                                            top:nil
                                         bottom:nil block:^(NSString *string) {
                                             [weakSelf.viewModel.submitRefundCommand execute:@{@"descn":string,
                                                                                               @"orderId":@(x.id)}];
                                         }];
                }
                    break;
                case 3: {
                    __weak typeof(self) weakSelf = self;
                    //申请退款
                    [RebackOrderView showInView:self.view
                                            top:nil
                                         bottom:nil block:^(NSString *string) {
                                             [weakSelf.viewModel.submitRefundCommand execute:@{@"descn":string,
                                                                                               @"orderId":@(x.id)}];
                                         }];
                }
                    break;
                    
                case 5: {
                    __weak typeof(self) weakSelf = self;
                    //申请退款
                    [RebackOrderView showInView:self.view
                                            top:nil
                                         bottom:nil block:^(NSString *string) {
                                             [weakSelf.viewModel.submitRefundCommand execute:@{@"descn":string,
                                                                                               @"orderId":@(x.id)}];
                                         }];
                }
                    break;
                case 6:{
                    //完成确认  去评价
//                    [self updateOrderStatus:5 order:x];
                    __weak typeof(self) weakSelf = self;
                    [OrderEvaluateView showInView:self.view
                                           top:@""
                                        bottom:nil
                                         block:^(NSString *content, NSInteger index) {
                                             //完成
                                             [weakSelf.viewModel.submitOrderCommentCommand execute:@{@"descn":content,
                                                                                                     @"userStars":@(index),
                                                                                                     @"orderId":@(x.id)}];
                                         }];
                }
                    break;
                default: {
                    //查看详情
                    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
                    vc.orderId = x.id;
                    [self pushToNextVCWithNextVC:vc];
                }
                    break;
            }
        }
        
        
    }];
    
    //左边两个按钮的事件
    [self.viewModel.otherClickSubject subscribeNext:^(MyOrderModel *x) {
        @strongify(self);
        
        if (x.payStatus == -1) {
            //取消订单  未付款
            __weak typeof(self) weakSelf = self;
            [OrderAlertView showInView:self.view
                                   top:@"您真的要取消订单吗!"
                                bottom:nil
                                 block:^(NSInteger index) {
                                     //完成
                                     [weakSelf updateOrderStatus:3 order:x];
                                 }];
        } else {
            switch (x.status) {
                case 1: {
                    //取消订单
                    __weak typeof(self) weakSelf = self;
                    [OrderAlertView showInView:self.view
                                           top:@"您真的要取消订单吗!"
                                        bottom:nil
                                         block:^(NSInteger index) {
                                             //完成
                                             [weakSelf updateOrderStatus:3 order:x];
                                         }];
                }
                    break;
                case 2: {
                    //申请退款
                    __weak typeof(self) weakSelf = self;
                    [RebackOrderView showInView:self.view
                                            top:nil
                                         bottom:nil block:^(NSString *string) {
                                             [weakSelf.viewModel.submitRefundCommand execute:@{@"descn":string,
                                                                                               @"orderId":@(x.id)}];
                                         }];
    

                }
                    break;
                case 5: {
                    //订单完成
                    __weak typeof(self) weakSelf = self;
                    [OrderAlertView showInView:self.view
                                           top:@"如商家已为您提供相关服务，请点击[确定]完成订单!"
                                        bottom:nil
                                         block:^(NSInteger index) {
                                             
                                             //                                             if (x.payStatus == 2) {
                                             //完成
                                             [weakSelf updateOrderStatus:6 order:x];
                                             //                                             } else {
                                             //                                                 //付款
                                             //                                                 [self.viewModel.orderPayCommand execute:@{@"orderId":@(x.id),
                                             //                                                                                           @"userId":@([UserData sharedManager].userInfoModel.id),
                                             //                                                                                           @"payType":@2}];
                                             //                                             }
                                             
                                         }];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
    }];
    
    
    
    //状态
    [self.viewModel.updateOrderStateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"操作成功"];
        [self.table.mj_header beginRefreshing];
    }];
    //评价
    [self.viewModel.submitOrderCommentCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"评论成功"];
        [self.table.mj_header beginRefreshing];
    }];
    //退款
    [self.viewModel.submitRefundCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"操作成功"];
        [self.table.mj_header beginRefreshing];
    }];
}

#pragma mark - public api


#pragma mark - private api

/**
 订单操作
 
 @param status 更改的状态
 */
- (void)updateOrderStatus:(NSInteger)status order:(MyOrderModel *)order {
    [self.viewModel.updateOrderStateCommand execute:@{@"userFlag":@2,
                                                      @"status":@(status),
                                                      @"orderId":@(order.id),
                                                      @"userId":@([UserData sharedManager].userInfoModel.id)}];
}

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShopOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShopOrderTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ShopOrderTableViewHeader" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShopOrderTableViewHeader"];
    [self.table registerNib:[UINib nibWithNibName:@"ShopOrderTableViewFooter" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShopOrderTableViewFooter"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
        self.curPage = 1;
        
        if (self.statusFlag != 0) {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@1,
                                                         @"pageSize":@10,
                                                         @"statusFlag":@(self.statusFlag),
                                                         @"userFlag":@2}];
        } else {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@1,
                                                         @"pageSize":@10,
                                                         @"userFlag":@2}];
        }
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x[@"rows"] isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    
                    self.curPage ++;
                    
                    if (self.statusFlag != 0) {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                                     @"curPage":@(self.curPage),
                                                                     @"pageSize":@10,
                                                                     @"statusFlag":@(self.statusFlag),
                                                                     @"userFlag":@2}];
                    } else {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                                     @"curPage":@(self.curPage),
                                                                     @"pageSize":@10,
                                                                     @"userFlag":@2}];
                    }
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理异常状态
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        } else if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
}

//初始化viewModel
- (MyOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyOrderViewModel alloc] init];
    }
    return _viewModel;
}


@end
