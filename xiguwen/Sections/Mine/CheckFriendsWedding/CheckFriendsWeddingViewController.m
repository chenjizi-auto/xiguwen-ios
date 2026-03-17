//
//  CheckFriendsWeddingViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "CheckFriendsWeddingViewController.h"
#import "CheckFriendsWeddingViewModel.h"
#import <PPGetAddressBook.h>

@interface CheckFriendsWeddingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) CheckFriendsWeddingViewModel *viewModel;
@property (strong,nonatomic)NSString *myFriendsString;
@property (assign,nonatomic)NSInteger curPage;
@end

@implementation CheckFriendsWeddingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"好友婚礼";
    [self addPopBackBtn];
    
    [self setupTableView];
    [self cellClick];
    
    
    self.curPage = 1;
    
    
    [PPGetAddressBook requestAddressBookAuthorization];
    
    __weak typeof(self) weakSelf = self;
    //获取没有经过排序的联系人模型
    [PPGetAddressBook getOriginalAddressBook:^(NSArray<PPPersonModel *> *addressBookArray) {
        
        if (addressBookArray.count > 0) {
            NSMutableArray *arr = [NSMutableArray array];
            for (PPPersonModel *model in addressBookArray) {
                if ([model.mobileArray count] > 0) {
                    [arr addObject:model.mobileArray.firstObject];
                }
            }
            weakSelf.myFriendsString = [arr componentsJoinedByString:@","];
            [weakSelf loadData:weakSelf.myFriendsString];
        }
        
        
    } authorizationFailure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许访问您的通讯录"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }];

//    [self.table.mj_header beginRefreshing];
}
- (void)loadData:(NSString *)friends {
    if (!self.myFriendsString) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许访问您的通讯录"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self.viewModel.refreshDataCommand execute:@{@"phone":friends,//@"18581882801",
                                                 @"pageSize":@10,
                                                 @"curPage":@(self.curPage)}];
    
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(CheckFriendsWeddingViewModel *x) {
        @strongify(self);
    }];
    
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        [NavigateManager showMessage:@"操作成功"];
//        [self.table.mj_header beginRefreshing];
//    }];
}


#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"CheckFriendsWeddingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CheckFriendsWeddingTableViewCell"];
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
        self.curPage = 1;
        //传入参数 进行刷新
        [self loadData:self.myFriendsString];
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
                    //传入参数 进行刷新
                    self.curPage++;
                    [self loadData:self.myFriendsString];
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
- (CheckFriendsWeddingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CheckFriendsWeddingViewModel alloc] init];
    }
    return _viewModel;
}


@end
