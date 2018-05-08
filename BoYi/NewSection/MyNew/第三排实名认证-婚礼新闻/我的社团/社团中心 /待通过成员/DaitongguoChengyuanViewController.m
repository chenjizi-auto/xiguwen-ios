//
//  DaitongguoChengyuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DaitongguoChengyuanViewController.h"
#import "DaitongguoChengyuanViewModel.h"
#import "DaitongguoChengyuanModel.h"
@interface DaitongguoChengyuanViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) DaitongguoChengyuanViewModel *viewModel;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, assign) NSInteger page;

@end

@implementation DaitongguoChengyuanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"待通过成员";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
	
	self.keyword = @"";
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(DaitongguoChengyuanModel *x) {
        @strongify(self);
    }];
	
	// 同意
	[self.viewModel.agreeItemSubject subscribeNext:^(DaitongguoChengyuanModel *x) {
		[[RequestManager sharedManager] requestUrl:URL_associationsCenterAgreeMember
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"通过成功"];
												   [self.table.mj_header beginRefreshing];
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"通过失败"];
										   }];
	}];
	// 拒绝
	[self.viewModel.refuseItemSubject subscribeNext:^(DaitongguoChengyuanModel *x) {
		[[RequestManager sharedManager] requestUrl:URL_associationsCenterRefuseMember
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"拒绝成功"];
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

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"DaitongguoChengyuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DaitongguoChengyuanTableViewCell"];
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
		[self.viewModel.refreshDataCommand execute:@{@"id":@(self.model.id),
													 @"name":self.keyword,
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
					[self.viewModel.refreshDataCommand execute:@{@"id":@(self.model.id),
																 @"name":self.keyword,
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	self.keyword = textField.text;
	[self.table.mj_header beginRefreshing];
	return YES;
}

//初始化viewModel
- (DaitongguoChengyuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DaitongguoChengyuanViewModel alloc] init];
    }
    return _viewModel;
}


@end
