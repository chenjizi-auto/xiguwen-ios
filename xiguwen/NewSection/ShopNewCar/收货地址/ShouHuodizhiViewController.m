//
//  ShouHuodizhiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShouHuodizhiViewController.h"
#import "ShouHuodizhiViewModel.h"
#import "ShouHuodizhiModel.h"
#import "GuanliAddressViewController.h"
@interface ShouHuodizhiViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShouHuodizhiViewModel *viewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation ShouHuodizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    [self addRightBtnWithTitle:@"管理" image:nil];
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table.mj_header beginRefreshing];
}

- (void)respondsToRightBtn {
    GuanliAddressViewController *guanli = [[GuanliAddressViewController alloc] init];
    [self pushToNextVCWithNextVC:guanli];
}

#pragma mark - 点击事件
- (void)cellClick {
    __weak typeof(self)weakSelf = self;
    [self.viewModel.selectItemSubject subscribeNext:^(ShouHuodizhiModel *x) {
        if (weakSelf.didGetModel) {
            weakSelf.didGetModel((Addressarray *)x);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    [self.table registerNib:[UINib nibWithNibName:@"ShouHuodizhiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShouHuodizhiTableViewCell"];
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
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [self.viewModel.refreshDataCommand execute:dic];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
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
- (ShouHuodizhiViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShouHuodizhiViewModel alloc] init];
    }
    return _viewModel;
}


@end
