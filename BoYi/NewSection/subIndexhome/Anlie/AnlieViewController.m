//
//  AnlieViewController.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieViewController.h"
#import "AnlieViewModel.h"
#import "AnlieModel.h"
#import "AnlieNewDetilViewController.h"
#import "AnlieListSearchViewController.h"
@interface AnlieViewController (){
    NSInteger type,p;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) AnlieViewModel *viewModel;

@end

@implementation AnlieViewController

- (void)viewWillAppear:(BOOL)animated{
    
    if ([[UserData UserDefaults:@"isRefreshing5"] isEqualToString:@"yes"]) {
        [self.table.mj_header beginRefreshing];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    type = 1;
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Anliindexesarray *x) {
        @strongify(self);
        AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
        vc.anlieID = x.id;
        [self pushToNextVCWithNextVC:vc];
    }];
    [self.viewModel.typeItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        AnlieListSearchViewController *search = [[AnlieListSearchViewController alloc] init];
        NSInteger type = [x integerValue];
        search.types = type;
        [self pushToNextVCWithNextVC:search];
        
 
    }];
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.dataArray[self.viewModel.index].afollow = 1;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
    }];
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.dataArray[self.viewModel.index].afollow = 0;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
    }];
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HotContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HotContentTableViewCell"];
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
        p = 1;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@(p) forKey:@"p"];
        [dic setValue:@(type) forKey:@"type"];
        if ([UserDataNew sharedManager].userInfoModel.token.token) {
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                
                [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
            }
            
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [self.viewModel.refreshDataCommand execute:dic];
        }else {
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                
                [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
            }
            
            [self.viewModel.refreshDataCommand execute:dic];
        }
        [UserData UserDefaults:@"no" key:@"isRefreshing5"];
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            p ++;
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:@(p) forKey:@"p"];
                    [dic setValue:@(type) forKey:@"type"];
                    if ([UserDataNew sharedManager].userInfoModel.token.token) {
                        
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [self.viewModel.refreshDataCommand execute:dic];
                    }else {
                        [self.viewModel.refreshDataCommand execute:dic];
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
- (AnlieViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnlieViewModel alloc] init];
    }
    return _viewModel;
}


@end
