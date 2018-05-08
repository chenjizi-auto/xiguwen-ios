//
//  CaipaiTiixingViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "CaipaiTiixingViewController.h"
#import "CaipaiTiixingViewModel.h"
#import "CaipaiTiixingModel.h"
#import "CaipaiTiHeader.h"
#import "CaiPaiDateSele.h"

@interface CaipaiTiixingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) CaipaiTiixingViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray *remindArray;// 提醒数组

@end

@implementation CaipaiTiixingViewController

- (NSMutableArray *)remindArray {
	if (!_remindArray) {
		_remindArray = [[NSMutableArray alloc] init];
	}
	return _remindArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"保存提醒";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}


#pragma mark - 点击事件

- (IBAction)saveRemind:(UIButton *)sender {
	// 保存提醒实现(将提醒添加到数组)需要判断是修改还是新建
	
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(CaipaiTiixingModel *x) {
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"CaipaiTiixingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CaipaiTiixingTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    CaipaiTiHeader *header = [[NSBundle mainBundle]loadNibNamed:@"CaipaiTiHeader" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 324);
    self.table.tableHeaderView = header;
    
    [header.selectBtnSubject subscribeNext:^(id  _Nullable x) {
        //提醒
        __weak typeof(self) weakSelf = self;
        [CaiPaiDateSele showInView:weakSelf.view block:^(NSDate *date) {
            
            
            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
            
//            [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
//            [weakSelf.dicm setObject:dateString forKey:@"schedule_date"];
        }];
    }];
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{}];
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
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{}];
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
- (CaipaiTiixingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CaipaiTiixingViewModel alloc] init];
    }
    return _viewModel;
}


@end
