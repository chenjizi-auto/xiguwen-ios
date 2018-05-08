//
//  MyBanksViewController.m
//  BoYi
//
//  Created by Chen on 2017/9/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyBanksViewController.h"
#import "MyBanksViewModel.h"
#import "AddCardViewController.h"

@interface MyBanksViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyBanksViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *NoBankView;

@end

@implementation MyBanksViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.isChoose ? @"选择银行卡" : @"我的银行卡";
    [self addPopBackBtn];
    if (!self.isChoose) {
        [self addRightBtnWithTitle:@"新建" image:nil];
    }
    
    [self setupTableView];
    [self cellClick];
    //传入参数 进行刷新
    [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id)}];
}


#pragma mark - 点击事件
- (void)respondsToRightBtn {
    [self bindCard:nil];
}

- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.isChoose) {
            
//            @weakify(self);
//            [self.chooseBankSubject subscribeNext:^(id  _Nullable x) {
//                @strongify(self);
                [self.chooseBankSubject sendNext:x];
                [self popViewConDelay];
//            }];
            
        } else {
        AddCardViewController *vc = [[AddCardViewController alloc] init];
        vc.model = x;
        @weakify(self);
        [vc.refreshSubject subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id)}];
        }];
        [self pushToNextVCWithNextVC:vc];
        }
    }];
}

/**
 绑定银行卡
 */
- (IBAction)bindCard:(id)sender {
    AddCardViewController *vc = [[AddCardViewController alloc] init];
    @weakify(self);
    [vc.refreshSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id)}];
    }];
    [self pushToNextVCWithNextVC:vc];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyBanksTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyBanksTableViewCell"];
    //[self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
//
//    //下拉刷新
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        @strongify(self);
//        //传入参数 进行刷新
//        [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id)}];
//    }];
//    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {

        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
        [self.table reloadData];
        self.NoBankView.hidden = self.viewModel.dataArray.count != 0;
        
        //self.table.mj_header.isRefreshing];
//
//        //正在下啦
//        if (self.table.mj_header.isRefreshing) {
//            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id)}];
//                }];
//            }
//            [self.table.mj_header endRefreshing];
//        }
//        
//        //判断，如果item < size 显示已获取完成
//        if (self.viewModel.dataArray.count < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//            
//        }
//        //    [self.tableView reloadEmptyDataSet];
//        //刷新视图
//        [self.table reloadData];
//        
    }];
}

//初始化viewModel
- (MyBanksViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyBanksViewModel alloc] init];
    }
    return _viewModel;
}

- (RACSubject *)chooseBankSubject {
    if (!_chooseBankSubject) {
        _chooseBankSubject = [RACSubject subject];
    }
    return _chooseBankSubject;
}
@end
