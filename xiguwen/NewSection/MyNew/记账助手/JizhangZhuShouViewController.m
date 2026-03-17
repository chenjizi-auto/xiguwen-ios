//
//  JizhangZhuShouViewController.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JizhangZhuShouViewController.h"
#import "JizhangZhuShouViewModel.h"
#import "JizhangZhuShouModel.h"
#import "AddJiZhangView.h"

@interface JizhangZhuShouViewController (){
    NSInteger time;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) JizhangZhuShouViewModel *viewModel;
@property(nonatomic,assign)NSInteger curPage;

@end

@implementation JizhangZhuShouViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self cellClick];
    [self setupTableView];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    self.yuelabel.text = currentDateStr;
    time = [NSString getNowTimestamp];
    
    [self.table.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    [self.table.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (IBAction)allAC:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else if (sender.tag == 1){
        __weak typeof(self) weakSelf = self;
		
		
		QFDatePickerView *datePickerView = [[QFDatePickerView alloc] initDatePackerWithResponse:^(NSString *str) {
			[weakSelf.yuelabel setText:str];
			time = [NSString timeSwitchTimestamp:str andFormatter:@"yyyy-MM"];
			[self.table.mj_header beginRefreshing];
		}];
		[datePickerView show];
		
		
		
//        [CwDatePiker showInView:weakSelf.view issele:YES block:^(NSDate *date) {
//
//            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM"];
//
//			[weakSelf.yuelabel setText:dateString];
////            [weakSelf.yuelabel setTitle:dateString forState:UIControlStateNormal];
//            time = [NSString timeSwitchTimestamp:dateString andFormatter:@"yyyy-MM"];
//        }];
    }else {
        __weak typeof(self) weakSelf = self;
		
        [AddJiZhangView showInView:weakSelf.view block:^(NSDictionary *dic) {
            
            
//            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
            
//            [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
//            [weakSelf.dicm setObject:dateString forKey:@"schedule_date"];
            [self.table.mj_header beginRefreshing];
        }];
        
    }
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(JizhangZhuShouModel *x) {
        @strongify(self);
    }];
	
	// 删除
	[self.viewModel.deleteItemSubject subscribeNext:^(Tianjizhang *x) {
		NSDictionary *dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"id":@(x.id),@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
		
		[[RequestManager sharedManager] requestUrl:URL_New_delericheng
											method:POST
											loding:@""
											   dic:dic
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [self.table.mj_header beginRefreshing];
											   }
											   
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   
											   [NavigateManager showMessage:@"删除失败"];
											   
										   }];
	}];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"JizhangZhuShouTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JizhangZhuShouTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _curPage = 1;
        @strongify(self);
		
        
		NSDictionary *dic = @{@"p":@(_curPage),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"shijian":@(time),@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
		DLog(@"%@",dic);
		
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"shijian":@(time),@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
//        [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"shijian":@(time),@"userid":@"16"}];
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
                    [self.viewModel.refreshDataCommand execute:@{@"p":@(_curPage),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"shijian":@(time),@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
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
		self.shouru.text = self.viewModel.shouruStr;
		self.zhichu.text = self.viewModel.zhichuStr;
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
- (JizhangZhuShouViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JizhangZhuShouViewModel alloc] init];
    }
    return _viewModel;
}


@end
