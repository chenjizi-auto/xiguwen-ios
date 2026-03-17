//
//  GuanzhuAnlieViewController.m
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanzhuAnlieViewController.h"
#import "GuanzhuAnlieViewModel.h"
#import "GuanzhuAnlieModel.h"
#import "AnlieNewDetilViewController.h"
@interface GuanzhuAnlieViewController (){
    NSInteger p;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) GuanzhuAnlieViewModel *viewModel;

@end

@implementation GuanzhuAnlieViewController


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
    [self.viewModel.selectItemSubject subscribeNext:^(AnliGuanzhuModel *x) {
        @strongify(self);
        AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
        vc.anlieID = x.id;
        [self pushToNextVCWithNextVC:vc];
    }];
	
	// 	取消关注
	[self.viewModel.cancelFocusItemSubject subscribeNext:^(AnliGuanzhuModel *x) {
		
		[[RequestManager sharedManager] requestUrl:URL_New_anliequxiaoguanzhu
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"取消成功"];
												   [self.table.mj_header beginRefreshing];
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"取消关注失败"];
										   }];
	}];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"GuanzhuAnlieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GuanzhuAnlieTableViewCell"];
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
        p = 1;;
        //传入参数 进行刷新
		[self.viewModel.refreshDataCommand execute:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
													 @"type":@"3",
													 @"p":@(p)}];
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
					[self.viewModel.refreshDataCommand execute:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
																 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
																 @"type":@"3",
																 @"p":@(p)}];
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
- (GuanzhuAnlieViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GuanzhuAnlieViewModel alloc] init];
    }
    return _viewModel;
}


@end
