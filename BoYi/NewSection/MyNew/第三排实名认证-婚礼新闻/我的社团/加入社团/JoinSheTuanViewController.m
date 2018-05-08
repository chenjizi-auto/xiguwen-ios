//
//  JoinSheTuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/16.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JoinSheTuanViewController.h"
#import "JoinSheTuanViewModel.h"
//#import "JoinSheTuanModel.h"
#import "ShetuanModel.h"
#import "TuanDuiCenterViewController.h"
#import "MyNewViewController.h"
#import "sheTuanDetilViewController.h"

@interface JoinSheTuanViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) JoinSheTuanViewModel *viewModel;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, assign) NSInteger page;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *searchTF;

@end

@implementation JoinSheTuanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"加入团队";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
	self.keyword = @"";
    self.searchTF.delegate = self;
    self.searchTF.inputAccessoryView = [self addToolbar];

}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
	// 选中某个社团
    [self.viewModel.selectItemSubject subscribeNext:^(Shetuan *x) {
        @strongify(self);
		// 进入团队主页/不是进入团队中心
//        TuanDuiCenterViewController *tuan = [[TuanDuiCenterViewController alloc] init];
//		tuan.model = x;
//        [self pushToNextVCWithNextVC:tuan];
		ShetuanDetilViewController *vc = [[ShetuanDetilViewController alloc] init];
		vc.id = x.id;
		[self pushToNextVCWithNextVC:vc];
    }];
	// 加入/退出/同意 某个社团
	[self.viewModel.joinItemSubject subscribeNext:^(Shetuan *x) {
		NSString *url;
		if (x.status == 0) {
			url = URL_applyAssociations;
		} else if (x.status == 1) {
			url = URL_exitAssociations;
		} else if (x.status == 3) {
			url = URL_agreeAssociations;
		}
		
		[[RequestManager sharedManager] requestUrl:url
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [self.table.mj_header beginRefreshing];
												   [NavigateManager showMessage: @"操作成功"];
//												   [self jump];
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"操作失败"];
										   }];
	}];
	
	// 拒绝某个社团的邀请
	[self.viewModel.refusedItemSubject subscribeNext:^(Shetuan *x) {
		
		[[RequestManager sharedManager] requestUrl:URL_refusedAssociations
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [self.table.mj_header beginRefreshing];
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"拒绝失败"];
										   }];
	}];
	
	
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

- (void)jump {
	MyNewViewController *myIMPVC = nil;
	for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
		
		MyNewViewController *cv = self.navigationController.viewControllers[i];
		if ([cv isKindOfClass:[MyNewViewController class]]) {
			myIMPVC = (MyNewViewController *)cv;
			break;
		}
	}
	[self.navigationController popToViewController:myIMPVC animated:YES];
//	[myIMPVC refreshData];
}

#pragma mark - public api

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"JoinSheTuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JoinSheTuanTableViewCell"];
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
		_page = 1;
		[self.viewModel.refreshDataCommand execute:@{@"name":self.keyword,
													 @"p":@(self.page),
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
					[self.viewModel.refreshDataCommand execute:@{@"name":self.keyword,
																 @"p":@(self.page),
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
- (JoinSheTuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JoinSheTuanViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - 点击搜索的代理事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	self.keyword = self.searchTF.text;
	
//	if (self.keyword.length <= 0) {
//		[NavigateManager showMessage:@"请填写搜索关键字"];
//	} else {
		[textField resignFirstResponder];
		[self.table.mj_header beginRefreshing];
//	}
	
	return YES;
}


@end
