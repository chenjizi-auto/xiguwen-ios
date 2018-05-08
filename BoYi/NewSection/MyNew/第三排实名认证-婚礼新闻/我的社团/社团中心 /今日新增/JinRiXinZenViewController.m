//
//  JinRiXinZenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/16.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JinRiXinZenViewController.h"
#import "JinRiXinZenViewModel.h"
#import "JinRiXinZenModel.h"
//#import "CwDatePiker.h"
#import "MOFSPickerManager.h"

@interface JinRiXinZenViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) JinRiXinZenViewModel *viewModel;
@property (nonatomic, strong) NSString *showTime;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, assign) NSInteger page;

@end

@implementation JinRiXinZenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"今日新增";
	[self.view setBackgroundColor:[UIColor whiteColor]];
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
	
	self.showTime = [[NSDate date] fs_stringWithFormat:@"yyyy-MM-dd"];
	[self.timeLabel setText:self.showTime];
    [self.table.mj_header beginRefreshing];
}
- (IBAction)action:(UIButton *)sender {
	WeakSelf(self);
	[[MOFSPickerManager shareManger] showDatePickerWithTag:0 commitBlock:^(NSDate * _Nonnull date) {
		weakSelf.showTime = [date fs_stringWithFormat:@"yyyy-MM-dd"];
		[weakSelf.timeLabel setText:weakSelf.showTime];
		[weakSelf.table.mj_header beginRefreshing];
	} cancelBlock:^{
	}];
}


#pragma mark - 点击事件

- (IBAction)before:(UIButton *)sender {
	// 上一天
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[formatter dateFromString:self.showTime]];
	self.showTime = [date fs_stringWithFormat:@"yyyy-MM-dd"];
	[self.timeLabel setText:self.showTime];
	[self.table.mj_header beginRefreshing];
}
- (IBAction)after:(UIButton *)sender {
	// 下一天
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *date = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[formatter dateFromString:self.showTime]];
	self.showTime = [date fs_stringWithFormat:@"yyyy-MM-dd"];
	[self.timeLabel setText:self.showTime];
	[self.table.mj_header beginRefreshing];
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(JinRiXinZenModel *x) {
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"JinRiXinZenTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JinRiXinZenTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		_page = 1;
        @strongify(self);
        //传入参数 进行刷新
		[self.viewModel.refreshDataCommand execute:@{@"p":@(_page),
													 @"id":@(self.model.id),
													 @"datea":self.showTime,
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
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
				_page ++;
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
					[self.viewModel.refreshDataCommand execute:@{@"p":@(_page),
																 @"id":@(self.model.id),
																 @"datea":self.showTime,
																 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
																 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
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
- (JinRiXinZenViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JinRiXinZenViewModel alloc] init];
    }
    return _viewModel;
}


@end
