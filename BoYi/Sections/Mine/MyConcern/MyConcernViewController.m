//
//  MyConcernViewController.m
//  BoYi
//
//  Created by Chen on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyConcernViewController.h"
#import "MyConcernViewModel.h"
#import "FindDetailViewController.h"
//#import "peopleDetailViewController.h"
#import "NewPeopleDetilViewController.h"

@interface MyConcernViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyConcernViewModel *viewModel;
@property (assign,nonatomic) NSInteger curPage;
@end

@implementation MyConcernViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    [self addPopBackBtn];
    [self setupTableView];
    [self cellClick];
    [self.table.mj_header beginRefreshing];
    
}


#pragma mark - 点击事件
- (void)cellClick {
    
    
    [self.viewModel.selectItemSubject subscribeNext:^(MyConcernModel *x) {
        @weakify(self);
        [[[RequestManager sharedManager] RACRequestUrl:URL_deleteUserFollowById
                                               method:POST
                                               loding:@"加载中..."
                                                  dic:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                        @"followuserid":@(x.followuserid)}] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [NavigateManager showMessage:@"操作成功"];
            [self.table.mj_header beginRefreshing];
        }];
    }];
    @weakify(self);
    [self.viewModel.selectdetialItemSubject subscribeNext:^(MyConcernModel *x) {
        
        @strongify(self);
        NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
        people.userId = [NSString stringWithFormat:@"%ld",x.followuserid];
        [self pushToNextVCWithNextVC:people];
        
    }];
    [self.viewModel.selectdetialItemSubjectAL subscribeNext:^(MyConcernModel *x) {
        
        @strongify(self);
        FindDetailViewController *find = [[FindDetailViewController alloc] init];
        find.hidesBottomBarWhenPushed = YES;
       
        find.idString = [NSString stringWithFormat:@"%ld",(long)x.followuserid];
        [self pushToNextVCWithNextVC:find];
       
    }];
}


#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    if (self.isShop) {
        [self.table registerNib:[UINib nibWithNibName:@"MyConcernShopTableViewCell"
                                               bundle:[NSBundle mainBundle]]
                               forCellReuseIdentifier:@"MyConcernShopTableViewCell"];
    } else {
        [self.table registerNib:[UINib nibWithNibName:@"MyConcernTableViewCell"
                                               bundle:[NSBundle mainBundle]]
                               forCellReuseIdentifier:@"MyConcernTableViewCell"];
    }
    
    //[self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
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
        if (!self.isShop) {
            //传入参数 进行刷新
            [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                         @"pageNum":@10,
                                                         @"page":@(self.curPage)}];
        } else {
            //传入参数 进行刷新
            [self.viewModel.GetShopDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                         @"pageNum":@10,
                                                         @"page":@(self.curPage)}];
        }
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x[@"followList"] isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                
                @weakify(self);
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    
                    @strongify(self);
                    self.curPage ++;
                    if (!self.isShop) {
                        //传入参数 进行刷新
                        [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                                     @"pageNum":@10,
                                                                     @"page":@(self.curPage)}];
                    } else {
                        //传入参数 进行刷新
                        [self.viewModel.GetShopDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                                     @"pageNum":@10,
                                                                     @"page":@(self.curPage)}];
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
    //异常
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
       
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    
}

//初始化viewModel
- (MyConcernViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyConcernViewModel alloc] init];
        _viewModel.isShop = _isShop;
    }
    return _viewModel;
}


@end
