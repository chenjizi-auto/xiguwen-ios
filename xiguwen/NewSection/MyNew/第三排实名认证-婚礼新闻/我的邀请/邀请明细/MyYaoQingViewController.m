//
//  MyYaoQingViewController.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyYaoQingViewController.h"
#import "MyYaoQingViewModel.h"
#import "MyYaoQingModel.h"
#import "MOFSPickerManager.h"
@interface MyYaoQingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyYaoQingViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIButton *beforeBtn;
@property (weak, nonatomic) IBOutlet UIButton *afterBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation MyYaoQingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"邀请明细";
	[self.view setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}


#pragma mark - 点击事件

- (IBAction)before:(UIButton *)sender {
	// 点击进入前一天
	self.showDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.showDate];
	[self.table.mj_header beginRefreshing];
}

- (IBAction)after:(UIButton *)sender {
	// 点击进入后一天
	self.showDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:self.showDate];
	[self.table.mj_header beginRefreshing];
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
//    [self.viewModel.selectItemSubject subscribeNext:^(MyYaoQingModel *x) {
//        @strongify(self);
//    }];
	
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api

- (IBAction)selectedTime:(UIButton *)sender {
	// 点击日期实现时间选择功能
	WeakSelf(self);
	[[MOFSPickerManager shareManger] showDatePickerWithTag:0 commitBlock:^(NSDate * _Nonnull date) {
		// 转换时间并且刷新数据
		weakSelf.showDate = date;
		[weakSelf.table.mj_header beginRefreshing];
	} cancelBlock:^{
		
	}];
	
	
}

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyYaoQingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyYaoQingTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
	
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		// 将NSDate转换为时间戳
		NSInteger timeStamp = [self.showDate timeIntervalSince1970];
        @strongify(self);
        //传入参数 进行刷新
		[self.viewModel.refreshDataCommand execute:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
													 @"time":@(timeStamp)}];
		// 时间戳1520524800可用
		// 格式化时间
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy年MM月dd日"];
		NSString *showStr = [formatter stringFromDate:self.showDate];
		self.timeLabel.text = showStr;
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载 忽略上拉加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//					[self.viewModel.refreshDataCommand execute:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
//																 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
//																 @"time":@(1520524800)}];
//                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 200) {
            
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
- (MyYaoQingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyYaoQingViewModel alloc] init];
    }
    return _viewModel;
}


@end
