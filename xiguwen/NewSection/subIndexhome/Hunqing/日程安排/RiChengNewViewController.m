//
//  RiChengNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "RiChengNewViewController.h"
#import "RiChengNewViewModel.h"
#import "RiChengNewModel.h"
#import "RichengHeaderView.h"
#import "NewMakeRichengViewController.h"
#import "NewMakeRichengViewController.h"

@interface RiChengNewViewController (){
    NSString *_riqi;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) RiChengNewViewModel *viewModel;

@end

@implementation RiChengNewViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.table.mj_header beginRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"日程安排";
    _riqi = [self getCurrentTime];
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    
	self.table.estimatedRowHeight = 80.f;
	self.table.rowHeight = UITableViewAutomaticDimension;
}
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(RiChengNewModel *x) {
        @strongify(self);
    }];
	
	// 删除某个安排
	[self.viewModel.deleteItemSubject subscribeNext:^(Newrichengarray *x) {
		[[RequestManager sharedManager] requestUrl:URL_deleteMyRicheng
											method:POST
											loding:@""
											   dic:@{@"id":@(x.id),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"删除我的日程成功"];
												   [self.table.mj_header beginRefreshing];
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"删除我的日程失败"];
										   }];
		
	}];
	
	// 修改某个安排状态
	[self.viewModel.statusItemSubject subscribeNext:^(Newrichengarray *x) {
		
		[[RequestManager sharedManager] requestUrl:URL_editMyRichengStatus
											method:POST
											loding:@""
											   dic:@{@"status":@(x.isend == 1 ? 2 : 1),
													 @"id":@(x.id),
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
											   [NavigateManager showMessage:@"修改失败"];
										   }];
		
	}];
	
	// 重新编辑安排信息
	[self.viewModel.editItemSubject subscribeNext:^(Newrichengarray *x) {
		// 跳转新建页面
		NewMakeRichengViewController *vc = [[NewMakeRichengViewController alloc] init];
		vc.isEdit = YES;
		vc.model = x;
		[self pushToNextVCWithNextVC:vc];
	}];
	
	
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"RiChengNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RiChengNewTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    RichengHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"RichengHeaderView" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 375);
    @weakify(self);
    [header.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        _riqi = x;
        [self.table.mj_header beginRefreshing];
    }];
    self.table.tableHeaderView = header;
 
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
//        [self.viewModel.refreshDataCommand execute:@{@"riqi":@"2018-01-06",@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@(16)}];
        [self.viewModel.refreshDataCommand execute:@{@"riqi":_riqi,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}];
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
- (IBAction)add:(UIButton *)sender {
    NewMakeRichengViewController *new = [[NewMakeRichengViewController alloc] init];
	new.isEdit = NO;
    [self pushToNextVCWithNextVC:new];
}

//初始化viewModel
- (RiChengNewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RiChengNewViewModel alloc] init];
    }
    return _viewModel;
}


@end
