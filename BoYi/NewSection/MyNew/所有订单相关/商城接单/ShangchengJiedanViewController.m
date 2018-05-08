//
//  ShangchengJiedanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengJiedanViewController.h"
#import "ShangchengJiedanViewModel.h"
#import "ShangchengJiedanModel.h"
#import "OrderDetilNewJDViewController.h"
#import "OrderDetilNewSCViewController.h"
#import "SCchangeJIageViewController.h"
#import "MyAlertView.h"
#import "WritewuliuViewController.h"
#import "LookWuliuViewController.h"
#import "JuJueTuikuanViewController.h"
#import "ShangchengOderDetilJDViewController.h"
@interface ShangchengJiedanViewController (){
    NSInteger p;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShangchengJiedanViewModel *viewModel;

@end

@implementation ShangchengJiedanViewController


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

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(DataShangcheng *x) {
        @strongify(self);
        ShangchengOderDetilJDViewController *vc = [[ShangchengOderDetilJDViewController alloc] init];
        vc.id = x.order_id;
        [self pushToNextVCWithNextVC:vc];
        
    }];
    //右btn所有
    [self.viewModel.firstSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        DataShangcheng *model = x;
        //订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
        if (model.status == 10) {
            
            SCchangeJIageViewController *shou = [[SCchangeJIageViewController alloc] init];
            shou.id = model.order_id;
            shou.model = model;
            [self pushToNextVCWithNextVC:shou];
        }else if (model.status == 60) {//
            //发货
            WritewuliuViewController *Write = [[WritewuliuViewController alloc] init];
            Write.id = model.order_id;
            [self pushToNextVCWithNextVC:Write];
        }else if (model.status == 70 || model.status == 80 || model.status == 90) {//已发货
            LookWuliuViewController *look = [[LookWuliuViewController alloc] init];
            look.id = model.order_id;
            if (model.goods.count > 0) {
                look.imageurl = model.goods[0].goods_image;
            }
            [self pushToNextVCWithNextVC:look];
            
        }else if (model.status == 100) {
            //
//            JuJueTuikuanViewController *vc = []
        }
        
    }];
    //左btn
    [self.viewModel.secondSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        DataShangcheng *model = x;
        //订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
        if (model.status == 100) {
            [MyAlertView showInView:[UIApplication sharedApplication].keyWindow
                            message:@"确定取消订单？"
                               left:@"取消"
                              right:@"确定"
                              block:^(NSInteger index) {
                                  if (index == 1) {
//                                      [self cancle:[NSString stringWithFormat:@"%ld",model.order_id]];
                                  }
                              }];
            
        }
    }];
}
#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShangchengJiedanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangchengJiedanTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        p = 1;
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"status":@(self.statusFlag),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"p":@(p),@"rows":@"10"}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                p ++;
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{@"status":@(self.statusFlag),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"p":@(p),@"rows":@"10"}];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        NSMutableArray *array = x[@"data"];
        if (array.count < 10) {

            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {

            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];

        }
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

//初始化viewModel
- (ShangchengJiedanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShangchengJiedanViewModel alloc] init];
    }
    return _viewModel;
}


@end
