//
//  YaoQingNewchengyuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "YaoQingNewchengyuanViewController.h"
#import "YaoQingNewchengyuanViewModel.h"
#import "YaoQingNewchengyuanModel.h"
@interface YaoQingNewchengyuanViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) YaoQingNewchengyuanViewModel *viewModel;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *url;

@end

@implementation YaoQingNewchengyuanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"邀请新成员";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
	self.keyword = @"";
	
	// 请求分享URl
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_associationsCenterInviteMemberList
										method:POST 
										loding:@""
										   dic:@{@"id":@(self.model.id),
												 @"name":self.keyword,
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.url = response[@"url"];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
									   }];
	
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(YaoQingNewchengyuanModel *x) {
        @strongify(self);
    }];
	
	// 邀请加入
	[self.viewModel.inviteItemSubject subscribeNext:^(YaoQingNewchengyuanModel *x) {
		
		[[RequestManager sharedManager] requestUrl:URL_associationsCenterInviteMember
											method:POST
											loding:@""
											   dic:@{@"id":@(self.model.id),
													 @"yid":@(x.userid),
													 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"邀请成功"];
												   [self.table.mj_header beginRefreshing];
											   } else {
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"邀请失败"];
										   }];
	}];
	
	
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api

- (IBAction)inviteShare:(UIButton *)sender {
	NSArray *array = @[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ)];
	
	// 分享按钮点击事件
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建网页内容对象
//	NSString* thumbURL =  self.model.cover;
	UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"我用喜GO创建了“%@”",self.model.name] descr:@"邀请你加入，最好用的婚礼人工具，我们在喜GO等你哦！" thumImage:@""];
	//设置网页地址
	shareObject.webpageUrl = self.url;
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	WeakSelf(self);
	[[UMSocialManager defaultManager] shareToPlatform:[array[sender.tag-1] integerValue] messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			DLog(@"************Share fail with error %@*********",error);
			[NavigateManager showMessage:@"分享失败！"];
		}else {
			
			//                [CwShareManager shareSuccess:2];
			if ([data isKindOfClass:[UMSocialShareResponse class]]) {
				UMSocialShareResponse *resp = data;
				[NavigateManager showMessage:@"分享成功！"];
				//分享结果消息
				UMSocialLogInfo(@"response message is %@",resp.message);
				//第三方原始返回的数据
				UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
				
			}else{
				UMSocialLogInfo(@"response data is %@",data);
			}
		}
		//            if(completion) {
		//                completion(data,error);
		//            }
		
	}];
	
}

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"YaoQingNewchengyuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YaoQingNewchengyuanTableViewCell"];
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
- (YaoQingNewchengyuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YaoQingNewchengyuanViewModel alloc] init];
    }
    return _viewModel;
}


@end
