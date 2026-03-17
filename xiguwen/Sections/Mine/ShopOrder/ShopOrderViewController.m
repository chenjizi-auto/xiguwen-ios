//
//  ShopOrderViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopOrderViewController.h"
#import "ShopOrderViewModel.h"
#import "OrderDetailViewController.h"
#import "OrderAlertView.h"

@interface ShopOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShopOrderViewModel *viewModel;
@property (assign,nonatomic) NSInteger curPage;

@end

@implementation ShopOrderViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单";
    [self addPopBackBtn];
    
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    
    [self cellClick];
}


#pragma mark - 点击事件

- (void)cellClick {
    
    //点击事件
    //订单状态 -1：待审核 1：待接单 2：商家已接单 3：订单取消 4：申请退款 5：商家完成订单 6：用户确认完成订单 7：同意退款 8：拒绝退款 9.已评价
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(MyOrderModel *x) {
     
        @strongify(self);
        if (x.payStatus == 1) {
            switch (x.status) {
                case 1:
                    //确认
                    [self updateOrderStatus:2 order:x];
                    break;
                case 2: {
                    __weak typeof(self) weakSelf = self;
                    [OrderAlertView showInView:self.view
                                           top:@"如有余款未收完,请自行告知客户线上或线下支付哦!"
                                        bottom:nil
                                         block:^(NSInteger index) {
                                             //完成
                                             [weakSelf updateOrderStatus:5 order:x];
                                         }];
                    
                }
                    break;
                case 6:
                    //完成确认
                    [self updateOrderStatus:5 order:x];
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
    [self.viewModel.otherClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //同意退款
        if ([x[@"isAgree"] integerValue] == 1) {
            [self updateOrderStatus:7 order:x[@"order"]];
        } else {
        //拒绝退款
            [self updateOrderStatus:8 order:x[@"order"]];
        }
    }];
    
    
    
    //状态
    [self.viewModel.updateOrderStateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       
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
    [self.viewModel.updateOrderStateCommand execute:@{@"userFlag":@1,
                                                      @"status":@(status),
                                                      @"orderId":@(order.id),
                                                      @"userId":@([UserData sharedManager].userInfoModel.id)}];
}



//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShopOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShopOrderTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ShopOrderTableViewHeader" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShopOrderTableViewHeader"];
    [self.table registerNib:[UINib nibWithNibName:@"ShopOrderTableViewFooter" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShopOrderTableViewFooter"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    
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
                                                         @"userFlag":@1}];
        } else {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                         @"curPage":@1,
                                                         @"pageSize":@10,
                                                         @"userFlag":@1}];
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
                                                                     @"userFlag":@1}];
                    } else {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                                     @"curPage":@(self.curPage),
                                                                     @"pageSize":@10,
                                                                     @"userFlag":@1}];
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
- (ShopOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShopOrderViewModel alloc] init];
    }
    return _viewModel;
}


@end
