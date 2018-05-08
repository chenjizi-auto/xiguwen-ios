//
//  ChaDangViewController.m
//  BoYi
//
//  Created by heng on 2018/2/8.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChaDangViewController.h"
#import "ChaDangViewModel.h"
#import "AnlieListModel.h"
#import "NewShangjiaViewController.h"
@interface ChaDangViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ChaDangViewModel *viewModel;
@property(nonatomic,assign)NSInteger curPage;
@end

@implementation ChaDangViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Shangjiatuanduilist *x) {
        @strongify(self);
        NewShangjiaViewController *newshangjia = [[NewShangjiaViewController alloc] init];
        newshangjia.shopid = x.userid;
        [self pushToNextVCWithNextVC:newshangjia];
    }];
    
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"AnlieListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnlieListTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        _curPage = 1;
        NSString *day = [[NSUserDefaults standardUserDefaults] objectForKey:@"chadangtimeDay"];
        NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"chadangtimeshangxiawu"];
        
        if ([UserDataNew UserLoginState]) {
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
         
                [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time,@"cityid":[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]]}];
            }else {
                [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time}];
            }
            
            
        }else {
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
        
                [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time,@"cityid":[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]]}];
            }else {
                [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time}];
            }
        
        }
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
                _curPage ++;
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    NSString *day = [[NSUserDefaults standardUserDefaults] objectForKey:@"chadangtimeDay"];
                    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"chadangtimeshangxiawu"];
                    
                    if ([UserDataNew UserLoginState]) {
                        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                            
                            [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time,@"cityid":[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]]}];
                        }else {
                            [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time}];
                        }
                        
                        
                    }else {
                        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                            
                            [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time,@"cityid":[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]]}];
                        }else {
                            [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"date":day,@"occupationid":@(self.id),@"timeslot":time}];
                        }
                        
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
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (ChaDangViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChaDangViewModel alloc] init];
    }
    return _viewModel;
}


@end
